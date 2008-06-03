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
    else, 

        add_block( libloc,[model,'/',blk,'1']);
        %read in block parameters
        [name,remainder] = strtok(remainder);
        [value, remainder] = strtok(remainder);
        while(~isempty(name) & ~isempty(value)),
            set_param([model,'/',blk,'1'],name, value);
            fprintf(['setting ',name,' ',value,'\n']);
            [name,remainder] = strtok(remainder);
            [value, remainder] = strtok(remainder); 
        end
        
        replace_block(model,'Name',blk,[model,'/',blk,'1'],'noprompt');
        delete_block([model,'/',blk,'1']);
     
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
        
        close_system(model,1);
	fprintf(['\n']);
    end

    line=fgetl(fid);
end
fclose(fid);
close_system('../casper_library',0);

fprintf(['\n']);
fprintf(['number model tests ignored: ',num2str(ignore),'\n']);
fprintf(['number models failed: ',num2str(fail),'\n']);
if( fail|ignore ), fprintf(['Please see output for more details\n']); end
