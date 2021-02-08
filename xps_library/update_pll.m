function [] = update_pll(gcb)
  display('update_pll');
  % apply changes to RF-PLL

  % TODO need to get access to these
  gen = 3;

  msk = Simulink.Mask.get(gcb);

  sample_rate_mhz = str2double(get_param(gcb, 'sample_rate'));

  if ~chk_param(gcb, 'enable_pll', 'on')
    % set reference clock to desired sample rate and disable `ref_clk` field
    msk.getParameter('ref_clk').TypeOptions = {num2str(sample_rate_mhz)};
    set_param(gcb, 'ref_clk', num2str(sample_rate_mhz));
    msk.getParameter('ref_clk').Enabled = 'off';
  else
    % compute usable PLL reference frequencies
    % [m, vco, fbdiv, refclk] = update_pll_params(gcb);
    [M, VCO] = calc_rfpll_vco(gen, sample_rate_mhz);
    if isempty(VCO)
      error('RFPLL parameters could not be resolved to determine a valid reference clock frequency');
    end

    % select the first one
    m = M(1);
    vco = VCO(1);

    % DS926 states that the clock divider parameter R has only been tested for a
    % value of 1 and is the only value recommended for use
    [fbdiv, refclk] = calc_refclk(vco, 1);

    % set a default value for the refclk to be sample_rate_mhz/8.0 or
    % if not arbitrarily on the low end
    I = find(refclk <= sample_rate_mhz/8.0);
    if isempty(I)
      I = find(refclk <= 130.00);
    end
    n = fbdiv(I(1));
    f = refclk(I(1));
    % TODO: there is only a specific range of suggested tested frequencies for
    % the fbdiv parameter that is tested within the specification given on
    % DS926. These should be the ones that Vivado displays a warning when
    % selected. Extend the same warning here. Need to figure out that range.

    refclk_list = compose('%g', refclk);
    msk.getParameter('ref_clk').Enabled = 'on';
    msk.getParameter('ref_clk').TypeOptions = refclk_list;
    % TODO: not sure why after disabling the PLL and re-enabling it that this
    % `ref_clk` value of `f` is not being applied in the mask popup
    set_param(gcb, 'ref_clk', num2str(f));

  end



end
