local WhatTime = require('req/whatTimeIsIt')

local function On_Tick(event)
	WhatTime.UpdateTime()
end

local function On_SurfaceUpdate(event)
	local player = game.players[event.player_index]
	WhatTime.UpdateSurface(player)
end

script.on_event(defines.events.on_tick, On_Tick)
script.on_event(defines.events.on_player_changed_surface, On_SurfaceUpdate)

script.on_configuration_changed(On_Destroy)
