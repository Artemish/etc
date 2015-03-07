rand() {
  pushd /home/mitch/Pictures/Wallpapers > /dev/null
  entries=`ls | wc -l`
  n=$RANDOM
  let "n %= entries"
  let "n += 1"
  f=`ls | sed "${n}q;d"`
  abspath="$(pwd)/$f"
  gsettings set org.gnome.desktop.background picture-uri "file://${abspath}"
  popd > /dev/null
}
