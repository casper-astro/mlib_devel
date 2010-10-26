
function[] = make_from(system, goto_string)
%Step uno -- Find the goto's you want
sprintf('Finding Gotos with name "%s..." in system %s',goto_string, system)
gotos = find_system(system, 'RegExp', 'on', 'SearchDepth', 1, 'lookundermasks', 'all', 'BlockType', ...
    'Goto', 'gototag', ['^', goto_string]);

disp 'Generating Corresponding "from" blocks for:'
gotos
for n = 1:length(gotos)
    block = char(gotos(n));
    name = ['/from', get_param(block, 'name')];
    dest_location = [get_param(block, 'parent'), name];
    %check block name doesn't already exist
    counter = 0;
    block_exists = 1;
    %find_system(dest_location)
    while block_exists == 1
        try find_system(dest_location);
            dest_location = [dest_location, num2str(counter)];
            counter = counter+1;
            block_exists=1;
        catch exception
            block_exists=0 ;
        end
    end
        
    tag_name = get_param(block,'gototag');
    position = get_param(block,'position') + [100 0 100 0];
   
    add_block('built-in/from', dest_location, ...
        'gototag', tag_name, 'position', position, ...
        'ShowName', 'off');
end %for n = 1:length(gotos)