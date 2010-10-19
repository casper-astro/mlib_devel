#!/bin/bash -e

UPDATE="
s,casper_library/Accumulators,casper_library_accumulators,g;
s,casper_library/Communications,casper_library_communications,g;
s,casper_library/Correlator,casper_library_correlator,g;
s,casper_library/Delays,casper_library_delays,g;
s,casper_library/Downconverter,casper_library_downconverter,g;
s,casper_library/FFTs/Twiddle/coeff_gen,casper_library_ffts_twiddle_coeff_gen,g;
s,casper_library/FFTs/Twiddle,casper_library_ffts_twiddle,g;
s,casper_library/FFTs,casper_library_ffts,g;
s,casper_library/Flow_Control,casper_library_flow_control,g;
s,casper_library/Misc,casper_library_misc,g;
s,casper_library/Multipliers,casper_library_multipliers,g;
s,casper_library/PFBs,casper_library_pfbs,g;
s,casper_library/Reorder,casper_library_reorder,g;
s,casper_library/Scopes,casper_library_scopes,g;
"

REVERT="
s,casper_library_accumulators,casper_library/Accumulators,g;
s,casper_library_communications,casper_library/Communications,g;
s,casper_library_correlator,casper_library/Correlator,g;
s,casper_library_delays,casper_library/Delays,g;
s,casper_library_downconverter,casper_library/Downconverter,g;
s,casper_library_ffts_twiddle_coeff_gen,casper_library/FFTs/Twiddle/coeff_gen,g;
s,casper_library_ffts_twiddle,casper_library/FFTs/Twiddle,g;
s,casper_library_ffts,casper_library/FFTs,g;
s,casper_library_flow_control,casper_library/Flow_Control,g;
s,casper_library_misc,casper_library/Misc,g;
s,casper_library_multipliers,casper_library/Multipliers,g;
s,casper_library_pfbs,casper_library/PFBs,g;
s,casper_library_reorder,casper_library/Reorder,g;
s,casper_library_scopes,casper_library/Scopes,g;
"

if [ "${1}" == "-r" ]
then
  action="reverting"
  grep_pattern="casper_library_"
  sed_pattern="${REVERT}"
  shift
else
  action="updating"
  grep_pattern="casper_library/"
  sed_pattern="${UPDATE}"
fi

for m in "$@"
do
  if ! [ -e "$m" ]
  then
    echo "$m not found"
    continue
  fi
  if ! grep -q "${grep_pattern}" "$m"
  then
    echo "$m modification not needed"
    continue
  fi
  echo -n "${action} librefs in $m..."
  mv "$m" "$m.$$.bak"
  sed -e "${sed_pattern}" "$m.$$.bak" > "$m"
  rm "$m.$$.bak"
  echo ok
done
