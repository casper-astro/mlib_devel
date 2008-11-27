% function test_library(test_file, section)
% test_file - The file (in the current directory) containing the library and module components to test
% section - The section in the file to test (denoted by by line starting with '% #') or 'all' for everything

function test_library(test_file, section)

%variables used to track number of failures and lines ignored
fail = 0;
ignore = 0;

fid = fopen(test_file);
if (fid==-1),
    fprintf(['file ',test_file,' not found in local directory\n']);
    return;
end

%library containing blocks expected on first line
library=fgetl(fid);
linenum=1;
if ~ischar(library), fprintf('File empty\n'); return; end

%search for section to test
if( ~strcmp(section,'all') ), 
	comment = ' '; token = ' '; sec = ' '; 

	%search for beginning of correct section
	while( ~strcmp(comment,'%') || ~strcmp(token,'#') || ~strcmp(sec,section) ),
		line=fgetl(fid);
		linenum=linenum+1;
		if( ~ischar(line) ), 
			fprintf(['Error reading from file or end of file found\n']);
			fclose(fid);
			return;
		end
		[comment,remainder] = strtok(line);
	    	[token,remainder] = strtok(remainder);
	    	[sec,remainder] = strtok(remainder);
	end
	fprintf(['Beginning of test section ',section,' found at line ',num2str(linenum),'\n']);
end	

line=fgetl(fid);
linenum=linenum+1;

%load the appropriate library
if(exist(['../',library],'file') ~= 4),
	fprintf(['Error loading library ../',library,'. Aborting...\n']);
	return;
else,
	load_system(['../',library]);
	fprintf([library,' loaded\n\n']);
end

%test section
while( ischar(line) )

    linenum=linenum+1;
    
    %read in the block to be tested and the model file
    [blk,remainder] = strtok(line);
    [libloc,remainder] = strtok(remainder);
    [model,remainder] = strtok(remainder);

    %found end of section to be tested and only testing sections   
    if( strcmp('#',libloc) && strcmp(blk,'%') && ~strcmp(section,'all') )
	fprintf(['End of test section ',section,' found at line ',num2str(linenum)]);
	break;
    end

    if(strcmp('%',blk)),
        line=fgetl(fid);
        continue;
    end
        
    err = 1;
    %if there is no block, library location or model file ignore this line
    if(isempty(blk) | isempty(libloc) | isempty(model)),
        fprintf(['Block, library location or model not specified in line: "',line,'.\n']);
    %if the model file does not exist, ignore this line
    elseif(exist(model,'file') ~= 4),
        fprintf(['Model file: "',model,'" does not exist.\n']);
    %load model and try to find block specified
    else
	load_system(model);
	 
	%try to find block in model
	fprintf(['Trying to find ',model,'/',blk,'...\n']);
	thisblk = find_system( [model],'name',blk);
	if( isempty(thisblk) ),
		fprintf(['block: "',blk,'" does not exist in ',model,'.\n']);
	else
	   	%everything is good
		err = 0;
	end
	   
	%try to find library block specified
	fprintf(['Trying to find library block ',libloc,'...\n']);
	try,
		lib = find_system( libloc );
	catch, 
		fprintf(['Error loading library block ',libloc,'.\n']); 
		err = 1;
	end

    	if( isempty(lib) ),
		fprintf(['Error loading library block ',libloc,'.\n']); 
		err = 1;
	end
    end

    if( err ),
	fprintf(['\n************************************\n']);
        fprintf(['* Ignoring line ',num2str(linenum),' *\n']);
	fprintf(['************************************\n\n']);
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
	extension = '';
	vars = {};
	i = 0;
        [name,remainder] = get_token(remainder);
        [value, remainder] = get_token(remainder);
        while(~isempty(name) & ~isempty(value)),
            fprintf(['setting ', name, ' to ',value,'\n']);
	    vars{(i*2)+1} = ['',name,''];
	    vars{(i*2)+2} = value;

	    %if are dealing with Configurable Subsystem
	    if( strcmp( 'BlockChoice', name ) ),
		    fprintf(['Reconfigurable Subsystem detected, unable to do those\n'])
	    end   
            [name,remainder] = get_token(remainder);
            [value, remainder] = get_token(remainder);
	    i = i+1; 
        end
    
        set_mask([model,'/',blk, '1'], vars{:});

        %replace existing block with new one	
	if( ~err ), 
	%	fprintf(['Replacing block\n']);
		replace_block(model,'Name',blk,[model,'/',blk,'1'],'noprompt'); 
	end
        delete_block([model,'/',blk, '1']);
     
	if( ~err ),
		fprintf('testing... ',blk,'\n');
		sim(model);
		load([model,'_reference']);
		load([model,'_output']);
	

		if(isequal(reference,output)),
		    fprintf([model,' passed\n']);
		else,
	            fprintf(['\n*******************************************************************\n']);
		    fprintf([model,' failed, line: ', num2str(linenum), '. Output and reference files differ\n']);
		    fprintf(['*******************************************************************\n\n']);
		    fail = fail + 1;
		end
		%delete([model,'_output.mat']);
	else,
		fprintf(['\n************************************\n']);
	        fprintf(['* Ignoring line ',num2str(linenum),' *\n']);
		fprintf(['************************************\n\n']);
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
