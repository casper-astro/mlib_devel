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
      model.sim = list('rfsoc',4);
      model.blocktype = 'c';
      // we put the index of the related item in block_info.json into rpar
      // model.rpar = [0,0,256,128,1];
      //   "RFSoC4x2":{
      //     "name": "RFSoC4x2",      
      //     "fullpath": "",
      //     "tag": "xps:xsg",
      //     "hw_sys": "rfsoc4x2:xczu48dr",   -- 3
      //     "clk_src": "adc_clk",            -- 4
      //     "clk_rate": 245.76,              -- 5
      //     "pl_clk_rate": 122.88,           -- 6
      //     "sample_period": 1,              -- 7
      //     "synthesis_tool": "XST"
      // }
      // Type : column vector of real numbers.
      model.rpar = [0, 3, 4, 5, 6, 7];
      // Type : column vector of strings.
      exprs = ['RFSoC4x2';'rfsoc4x2:xczu48dr'; 'adc_clk'; '245.76'; '122.88'; '1'];
      gr_i = [];
      // set block tag
      model.label = "xps";
      x=standard_define([4 4],model,exprs,gr_i)
      debug_info('rfsoc4x2 block loaded...')
  end
endfunction