function [] = rfdc_system_clocking_config(gcb)
  % setup clocking tab for different platforms based on board layout. currently this is managed and ran by ADC Tile 0
  % `t224_has_adc_clk` parameter in the rfdc mask

  plat_blk = find_system(gcs, 'SearchDepth', 1, 'FollowLinks', 'on', 'LookUnderMasks', 'all', 'Tag', 'xps:xsg');
  [platform, ~] = xps_get_hw_plat(get_param(plat_blk{1},'hw_sys'));

  msk = Simulink.Mask.get(gcb);

  has_clk_param_str = 't%d_has_%s_clk';
  t224_has_clk = sprintf(has_clk_param_str, 224, 'adc');
  t225_has_clk = sprintf(has_clk_param_str, 225, 'adc');
  t226_has_clk = sprintf(has_clk_param_str, 226, 'adc');
  t227_has_clk = sprintf(has_clk_param_str, 227, 'adc');

  t228_has_clk = sprintf(has_clk_param_str, 228, 'dac');
  t229_has_clk = sprintf(has_clk_param_str, 229, 'dac');
  t230_has_clk = sprintf(has_clk_param_str, 230, 'dac');
  t231_has_clk = sprintf(has_clk_param_str, 231, 'dac');

  switch platform
    case 'rfsoc4x2'
      set_param(gcb, t224_has_clk, 'on');
      set_param(gcb, t225_has_clk, 'off');
      set_param(gcb, t226_has_clk, 'on');
      set_param(gcb, t227_has_clk, 'off');
      msk.getParameter(t224_has_clk).Enabled = 'off';
      msk.getParameter(t225_has_clk).Enabled = 'off';
      msk.getParameter(t226_has_clk).Enabled = 'off';
      msk.getParameter(t227_has_clk).Enabled = 'off';

      set_param(gcb, t228_has_clk, 'on');
      set_param(gcb, t229_has_clk, 'off');
      set_param(gcb, t230_has_clk, 'on');
      set_param(gcb, t231_has_clk, 'off');
      msk.getParameter(t228_has_clk).Enabled = 'off';
      msk.getParameter(t229_has_clk).Enabled = 'off';
      msk.getParameter(t230_has_clk).Enabled = 'off';
      msk.getParameter(t231_has_clk).Enabled = 'off';
    case 'ZCU216'
      set_param(gcb, t224_has_clk, 'off');
      set_param(gcb, t225_has_clk, 'on');
      set_param(gcb, t226_has_clk, 'on');
      set_param(gcb, t227_has_clk, 'off');
      msk.getParameter(t224_has_clk).Enabled = 'off';
      msk.getParameter(t225_has_clk).Enabled = 'on';
      msk.getParameter(t226_has_clk).Enabled = 'off';
      msk.getParameter(t227_has_clk).Enabled = 'off';

      set_param(gcb, t228_has_clk, 'off');
      set_param(gcb, t229_has_clk, 'on');
      set_param(gcb, t230_has_clk, 'on');
      set_param(gcb, t231_has_clk, 'off');
      msk.getParameter(t228_has_clk).Enabled = 'off';
      msk.getParameter(t229_has_clk).Enabled = 'on';
      msk.getParameter(t230_has_clk).Enabled = 'off';
      msk.getParameter(t231_has_clk).Enabled = 'off';
    case 'ZCU208'
      set_param(gcb, t224_has_clk, 'off');
      set_param(gcb, t225_has_clk, 'on');
      set_param(gcb, t226_has_clk, 'on');
      set_param(gcb, t227_has_clk, 'off');
      msk.getParameter(t224_has_clk).Enabled = 'off';
      msk.getParameter(t225_has_clk).Enabled = 'on';
      msk.getParameter(t226_has_clk).Enabled = 'off';
      msk.getParameter(t227_has_clk).Enabled = 'off';

      set_param(gcb, t228_has_clk, 'off');
      set_param(gcb, t229_has_clk, 'on');
      set_param(gcb, t230_has_clk, 'on');
      set_param(gcb, t231_has_clk, 'off');
      msk.getParameter(t228_has_clk).Enabled = 'off';
      msk.getParameter(t229_has_clk).Enabled = 'on';
      msk.getParameter(t230_has_clk).Enabled = 'off';
      msk.getParameter(t231_has_clk).Enabled = 'off';
    case 'ZRF16_49DR'
      set_param(gcb, t224_has_clk, 'on');
      set_param(gcb, t225_has_clk, 'on');
      set_param(gcb, t226_has_clk, 'on');
      set_param(gcb, t227_has_clk, 'on');
      msk.getParameter(t224_has_clk).Enabled = 'on';
      msk.getParameter(t225_has_clk).Enabled = 'on';
      msk.getParameter(t226_has_clk).Enabled = 'on';
      msk.getParameter(t227_has_clk).Enabled = 'on';

      set_param(gcb, t228_has_clk, 'on');
      set_param(gcb, t229_has_clk, 'on');
      set_param(gcb, t230_has_clk, 'on');
      set_param(gcb, t231_has_clk, 'on');
      msk.getParameter(t228_has_clk).Enabled = 'on';
      msk.getParameter(t229_has_clk).Enabled = 'on';
      msk.getParameter(t230_has_clk).Enabled = 'on';
      msk.getParameter(t231_has_clk).Enabled = 'on';
  end

