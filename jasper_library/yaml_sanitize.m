function [clean_str] = yaml_sanitize(str)

% catch things likely to kill yaml (namely colons in values)

if ~isempty(strfind(str,':'))
    clean_str = ['''' str ''''];
else
    clean_str = str;
end



