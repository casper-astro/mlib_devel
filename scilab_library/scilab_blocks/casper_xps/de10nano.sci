function [x, y, typ] = de10nano(job, arg1, arg2)
  x = []; y = []; typ = [];
  blkname = 'DE10-Nano';
  hd_plat = -1;
  fabric_clk_src = -1;
  fabric_clk_rate = -1;
  pll_clk_rate = -1;
  sample_period = -1;

  select job
    case 'set' then
      x = arg1;
      graphics = arg1.graphics;
      exprs = graphics.exprs;
      model = arg1.model;

      txt = [ 'Block Name (any string)'; ...
              'Hardware Platform'; ...
              'User IP Clock source'; ...
              'User IP Clock Rate(MHz)'; ...
              'RFPLL PL Clock Rate(MHz)'; ...
              'Sample Period'];

      [ok, blkname, hd_plat, fabric_clk_src, fabric_clk_rate, pll_clk_rate, sample_period, exprs] = ...
        scicos_getvalue("Set DE10-Nano block parameters", ...
                        txt, ...
                        list("str", 1, "str", 1, "str", 1, "str", 1, "str", 1, "str", 1), ...
                        exprs);

      if ok then
        graphics.exprs = exprs;
        x.graphics = graphics;
        x.model = model;
      end

    case 'define' then
      model = scicos_model();

      // Simulation function
      model.sim = list('de10-nano', 4);

      // No regular input/output ports for this platform block
      model.in     = [];
      model.in2    = [];
      model.intyp  = [];

      model.out    = [];
      model.out2   = [];
      model.outtyp = [];

      // No event ports
      model.evtin  = [];
      model.evtout = [];

      // No states / integer params / object params
      model.state   = [];
      model.dstate  = [];
      model.odstate = list();
      model.ipar    = [];
      model.opar    = list();
      model.firing  = [];

      // Block metadata
      model.blocktype = 'c';
      model.dep_ut    = [%f %f];
      model.label     = "xps";

      // Type: column vector of real numbers
      model.rpar = [0; 3; 4; 5; 6; 7];

      // Type: column vector of strings
      exprs = ['DE10-Nano';
               'de10nano:5CSEBA6U23I7';
               'fpga_clk1_50';
               '50';
               '50';
               '1'];

      gr_i = [];

      x = standard_define([4 4], model, exprs, gr_i);
      debug_info('de10nano block loaded...');
  end
endfunction