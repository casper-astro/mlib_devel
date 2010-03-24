# Hastily thrown together by wjm to accelerate the wreaking of havoc on casper_library.mdl.

# Fix existing broken links.
s/''\\\\doc\\\\html\\\\\(.*\)\\\\\(.*\)\.htm"/''\\\\doc\\\\html\\\\\1\\\\\1.html''\])')"/

# Update outdated link formats.
s/''\\\\casper_library\\\\doc\\\\\(.*\)\.html''/''\\\\doc\\\\html\\\\\1\\\\\1.html''/

# Extract block name, discard path.
s/\[getenv(''MLIB_ROOT''), ''\\\\doc\\\\html\(blocks\)\?\\\\\(.*\)\\\\\(.*\)\.htm\(l\)\?''\]/\2/

# Remove prefixes and suffixes.
s/"eval('xlWeb(sp_\(.*\))')"/"eval('xlWeb(\1)')"/
s/"eval('xlWeb(sys_\(.*\))')"/"eval('xlWeb(\1)')"/
s/"eval('xlWeb(com_\(.*\))')"/"eval('xlWeb(\1)')"/
s/"eval('xlWeb(\(.*\)_usage)')"/"eval('xlWeb(\1)')"/

# Capitalize first letter.
s/"eval('xlWeb(\(.*\))')"/"eval('xlWeb(\u\1)')"/

# Prepend wiki url.
s/"eval('xlWeb(\(.*\))')"/"eval('xlWeb(''http:\/\/casper\.berkeley\.edu\/wiki\/\1'')')"/

