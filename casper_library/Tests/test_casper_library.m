fail = 0;
ignore = 0;

fid = fopen('tester_input.txt');
if (fid==-1),
    fprintf('file tester_input.txt not found in local directory\n');
    return;
end

line=fgetl(fid);
linenum=0;

%load the casper library
load_system('../casper_library');

while(ischar(line))

    linenum=linenum+1;
    
    %read in the block to be tested and the model file
    [blk,remainder] = strtok(line);
    [libloc,remainder] = strtok(remainder);
    [model,remainder] = strtok(remainder);
   
    if(strcmp('%',blk)),
        line=fgetl(fid);
        continue;
    end
        
    err = 1;
    %if there is no block, library location or model file ignore this line
    if(isempty(blk) | isempty(libloc) | isempty(model)),
        fprintf(['block, library location or model not specified in line: "',line,'.\n']);
    %if the model file does not exist, ignore this line
    elseif(exist(model,'file') ~= 4),
        fprintf(['model file: "',model,'" does not exist.\n']);
    %load model and try to find block specified
    else
	    load_system(model);
	   
	    %try to find block in model
	    fprintf(['trying to find ',model,'/',blk,'\n']);
	    thisblk = find_system( [model],'name',blk);
	    if( isempty(thisblk) ),
		fprintf(['block: "',blk,'" does not exist in ',model,'.\n']);
	    else
		    %everything is good
		    err = 0;
	    end
	    
    	%try to find library block specified
	try,
	    lib = find_system( libloc );
	catch, 
		fprintf(['Error loading library block at ',libloc,'.\n']); 
		err = 1;
	end

    	if( isempty(lib) ),
		fprintf(['Error loading library block at ',libloc,'.\n']); 
		err = 1;
	end
    end

    if( err ),
        fprintf(['Ignoring line ',num2str(linenum),'\n']);
	ignore = ignore + 1;
    	close_system(model,0);
    else, 

        try,
		add_block( libloc,[model,'/',blk,'1']);
	catch,
		err = 1;
		close_system(model,0);
	end

	%read in block parameters
        [name,remainder] = get_token(remainder);
        [value, remainder] = get_token(remainder);
        while(~isempty(name) & ~isempty(value)),
            fprintf(['setting ',name,' to ',value,'\n']);
	    try, 	
            set_param([model,'/',blk,'1'],name, value);
	    catch,
		err = 1;    
    		disp(['Error setting ',name,' to ',value]);
	    end		
            [name,remainder] = get_token(remainder);
            [value, remainder] = get_token(remainder); 
        end
       
        %replace existing block with new one	
	if( ~err ), replace_block(model,'Name',blk,[model,'/',blk,'1'],'noprompt'); end
        delete_block([model,'/',blk,'1']);
     
	if( ~err ),
		fprintf('testing... ',blk,'\n');
		sim(model);
		load([model,'_reference']);
		load([model,'_output']);
	

		if(isequal(reference,output)),
		    fprintf([model,' passed\n']);
		else,
		    fprintf([model,' failed, line: ', num2str(linenum), '. Output and reference files differ\n']);
		    fail = fail + 1;
		end
		delete([model,'_output.mat']);
	else,
	        fprintf(['Ignoring line ',num2str(linenum),'\n']);
		ignore = ignore + 1;
	end
        
        close_system(model,0);
	fprintf(['\n']);
    end

    line=fgetl(fid);
end
fclose(fid);
close_system('../casper_library',0);

fprintf(['\n']);
fprintf(['number model test lines ignored: ',num2str(ignore),'\n']);
fprintf(['number model tests failed: ',num2str(fail),'\n']);
if( fail|ignore ), fprintf(['Please see output for more details\n']); end
