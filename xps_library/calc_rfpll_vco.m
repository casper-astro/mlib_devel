function [M, VCO] = calc_rfpll_vco(gen, sample_rate_mhz)
  % differs from `calc_rfpll_param` slightly in how the parameters are passed
  % (notably sample rate and rfsoc gen) as part of how to segment the UI process
  %
  % Calculate and return a list possible PLL multiplier values (output divider)
  % and the associate vco frequencies.
  %
  % PG269 (v2.4) pg. 146 and DS926 v1.11 tables 134-146 for PLL parameters
  % 
  % param: struct rfdc - current RFDC configuration

  vco_min = 8500.0;
  if gen < 2
    vco_max = 13112.0;
  else
    vco_max = 13200.0;
  end

  M = [];
  VCO = [];
  for m=[2, 3, 4:2:64]
    %vco = (samp_rate_ghz*1000.0)*m;
    vco = sample_rate_mhz*m;
    if (vco >= vco_min)
      if (vco <= vco_max)
        VCO = [VCO, vco];
        M = [M, m];
      else
        break;
      end
    end
  end

end
