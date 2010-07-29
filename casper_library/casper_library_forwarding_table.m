function clft = casper_library_forwarding_table
% Returns a forwarding table suitable for use with casper_library.mdl.
% 
% This script is intended to make it easier to rearrange the casper_library
% library.  "clft" is a cell array of two-element cell arrays, each of
% which specifies the old and new path of a block that has moved.
%
% To update the forwarding table of casper_library.mdl, simply run...
%
% set_param('casper_library','ForwardingTable',casper_library_forwarding_table);
%
% ...which will completely overwrite the value of the ForwardingTable
% parameter of the casper_library library with the value returned by this
% function.
%
% Don't forget to unlock casper_library beforehand!
% Don't forget to save casper_library afterwards!

clft = ...
{ ...
{'casper_library/Sources/White Gaussian Noise','casper_library_sources/White Gaussian Noise'}, ...
{'casper_library/Sources/tt800_uprng','casper_library_sources/tt800_uprng'}, ...
{'casper_library/Sources/u2n','casper_library_sources/u2n'}, ...
};

end
    