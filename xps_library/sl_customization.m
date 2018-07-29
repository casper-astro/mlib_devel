% More information about this process can be found here:
% http://www.mathworks.com/help/simulink/ug/adding-items-to-model-editor-menus.html

function sl_customization(cm)
  %% Register custom menu function.
  cm.addCustomMenuFcn('Simulink:PreContextMenu', @getMyMenuItems);
end

%% Define the custom menu function.
function schemaFcns = getMyMenuItems(~) 
	schemaFcns = {@userFunctions}; 
end

%% Define the schema function for first menu item.
function schema = userFunctions(~)
	% Make a submenu label    
	schema = sl_container_schema;
	schema.label = 'CASPER helpers';     
	schema.childrenFcns = {@userGetBlockSize, @userSetBlockSize, @userGetBlockParams, @userSetBlockParams, ...
        @userGotoPlusPlus, @userDannyFunc, @userGoto2From, @userGotoFromGlobal, @userGotoFromLocal, ...
        @userGotoFromScoped, @userSetParams};
end

function schema = userGetBlockSize(~)
    schema = sl_action_schema;
	schema.label = 'Get block size';
	schema.callback = @helper_scripts.casper_sl_get_block_size; 
end

function schema = userSetBlockSize(~)
	schema = sl_action_schema;
	schema.label = 'Set block sizes';
	schema.callback = @helper_scripts.casper_sl_set_block_size; 
end

function schema = userGetBlockParams(~)
	schema = sl_action_schema;
	schema.label = 'Scrape block parameters';
	schema.callback = @helper_scripts.casper_sl_get_block_params; 
end

function schema = userSetBlockParams(~)
	schema = sl_action_schema;
	schema.label = 'Apply scraped parameters';
	schema.callback = @helper_scripts.casper_sl_set_block_params; 
end

function schema = userGotoPlusPlus(~)
	schema = sl_action_schema;
	schema.label = 'Increment goto/from tags';
    schema.userdata = [-1, -1];
	schema.callback = @helper_scripts.casper_sl_incr_tag;
end

function schema = userDannyFunc(~)
	schema = sl_action_schema;
	schema.label = 'Goto -> Goto++';
	schema.callback = @helper_scripts.casper_sl_goto_plusplus; 
end

function schema = userGoto2From(~)
	schema = sl_action_schema;
	schema.label = 'Goto -> From';
	schema.callback = @helper_scripts.casper_sl_goto2from; 
end

function schema = userGotoFromGlobal(~)
	schema = sl_action_schema;
	schema.label = 'Goto/From scope -> Global';
    schema.userdata = 'global';
	schema.callback = @helper_scripts.casper_sl_tagscope; 
end

function schema = userGotoFromLocal(~)
	schema = sl_action_schema;
	schema.label = 'Goto/From scope -> Local';
    schema.userdata = 'local';
	schema.callback = @helper_scripts.casper_sl_tagscope; 
end

function schema = userGotoFromScoped(~)
	schema = sl_action_schema;
	schema.label = 'Goto/From scope -> Scoped';
    schema.userdata = 'scoped';
	schema.callback = @helper_scripts.casper_sl_tagscope; 
end

function schema = userSetParams(~)
    schema = sl_action_schema;
	schema.label = 'Set block params';
	schema.callback = @helper_scripts.casper_sl_set_param_selected; 
end

% if you'd like to add more user functions duplicate 'userFunction1'
% structure.