local wibox = require("wibox")

-- freaking Lua, this module is in the same directory
local battery_panic = require("battery/battery_panic")

battery_widget = wibox.widget.textbox()

function update_battery(widget)
  local fd = io.popen("acpi")
  local status = fd:read("*all")
  fd:close()

  local battery = tonumber(string.match(status, "(%d?%d?%d)%%"))

  if (string.find(status, "Discharging") == nil) then
    sign = "^"
  else
    sign = "v"
  end

  remaining = string.match(status, "(%d+)%%")

  status_string = "[" .. remaining .. "% " .. sign .. "]"

  battery_widget:set_text(status_string)

  local power = tonumber(remaining)

  if (power < 12) and (sign == "v") then
    -- I should really make "panic" uppercase..
    panic()
  else
    unpanic()
  end
end

update_battery(battery_widget) 

local battery_timer = timer({timeout = 10})

battery_timer:connect_signal("timeout", function () update_battery(battery_widget) end)
battery_timer:start()
