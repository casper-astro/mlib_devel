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
    [model,remainder] = strtok(remainder);
    
    if(strcmp('%',blk)),
        line=fgetl(fid);
        continue;
    end
        
    
    %if there is no block or model file ignore this line
    if(isempty(blk) | isempty(model)),
        fprintf(['block or model not specified in line: "',line,'", ignoring line ',num2str(linenum),'\n']);
    %if the model file does not exist, ignore this line
    elseif(~exist(model)),
        fprintf(['model file: "',model,'" does not exist, ignoring line ',num2str(linenum),'\n']);
    end
    
    load_system(model);
   
    fprintf(['trying to find ',model,'/',blk,'\n']);
    %if the block is not in the model, ignore this line
    thisblk = find_system( [model],'name',blk);
    if( isempty(thisblk) ),
        fprintf(['block: "',blk,'" does not exist in ',model,' ignoring line ',num2str(linenum),'\n']);
    else, 
        add_block(['casper_library/Misc/',blk],[model,'/',blk,'1']);
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
        end
        delete([model,'_output.mat']);
        
        close_system(model,1);
    end

    line=fgetl(fid);
end
fclose(fid);
close_system('../casper_library',0);