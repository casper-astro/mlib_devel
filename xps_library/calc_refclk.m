function [fbdiv, refclk] = calc_refclk(vco, R)
  % differs from the implementation in `validate_rfdc_clocking.m` by returning
  % the fbdiv values
  % Calculate valid input reference clock frequency's for a given VCO

  refclk_min = 102.406;
  refclk_max = 1230.0;

  refclk = [];
  fbdiv = [];
  n = 13;
  while (n < 256)
    fin = vco*(R/n);
    fin = round(fin, 3);
    if (fin <= refclk_max)
      if (fin >= refclk_min)
        refclk = [refclk, fin];
        fbdiv = [fbdiv, n];
      else
        break;
      end
    end
    n = n+1;
  end

end
