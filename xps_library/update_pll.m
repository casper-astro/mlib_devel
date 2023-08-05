function [] = update_pll(gcb, tile)

  % apply changes to RF-PLL parameter and ref clock list

  [gen, ~, ~, ~, ~, ~, ~] = get_rfsoc_properties(gcb);

  msk = Simulink.Mask.get(gcb);

  sample_rate_mhz = str2double(get_param(gcb, ['t', num2str(tile), '_', 'sample_rate']));

  if ~chk_param(gcb, ['t', num2str(tile),'_','enable_pll'], 'on')
    % set reference clock to desired sample rate and disable `ref_clk` field
    msk.getParameter(['t', num2str(tile), '_', 'ref_clk']).TypeOptions = {num2str(sample_rate_mhz)};
    set_mask_params(gcb, ['t', num2str(tile), '_', 'ref_clk'], num2str(sample_rate_mhz));
    msk.getParameter(['t', num2str(tile), '_', 'ref_clk']).Enabled = 'off';
  else
    % compute usable PLL reference frequencies
    [M, VCO] = calc_rfpll_vco(gen, sample_rate_mhz);
    if isempty(VCO)
      error('RFPLL parameters could not be resolved to determine a valid ref. clock freq.');
    end

    % select the first one
    m = M(1);
    vco = VCO(1);

    % DS926 states that the clock divider parameter R has only been tested for a
    % value of 1 and is the only value recommended for use
    [fbdiv, refclk] = calc_refclk(vco, 1);

    % set a default value for the refclk to be sample_rate_mhz/8.0 or
    % if not available then something arbitrarily on the low end of the range
    I = find(refclk <= sample_rate_mhz/8.0);
    if isempty(I)
      I = find(refclk <= 130.00); % arbitrary, should change to target a valid one in fbdiv range
    end
    n = fbdiv(I(1));
    f = refclk(I(1));
    % TODO: there is only a specific range of suggested tested frequencies for
    % the fbdiv parameter that is tested within the specification given on
    % DS926. These should be the ones that Vivado displays a warning when
    % selected. Extend the same warning here. Need to figure out that range.

    refclk_list = compose('%g', refclk);
    msk.getParameter(['t', num2str(tile), '_', 'ref_clk']).Enabled = 'on';

    % Simulink runs all callbacks sequentially when opening the mask dialog. So
    % the list of refclks and user selected value would be overwritten when
    % opening if the TypeOptions are reset each time.
    % So, only update the PLL if the list of refclk is not up to date. There is
    % probably a smarter way to organize all the logic to be more efficent.
    % TODO: this is the same as in `update_adc_clkout.m`
    current_refclk_list = msk.getParameter(['t', num2str(tile), '_', 'ref_clk']).TypeOptions;
    if ~isempty( setdiff(current_refclk_list, refclk_list) )
      msk.getParameter(['t', num2str(tile), '_', 'ref_clk']).TypeOptions = refclk_list;
      % TODO: not sure why after disabling the PLL and re-enabling it that this
      % `ref_clk` value of `f` is not being applied in the mask popup, but
      % changing the sample rate has the correct behavior
      set_mask_params(gcb, ['t', num2str(tile), '_', 'ref_clk'], num2str(f));
    end

  end
end

