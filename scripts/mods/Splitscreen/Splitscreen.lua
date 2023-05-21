--[[
	author: Uganda (Axel Joly)
	-----
	Copyright © 2023, Uganda
	Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the “Software”), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
	The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
	The Software is provided “as is”, without warranty of any kind, express or implied, including but not limited to the warranties of merchantability, fitness for a particular purpose and noninfringement. In no event shall the authors or copyright holders X be liable for any claim, damages or other liability, whether in an action of contract, tort or otherwise, arising from, out of or in connection with the software or the use or other dealings in the Software.
	Except as contained in this notice, the name of the <copyright holders> shall not be used in advertising or otherwise to promote the sale, use or other dealings in this Software without prior written authorization from the <copyright holders>. »
	-----
--]]

-------------------
-- LUA UTILITIES --

-- for key,value in pairs(input_manager) do
	-- print(key, value)
-- end
-- for key,value in pairs(getmetatable(input_manager)) do
	-- print(key, value)
-- end

-- for i,v in pairs(input_manager) do print(i,v) end

-- print("x = " .. tostring(x))

-- LUA UTILITIES --
-------------------

require("scripts/managers/splitscreen/splitscreen_tester")

local mod = get_mod("Splitscreen")

-- Booleans
mod.is_active_SC = false
mod.SC = nil

-- Global variables


-- Backup


------------
-- EVENTS --

mod.on_all_mods_loaded = function()
	
end

mod.on_unload = function(exit_game)
	
end

mod.on_enabled = function(initial_call)
	
end

mod.on_disabled = function(initial_call)
	
end

mod.on_user_joined = function(player)
	
end

mod.on_user_left = function(player)
	
end

mod.on_setting_changed = function(setting_id)
	
end

mod.on_game_state_changed = function(status, state_name)
	
end

mod.update = function(dt)
	if mod.SC then
		if (SplitscreenTester.active(mod.SC) == true) then
			SplitscreenTester.update(mod.SC)
		end
	end
end

-- EVENTS --
------------

mod:command("test", "", function(...)
	mod:echo(mod.SC)
	mod:echo(Managers.splitscreen)
end)

--------------------
-- USER FUNCTIONS --

-- Called function from keybind
mod.toggle_SC = function (self)
    if not mod.is_active_SC then
        mod:activate_SC()
    else
        mod:deactivate_SC()
    end
end

mod.activate_SC = function (self)
	mod:echo("[Splitscreen] activated")
	mod.is_active_SC = true
	
	mod.SC = SplitscreenTester:new()
	--SplitscreenTester.add_splitscreen_viewport(mod.SC, mod.SC._world)
	Managers.splitscreen = mod.SC
end

mod.deactivate_SC = function (self)
	SplitscreenTester.remove_splitscreen_viewport(mod.SC)
	SplitscreenTester.destroy(mod.SC)
	mod.SC._splitscreen_active = false
	
	mod.is_active_SC = false
	mod:echo("[Splitscreen] deactivated")
end

-- USER FUNCTIONS --
--------------------

-----------
-- HOOKS --

mod:hook_origin(SplitscreenTester, "_setup_background", function (self, ...)
	self._world = Managers.world:create_world(self._world_name, GameSettingsDevelopment.default_environment, nil, 0, Application.DISABLE_PHYSICS, Application.DISABLE_APEX_CLOTH)

	--ScriptWorld.deactivate(self._world)

	self._viewport = ScriptWorld.create_viewport(world, "splitscreen_viewport", "default", 2, Vector3.zero(), Quaternion.identity(), true)

	--ScriptWorld.deactivate_viewport(self._world, self._viewport)

	self._gui = World.create_screen_gui(self._world, "immediate")
end)

mod:hook_origin(SplitscreenTester, "update", function (self, dt, t, ...)
	-- self:_update_input(dt, t)

	if self._splitscreen_active then
		self:_fill_background(dt, t)
		self:_update_splitscreen_camera(dt, t)
	elseif self._splitscreen_viewport and self._splitscreen_world then
		ScriptWorld.deactivate_viewport(self._splitscreen_world, self._splitscreen_viewport)
		ScriptWorld.deactivate_viewport(self._world, self._viewport)
	end
end)

mod:hook_origin(SplitscreenTester, "init", function (self, ...)
	self:_setup_names()
	self:_setup_background()
	--self:_setup_input()

	self._splitscreen_active = true
end)

-- HOOKS --
-----------