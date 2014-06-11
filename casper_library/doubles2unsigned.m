% doubles2unsigned(blk, varargin)
%
% blk = The block to be configured.
% varargin = {'varname', 'value', ...} pairs
%
% Valid varnames for this block are:

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                             %
%   Karoo Array Telesope                                                      %
%   http://www.kat.ac.za                                                      %
%   Copyright (C) 2013 Andrew Martens                                         %
%                                                                             %
%   This program is free software; you can redistribute it and/or modify      %
%   it under the terms of the GNU General Public License as published by      %
%   the Free Software Foundation; either version 2 of the License, or         %
%   (at your option) any later version.                                       %
%                                                                             %
%   This program is distributed in the hope that it will be useful,           %
%   but WITHOUT ANY WARRANTY; without even the implied warranty of            %
%   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the             %
%   GNU General Public License for more details.                              %
%                                                                             %
%   You should have received a copy of the GNU General Public License along   %
%   with this program; if not, write to the Free Software Foundation, Inc.,   %
%   51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.               %
%                                                                             %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function[dout, result] = doubles2unsigned(din, n_bits, bin_pt, max_word_size),
  log_group = 'doubles2unsigned_debug';
  dout = [];
  result = -1;
 
  [r,c] = size(din);  

  [rnb, cnb] = size(n_bits);
  [rbp, cbp] = size(bin_pt);
  if cnb ~= cbp,
    clog('Number of bits and binary point vectors must be the same dimensions',{'error', log_group});
    error('Number of bits and binary point vectors must be the same dimensions');
  end  

  %fluff out n_bits and bin_pt vectors
  if cnb == 1,
    n_bits = repmat(n_bits, 1, c);
    bin_pt = repmat(bin_pt, 1, c);
  end  

  if max_word_size > 64,
    clog('We can''t generate a bit width greater than 64 bits',{'error', log_group});
    error('We can''t generate a bit width greater than 64 bits');
  end

  cols_int = zeros(r,c);

  %go through all columns
  for col_index = 1:c,

    col = din(:,col_index);
    c_bin_pt = bin_pt(1, col_index);
    c_n_bits = n_bits(1, col_index);

    step    = 2^(-1*c_bin_pt);

    %max, min and step values representable with specified output
    top_bits  = c_n_bits;
    top       = 2^(top_bits-c_bin_pt-1) - step;
    bottom    = -1*2^(top_bits-c_bin_pt-1);  

    clog(['bottom: ', num2str(bottom), ' step: ', num2str(step), ' top: ', num2str(top)], log_group);

    %quantise
    col_quantised = round(col./step).*step;

    %saturate max values to prevent wrapping
    smax_i = find(col_quantised > top);
    smin_i = find(col_quantised < bottom);
    col_saturated = col_quantised;
    
    col_saturated(smax_i) = top;
    col_saturated(smin_i) = bottom;

    col_wrapped = col_saturated;
   
    %wrap negative values 
    ni = find(col_wrapped < 0);

    for n = 1:length(ni),
      col_wrapped(ni(n)) = (top + step)*2 + col_wrapped(ni(n)); 
    end %for
   
    %shift up so no fractional part
    col_int = (2^c_bin_pt).*col_wrapped;

    cols_int(:, col_index) = col_int;
  end

  %create some space for final shifting (double only has 52 bits of precision)
  cols_u64 = uint64(cols_int);
  shift_offset = 0;               %track how much to shift by
  bits = 0;                       %current bits in word
  word = zeros(r, 1, 'uint64');   %current word
  raw = zeros(r, 1, 'uint64');    %word still to be processed
  raw_bits = 0;                   %raw bits still to be processed
  words_required = ceil((sum(n_bits))/max_word_size); %number of words required 
  clog(['need ',num2str(words_required),' words to accomodate ', num2str(sum(n_bits)), ' values in ', num2str(max_word_size), ' bit words'], log_group);
  cols_shifted = zeros(r, words_required, 'uint64');
  word_count = 0;

  for n = 1:c,
    clog(mat2str(dec2bin(cols_u64(:,n))), log_group);
  end

  %go through all vectors
  for vi = 1:c,                     
    c_n_bits = n_bits(c-vi+1);

    raw = cols_u64(:,c-vi+1);                  % start with the column of values to add
    clog([num2str(bits) ' + shift of ',num2str(c_n_bits),' for a total of ',num2str(bits+c_n_bits),' bits'], log_group);
    raw_bits = c_n_bits;

    %go through till we have processed all raw_bits
    while raw_bits > 0,

      %we are about to equal or exceed the maximum word size when we add the column
      if (bits + raw_bits) >= max_word_size,
        clog(['adding word'], log_group);
        safe = max_word_size - bits;
        extra = raw_bits - safe;
        clog(['Adding ',num2str(safe), ' bits to word'], log_group);
        %keep bottom bits
        col = bitand(raw, (2^safe)-1);
        %shift them up
        clog(['shifting up by ', num2str(bits)], log_group);
        col = bitshift(col, bits);
        %add to the current word
        word = word + col;
        
        %store word created
        dest = words_required - word_count;
        clog(['storing word at ', num2str(dest)], log_group);
        cols_shifted(:, dest) = word;
        word_count = word_count+1;
        raw_bits = extra;
        bits = 0;
        word = zeros(r, 1, 'uint64');

        %shift down top bits
        if (raw_bits > 0),
          %shift down left-over top bits
          clog(['shifting left over down by ', num2str(safe)], log_group);
          col = bitshift(raw, -1*safe);
          %cut off top bits
          if ((2^extra)-1 < 2^52), clog(['masking with 0x', dec2hex((2^extra)-1)], log_group);
          end
          raw = bitand(col, (2^extra)-1);
          raw_bits = extra;
        end

        clog(['After adding have ',num2str(bits),' bits and ',num2str(word_count),' words'], log_group);         

      end %if

      %we have a fraction left that will not fill a word
      if ((raw_bits > 0) && ((bits + raw_bits) < max_word_size)),
        clog(['handling ', num2str(raw_bits), ' bits'], log_group);

        %shift raw up 
        clog(['shifting up by ', num2str(bits)], log_group);
        col = bitshift(raw, bits);
        %tag the extra bits onto the current word
        word = col + word;

        bits = bits + raw_bits;
        raw_bits = 0;
      end %if

    end %while

    %if we have processed the last column, store any left overs
    if (vi == c && bits ~= 0),
      clog(['handling last ', num2str(bits),' bits of columns'], log_group);
      cols_shifted(:, ceil((sum(n_bits))/max_word_size)-word_count) = word;
    end %if

  end %for  

  [r,c] = size(cols_shifted);
  for n = 1:c,
    clog(mat2str(dec2bin(cols_shifted(:,n))), log_group);
  end  

  dout = cols_shifted;
 
  result = 0;

end %function
