function [clean_str] = yaml_sanitize(str)

% catch things likely to kill yaml (namely colons in values)

if contains(str,':')
    clean_str = ['''' str ''''];
elseif contains(str,char(10)) % newline '\n'
    clean_str = ['"' str '"'];
else
    clean_str = str;
end
