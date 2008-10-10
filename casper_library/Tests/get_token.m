function [token,remainder] = get_token(string)

if length(string) == 0,
	token = ''; remainder = '';
	return
end

if string(1) == ' ',
	string = string(2:length(string));
end
[token,remainder] = strtok(string);

if length(token) == 0, return; end

%if deliminated with quotes (' ') then contains multiple words with spaces between
if token(1) == '''', 
	%extract token using apostrophes instead of spaces
	[token,remainder] = strtok(string,'''');
	%remove the final apostrophe
	[temp,remainder] = strtok(remainder);
	token = ['',token,''];
end


