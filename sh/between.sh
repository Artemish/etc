between() {
   awk -v start="$1" -v stop="$2"  'matched; {if ( match( $0, start)) {matched=1; print $0}}; {if( match( $0, stop)) {matched=0}}'
}
