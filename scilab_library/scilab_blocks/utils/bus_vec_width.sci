/* casper_library's "Bus" family blocks (bus_addsub, bus_mult, ...) take
   several mask parameters (n_bits_a, bin_pt_a, type_a, ...) as MATLAB
   vectors, one entry per packed sub-signal in the bus -- e.g. n_bits_a =
   "[8]" for a single 8-bit component, or "[8, 4]" for a 2-component bus.
   The Xcos port keeps this exact vector-string convention for its
   lineedit fields (so casper_library defaults like "[8]" paste in
   unchanged), and this helper computes a bus port's total physical width
   as the sum of its component widths, e.g. bus_vec_width("[8, 4]") = 12. */
function [total] = bus_vec_width(vecstr)
    v = evstr(vecstr);
    total = sum(v);
endfunction
