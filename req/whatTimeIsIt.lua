local function _PercentToClockish(percent)
	if (percent < 0.5) then
		percent = percent + 0.5
	else
		percent = percent - 0.5
	end
	local minutes = percent * 1440
	local hours = math.floor(minutes / 60)
	minutes = math.floor(minutes % 60)

	return string.format("%02d", hours) .. ":" .. string.format("%02d", minutes)
end

local function _UpdateSurface(player, elem)
	log(player.surface.name)

	if (player.surface.platform == nil) then
		elem.clockLabel.visible = true

		elem.timeZone.caption = player.surface.name:sub(1,1):upper() .. "ST"
		elem.planetIcon.sprite = "space-location/" .. player.surface.name
	else
		elem.clockLabel.visible = false

		elem.timeZone.caption = "SPACE!"
		elem.planetIcon.sprite = "entity/cargo-pod-container"
	end
end

local function MakeUIIfNotExists(player)
	if not player.gui.top.whatTime then
		--local frame = player.gui.top.add {type = "label", name = "whatTime", caption = "00:00"}
		local flow = player.gui.top.add {
			type = "flow",
			name = "whatTime",
			direction = "horizontal"
		}

		local planetIcon = flow.add {
			type = "sprite",
			name = "planetIcon",
			sprite = "item/steel-plate",
		}

		local timeZone = flow.add {
			type = "label",
			name = "timeZone",
			caption = "NST"
		}

		local clockLabel = flow.add {
			type = "label",
			name = "clockLabel",
			caption = "00:00"
		}

		flow.style.margin = 4
		planetIcon.style.size = 24
		planetIcon.style.stretch_image_to_widget_size = true
		planetIcon.style.top_margin = 1
		planetIcon.style.left_margin = 1
		timeZone.style.font = "wtii-scaled-font"
		clockLabel.style.font = "wtii-scaled-font"

		_UpdateSurface(player, flow)
		return flow
	end

	return player.gui.top.whatTime
end

local function UpdateSurface(player)
	local elem = MakeUIIfNotExists(player)

	_UpdateSurface(player, elem)
end

local function UpdateTime()
	for _, player in pairs(game.players) do
		if player.connected then
			local elem = MakeUIIfNotExists(player)

			elem.clockLabel.caption = _PercentToClockish(player.surface.daytime)
		end
	end
end

local function DestroyUI()
	for _, player in pairs(game.players) do
		if (player.gui.top.whatTime) then
			player.gui.top.whatTime.destroy()
		end
	end
end

local whatTime = {}
--whatTime.MakeUI = MakeUI
whatTime.UpdateTime = UpdateTime
whatTime.UpdateSurface = UpdateSurface
whatTime.DestroyUI = DestroyUI
return whatTime


