require("defines")

-- ----------------------------------------------
-- Global functions
-- ----------------------------------------------

local function initialize_global()
   -- number: spawn id
   global.spawned_player_count = global.spawned_player_count or 0

   -- {string: number}: {player.name: spawn id}
   global.player_spawn = global.player_spawn or {}
end

---@param player any | "LuaPlayer"
local function register_player(player)
   local entry = global.player_spawn[player.name]
   if (not entry) then
      entry = global.spawned_player_count
      global.player_spawn[player.name] = entry
      global.spawned_player_count = global.spawned_player_count + 1
   end
end


---@param player any | "LuaPlayer"
---@return number
local function get_spawn_id(player)
   return global.player_spawn[player.name]
end

-- ----------------------------------------------
-- Player functions
-- ----------------------------------------------

---@param player any | "LuaPlayer"
local function teleport_player(player)
   local entry = get_spawn_id(player)
   local x = entry * TELEPORT_DISTANCE
   player.teleport({x, 0}, player.surface)
end

-- ----------------------------------------------
-- Event functions
-- ----------------------------------------------

script.on_event(defines.events.on_player_created, function(event)
   local player = game.players[event.player_index]
   register_player(player)
   teleport_player(player)
end)

script.on_event(defines.events.on_player_joined_game, function(event)
   local player = game.players[event.player_index]
   register_player(player)
end)

script.on_event(defines.events.on_player_respawned, function(event)
   local player = game.players[event.player_index]
   teleport_player(player)
   player.print({"respawn"})
end)

script.on_init(function()
   initialize_global()
end)

script.on_configuration_changed(function(data)
   initialize_global()
end)