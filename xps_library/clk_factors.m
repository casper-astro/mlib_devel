% This function uses the input clock frequence and the target IP freq to 
% calculate the correct multiply and divide factors for the MMCM. Specifically
% for roach 2.
% A 200Mhz clock is requried for the QDR calibration and the divide factor for
% this is also calulated (The multiply is global to all MMCM outputs)

function [bestM, bestD] = clk_factors(clk_freq, target_freq)
     
     bestM = 0;
     bestD = 0;
     
     M = (6:2:64);
     D = (2:1:64);
     best_diff = 100;
     for i = 1:length(M)
         for j = 1:length(D)
             diff = abs(clk_freq*M(i)/D(j)-target_freq);
             if diff < best_diff
                 best_diff = diff;
                 bestM = M(i);
                 bestD = D(j);
             end
         end
     end
     
     best_freq = clk_freq * bestM / bestD;

