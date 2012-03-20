function gtk_view()
if exist('temp.vcd','file')
    dos(['C:\\gtkw\\gtkwave ', 'temp.vcd', ' temp.sav' ' &'])
else
    warndlg('temp.vcd does not exist, run gtk_parse first','File not found')
end