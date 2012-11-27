% This function uses the input clock frequence and the target freq to calculate
% the correct multiply and divide factors for the MMCM. Specifically for ROACH2
% This is implemented by creating a 3D matrix of all possible values and 
% finding the one that closest matches the requirements.


function [bestM, bestD, bestDD] = clk_factors(clk_freq, target_freq)
     
     bestM = 0;
     bestD = 0;
     bestDD = 0;

     % the Multiply value is a even number because we need to divide by 1/2 of
     % it to get the 200MHz clock, which is used for the QDR.
     M  = (8:2:64);
     D  = (2:1:128);
     % If the input clock freq >= 315 then DD cant be 3 or 4.
     if (clk_freq >= 315)
         DD = (5:1:80);
     else
         DD = (1:1:80);
     end
     best_diff = 1000;
     for i = 1:length(M)
         for j = 1:length(D)
             for k = 1:length(DD)
                 %x = [x 100*M(i)/D(j)/DD(k)];
                 % the VCO freq must be between 600 and 1200 for the -1 speed 
                 % grade vitrex 6, but we found being on the boundaries causes
                 % issues, so we are using 650 -> 1150.
                 if (clk_freq*M(i)/DD(k) < 1150 && clk_freq*M(i)/DD(k) > 650)
                     diff = abs(clk_freq*M(i)/D(j)/DD(k) - target_freq);
                     if diff < best_diff
                         best_diff = diff;
                         bestM  = M(i);
                         bestD  = D(j);
                         bestDD = DD(k);
                     end
                 end
             end
         end
     end
     
     closest_freq = clk_freq * bestM / bestD / bestDD;
     sys_clk_VCO = bestM * clk_freq / bestDD;
