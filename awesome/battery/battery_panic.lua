local wibox = require("wibox")

panic_indicator = wibox.widget.textbox()
panic_text = "<span foreground=\"red\"> --- CHECK YO BATTERY --- </span>"


local panicking = false
local panic_timer = timer({timeout = 0.5})
local panic_indicator_on = false

function panic()
  if (not panicking) then
    panicking = true
    panic_timer:start()
  end
end

function unpanic()
  if (panicking) then
    panicking = false
    panic_timer:stop()
    
    panic_indicator_on = false
    panic_indicator:set_text("")
  end
end

function flip_panic()
  if (panic_indicator_on) then
    panic_indicator_on = false
    panic_indicator:set_text("")
  else
    panic_indicator_on = true
    panic_indicator:set_markup(panic_text)
  end
end

panic_timer:connect_signal("timeout", function () flip_panic(panic_indicator) end)
