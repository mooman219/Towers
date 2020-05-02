require("defines")
require("lib/misc")
local noise = require("noise")

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
