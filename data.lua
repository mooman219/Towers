require("defines")
require("lib/misc")

local noise = require("noise")
local tne = noise.to_noise_expression

-- Nerf manual artillery for multiplayer.
data.raw["artillery-turret"]["artillery-turret"].manual_range_modifier = 0.95
data.raw["artillery-wagon"]["artillery-wagon"].manual_range_modifier = 0.95

-- Disabling spawning of normal biter and spitter spawners.
data.raw["unit-spawner"]["biter-spawner"].autoplace.probability_expression = tne(0)
data.raw["unit-spawner"]["spitter-spawner"].autoplace.probability_expression = tne(0)

-- Enemy creation. Copy the spitter spawner and create a generic every unit spawner.
local function spawner_create(options)
  local spawner = deepcopy(options.type)
  spawner.name = options.name
  spawner.result_units = options.entities
  data.raw["unit-spawner"][options.name] = spawner
end

spawner_create{
  type = data.raw["unit-spawner"]["biter-spawner"],
  name = "small-infestation-cyst",
  entities = {
    {"small-biter",  {{0.00, 0.2}}},
    {"small-spitter",{{0.00, 0.1}}}
  },
}
spawner_create{
  type = data.raw["unit-spawner"]["biter-spawner"],
  name = "medium-infestation-cyst",
  entities = {
    {"medium-biter",  {{0.00, 0.2}}},
    {"medium-spitter",{{0.00, 0.1}}}
  },
}
spawner_create{
  type = data.raw["unit-spawner"]["spitter-spawner"],
  name = "big-infestation-cyst",
  entities = {
    {"big-biter",  {{0.00, 0.2}}},
    {"big-spitter",{{0.00, 0.1}}}
  },
}
spawner_create{
  type = data.raw["unit-spawner"]["spitter-spawner"],
  name = "behemoth-infestation-cyst",
  entities = {
    {"behemoth-biter",  {{0.00, 0.2}}},
    {"behemoth-spitter",{{0.00, 0.1}}}
  },
}

local function water_level_correction(to_be_corrected, map)
  return noise.max(
    map.wlc_elevation_minimum,
    to_be_corrected + map.wlc_elevation_offset
  )
end

-- The tower generator.
data:extend{
  {
    type = "noise-expression",
    name = "gen-towers",
    intended_property = "elevation",
    expression = noise.define_noise_function(function(x, y, tile, map)
      local raw_elevation = noise.ridge(x + TOWER_RIDGE, -WATER_RIDGE, TOWER_RIDGE)
      return water_level_correction(raw_elevation, map)
    end)
  }
}

-- Enemy configurations.
local function enemy_setup(options)
  if (options.order) then
    options.type.autoplace.order = options.order
  end
  options.type.autoplace.probability_expression = noise.define_noise_function(function(x, y, tile, map)
    local y_mod = noise.clamp(noise.absolute_value(y) - (options.begin * ORE_CHUNK), 0, ENEMY_MAX_CHUNK)
    local prob = (y_mod / ENEMY_MAX_CHUNK) * options.prob_max
    return prob ^ 1.5
  end)
end

enemy_setup{
  type = data.raw["unit-spawner"]["small-infestation-cyst"],
  order = "ad",
  prob_max = 1/50,
  begin = 1,
}
enemy_setup{
  type = data.raw["unit-spawner"]["medium-infestation-cyst"],
  order = "ac",
  prob_max = 1/50,
  begin = 3,
}
enemy_setup{
  type = data.raw["unit-spawner"]["big-infestation-cyst"],
  order = "ab",
  prob_max = 1/50,
  begin = 4,
}
enemy_setup{
  type = data.raw["unit-spawner"]["behemoth-infestation-cyst"],
  order = "aa",
  prob_max = 1/50,
  begin = 5,
}
enemy_setup{
  type = data.raw["turret"]["small-worm-turret"],
  order = "bd",
  prob_max = 1/25,
  begin = 1,
}
enemy_setup{
  type = data.raw["turret"]["medium-worm-turret"],
  order = "bc",
  prob_max = 1/25,
  begin = 3,
}
enemy_setup{
  type = data.raw["turret"]["big-worm-turret"],
  order = "bb",
  prob_max = 1/25,
  begin = 4,
}
enemy_setup{
  type = data.raw["turret"]["behemoth-worm-turret"],
  order = "ba",
  prob_max = 1/25,
  begin = 5,
}

-- Ore configurations.
local function ore_setup(options)
  options.type.autoplace.richness_expression = noise.define_noise_function(function(x, y, tile, map)
    local modifier = (noise.absolute_value(y) - (options.offset_y * CHUNK)) / ORE_CHUNK
    return (options.increment * (modifier - options.begin + 1))
  end)

  options.type.autoplace.probability_expression = noise.define_noise_function(function(x, y, tile, map)
    local size = RIDGE * options.size_mod
    local raw_x = noise.ridge(x + (options.offset_x * CHUNK), -(TOWER_RIDGE + WATER_RIDGE - size), size)
    local raw_y = noise.ridge(y + (options.offset_y * CHUNK), -(ORE_RIDGE - size), size)
    return water_level_correction(noise.min(raw_x, raw_y), map)
  end)
end

ore_setup{
  type = data.raw["resource"]["iron-ore"],
  offset_x = -4,
  offset_y = 0.5,
  size_mod = 1,
  increment = 400,
  begin = 0,
}
ore_setup{
  type = data.raw["resource"]["copper-ore"],
  offset_x = -3,
  offset_y = 0.5,
  size_mod = 1,
  increment = 400,
  begin = 0,
}
ore_setup{
  type = data.raw["resource"]["coal"],
  offset_x = -2,
  offset_y = 0.5,
  size_mod = 1,
  increment = 400,
  begin = 0,
}
ore_setup{
  type = data.raw["resource"]["stone"],
  offset_x = -1,
  offset_y = 0.5,
  size_mod = 1,
  increment = 400,
  begin = 0,
}
ore_setup{
  type = data.raw["resource"]["crude-oil"],
  offset_x = 4.75,
  offset_y = 0.25,
  size_mod = 0.5,
  increment = 350000,
  begin = 2,
}
ore_setup{
  type = data.raw["resource"]["uranium-ore"],
  offset_x = 4,
  offset_y = 0.5,
  size_mod = 1,
  increment = 200,
  begin = 3,
}

if settings.startup[PARAM_WORKER_ROBOTS_STORAGE_NAME].value then
  data:extend
  ({
    {
      type = "technology",
      name = "worker-robots-storage-4",
      icon = "__base__/graphics/technology/worker-robots-storage.png",
      icon_size = 128,
      prerequisites = {"worker-robots-storage-3", "space-science-pack"},
      effects =
      {
        {
          type = "worker-robot-storage",
          modifier = 1
        }
      },
      unit =
      {
        count_formula = "2^(L-4)*1000",
        ingredients =
        {
          {"automation-science-pack", 1},
          {"logistic-science-pack", 1},
          {"chemical-science-pack", 1},
          {"production-science-pack", 1},
          {"utility-science-pack", 1},
          {"space-science-pack", 1}
        },
        time = 60
      },
      max_level = "infinite",
      upgrade = true,
      order = "c-k-f-e"
    },
  })
end

if settings.startup[PARAM_WORKER_ROBOTS_BATTERY_NAME].value then
  data:extend
  ({
    {
      type = "technology",
      name = "worker-robot-battery-1",
      icon = "__base__/graphics/technology/battery.png",
      icon_size = 128,
      effects =
      {
        {
          type = "worker-robot-battery",
          modifier = 0.1
        }
      },
      prerequisites = {"robotics"},
      unit =
      {
        count_formula = "100*L",
        ingredients =
        {
          {"automation-science-pack", 1},
          {"logistic-science-pack", 1},
          {"chemical-science-pack", 1},
        },
        time = 30
      },
      upgrade = true,
      max_level = "3",
      order = "c-k-h-e"
    },
    {
      type = "technology",
      name = "worker-robot-battery-4",
      icon = "__base__/graphics/technology/battery.png",
      icon_size = 128,
      effects =
      {
        {
          type = "worker-robot-battery",
          modifier = 0.1
        }
      },
      prerequisites = {"worker-robot-battery-1"},
      unit =
      {
        count_formula = "100*L",
        ingredients =
        {
          {"automation-science-pack", 1},
          {"logistic-science-pack", 1},
          {"chemical-science-pack", 1},
          {"production-science-pack", 1},
        },
        time = 45
      },
      upgrade = true,
      max_level = "7",
      order = "c-k-h-e"
    },
    {
      type = "technology",
      name = "worker-robot-battery-8",
      icon = "__base__/graphics/technology/battery.png",
      icon_size = 128,
      effects =
      {
        {
          type = "worker-robot-battery",
          modifier = 0.1
        }
      },
      prerequisites = {"worker-robot-battery-4"},
      unit =
      {
        count_formula = "100*L",
        ingredients =
        {
          {"automation-science-pack", 1},
          {"logistic-science-pack", 1},
          {"chemical-science-pack", 1},
          {"production-science-pack", 1},
          {"utility-science-pack", 1},
        },
        time = 60
      },
      upgrade = true,
      max_level = "11",
      order = "c-k-h-e"
    },
    {
      type = "technology",
      name = "worker-robot-battery-12",
      icon = "__base__/graphics/technology/battery.png",
      icon_size = 128,
      effects =
      {
        {
          type = "worker-robot-battery",
          modifier = 0.1
        }
      },
      prerequisites = {"worker-robot-battery-8", "space-science-pack"},
      unit =
      {
        count_formula = "2^(L-11)*1000",
        ingredients =
        {
          {"automation-science-pack", 1},
          {"logistic-science-pack", 1},
          {"chemical-science-pack", 1},
          {"production-science-pack", 1},
          {"utility-science-pack", 1},
          {"space-science-pack", 1},
        },
        time = 60
      },
      upgrade = true,
      max_level = "infinite",
      order = "c-k-h-e"
    },
  })
end