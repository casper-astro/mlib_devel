function [] = enable_mts_opt(gcb)

  msk = Simulink.Mask.get(gcb);
  if chk_param(gcb, 'Tile224_enable', 'on')
    msk.getParameter('enable_mts').Enabled = 'on';
  else
    set_param(gcb, 'enable_mts',  'off');
    msk.getParameter('enable_mts').Enabled = 'off';
  end

end
