left_pad()   { C=$((COLUMNS - 1)); sed -e :a -e "s/^.\{1,$C\}$/& /;ta"; }
right_pad()  { C=$((COLUMNS - 1)); sed -e :a -e "s/^.\{1,$C\}$/ &/;ta"; }
center_pad() { C=$((COLUMNS - 1)); sed -e :a -e "s/^.\{1,$C\}$/ & /;ta"; }
