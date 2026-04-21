//Create a simple custom block.
function [x, y, typ]= rfsoc4x2(job, arg1, arg2)
  x=[];y=[];typ=[];
  blkname = 'RFSoC4x2';
  hd_plat = -1;
  fabric_clk_src = -1;
  fabric_clk_rate = -1;
  pll_clk_rate = -1;
  sample_period = -1;
  select job
    case 'set' then
      x=arg1;
      graphics = arg1.graphics;
      exprs = graphics.exprs;
      model = arg1.model;
      txt = [ 'Block Name (any string)';...
              'Hardware Platform';...
              'User IP Clock source'; ...
              'User IP Clock Rate(MHz)';...
              'RFPLL PL Clock Rate(MHz)';...
              'Sample Period'];
      // get args from gui
      [ok, blkname, hd_plat, fabric_clk_src, fabric_clk_rate, pll_clk_rate, sample_period, exprs] = scicos_getvalue("Set RFSoC4x2 block parameters",...
                        txt,...
                        list("str", 1, "str", 1 ,"str",1,"str",1,"str",1,"str",1),...
                        exprs);
      if ok then
        // as rpar has to be a float vector, we need to convert the string to float
        // if hd_plat == 'rfsoc4x2:xczu48dr' then
        //   hd_plat_r = 0;
        // end
        // if fabric_clk_src == 'adc_clk' then
        //   fabric_clk_src_r = 0;
        // end
        // generate rpar
        // rpar = [hd_plat_r, fabric_clk_src_r, fabric_clk_rate, pll_clk_rate, sample_period];
        // update model
        // model.rpar = rpar;
        graphics.exprs = exprs;
        x.graphics = graphics;
        x.model = model;
      end
    case 'define' then
      model = scicos_model();
      model.sim = list('rfsoc', 4);
      model.blocktype = 'c';

      model.in     = [];
      model.in2    = [];
      model.intyp  = [];

      model.out    = [];
      model.out2   = [];
      model.outtyp = [];

      model.evtin  = [];
      model.evtout = [];

      model.state   = [];
      model.dstate  = [];
      model.odstate = list();
      model.ipar    = [];
      model.opar    = list();
      model.firing  = [];
      model.dep_ut  = [%f %f];

      model.rpar = [0; 3; 4; 5; 6; 7];

      exprs = ['RFSoC4x2';
               'rfsoc4x2:xczu48dr';
               'adc_clk';
               '245.76';
               '122.88';
               '1'];

      gr_i = [];
      model.label = "xps";

      x = standard_define([4 4], model, exprs, gr_i);
      debug_info('rfsoc4x2 block loaded...');
  end
endfunction