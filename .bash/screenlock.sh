screenlock() {
  CURSOR_POS=$(xdotool getmouselocation --shell | head -n 2)
  while true
  do
    sleep 1
    NEW_CURSOR_POS=$(xdotool getmouselocation --shell | head -n 2)
    if [ "$CURSOR_POS" != "$NEW_CURSOR_POS" ]; then
      gnome-screensaver-command --lock
      exit
    fi
    CURSOR_POS=$NEW_CURSOR_POS
  done
}
