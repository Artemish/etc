local awful = require("awful")
local wibox = require("wibox")

volume_widget = wibox.widget.imagebox()

function update_volume(widget)
  local fd = io.popen("amixer sget Master")
  local status = fd:read("*all")
  fd:close()

  local volume = tonumber(string.match(status, "(%d?%d?%d)%%"))

  status = string.match(status, "%[(o[^%]]*)%]")

  if status == 'on' then
    if volume == 0 then
      image = 0
    elseif volume <= 35 then
      image = 1
    elseif volume <= 65 then
      image = 2
    elseif volume <= 90 then
      image = 3
    else
      image = 4
    end

    filepath = awful.util.getdir("config") .. "/volume/volume_" .. image .. ".png"
    widget:set_image(filepath)
  else
    -- fuck if I know
  end
end

update_volume(volume_widget) 
-- awful.hooks.timer.register(1, function () update_volume(volume_widget) end)
