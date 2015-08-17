Awesome window manager, all prefixed by the Windows key:

Enter:		Open xterm
Shift+c:	Close window
r:		Run program
space: 		Cycle through layouts
Shift+q:	Quit Awesome
[1-9]:		Browse through tags
Shift+[1-9]:	Send window to tag

To test an awesome configuration:
# Create an X subcreen
Xephyr :1 -ac -br -noreset -screen 720x480 &
# And start awesome in it
export DISPLAY=:1.0 &
awesome -c ~/.config/rc.lua
