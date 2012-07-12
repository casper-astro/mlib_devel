function cwarndlg(string, dlgname, id, mode)

%if we only want this done once, check if we have done this yet
if strcmp(mode,'once'),
  state = warning('query', id);
  if strcmp(state.state, 'off'),  %have warned already so exit
    return;
  else                            %have not warned yet 
    warning('off', id);           %turn off for future
  end
end

warndlg(string, dlgname);
