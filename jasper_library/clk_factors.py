def clk_factors (clk_freq, target_freq, vco_min=650.0, vco_max=1150):
    """
    PLLs/MMCM VCOs freq have a constrained target frequency range

    The vco_min/max defaults are legacy from virtex 6 with the following note:
    The vco is required to be between 600 and 1200 for the -1
    speed grade vitrex 6, but it was found being close to the boundaries
    causes issues, so the VCO is constrained to between 650 and 1150.
    """

    bestM  = 1
    bestD  = 1
    bestDD = 1
    bestDiff = 1000
    Period = 1
    PeriodHalf = 1

    # the Multiply value is a even number because we need to divide by 1/2 of
    # it to get the 200MHz clock, which is used for the QDR.
    M = list(range(8,65,2))
    D = list(range(2,128,1))
    # If the input clock freq >= 315 then DD cant be 3 or 4.
    if clk_freq >= 315:
        DD = list(range(5,81,1))
    else:
        DD = list(range(1,81,1))
    # x = [x 100*M(i)/D(j)/DD(k)];
    for i in M:
        for j in D:
            for k in DD:
                if (clk_freq*i/k < vco_max and clk_freq*i/k > vco_min):
                    diff = abs(clk_freq*i/j/k - target_freq);
                    if diff < bestDiff:
                         bestDiff = diff;
                         bestM  = i;
                         bestD  = j;
                         bestDD = k;

    closest_freq = clk_freq * bestM / bestD / bestDD;
    sys_clk_VCO = bestM * clk_freq / bestDD;
    Periodns = (1/closest_freq)*1e3;
    PeriodHalfns = Periodns/2;


    #print closest_freq
    #print sys_clk_VCO
    #print Period
    #print PeriodHalf

    return float(bestM), float(bestD), bestDD, float(Periodns), float(PeriodHalfns)

#print clk_factors(200,161)
