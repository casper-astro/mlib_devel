function [] = enable_mts_opt(gcb)

  % TODO: this is probably not needed anymore with mts validated as part of
  % rfdc_mask

  % what was this for? right now it will just turn on mts for tile 224 when
  % tile 224 is turned on. Maybe do more mts checking instead.

  msk = Simulink.Mask.get(gcb);
  if chk_param(gcb, 'Tile224_enable', 'on')
    msk.getParameter('t224_enable_mts').Enabled = 'on';
  else
    set_param(gcb, 't224_enable_mts',  'off');
    msk.getParameter('t224_enable_mts').Enabled = 'off';
  end

end
