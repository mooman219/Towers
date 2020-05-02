require("defines")
require("lib/misc")
local noise = require("noise")

-- Ore configurations.
local function ore_setup(options)
    local richness = function(x, y, tile, map)
        local modifier = (noise.absolute_value(y) - (options.offset_y * CHUNK)) / ORE_CHUNK
        return (options.increment * (modifier - options.begin + 1))
    end;
    options.type.autoplace.richness_expression = noise.define_noise_function(richness)

    local probability = function(x, y, tile, map)
        local size = RIDGE * options.size_mod
        local raw_x = noise.ridge(x + (options.offset_x * CHUNK), -(TOWER_RIDGE + WATER_RIDGE - size), size)
        local raw_y = noise.ridge(y + (options.offset_y * CHUNK), -(ORE_RIDGE - size), size)
        return water_level_correction(noise.min(raw_x, raw_y), map)
    end;
    options.type.autoplace.probability_expression = noise.define_noise_function(probability)
end

ore_setup {
    type = data.raw["resource"]["iron-ore"],
    offset_x = -4.0,
    offset_y = 0.5,
    size_mod = 1.0,
    increment = 400,
    begin = 0,
}
ore_setup {
    type = data.raw["resource"]["copper-ore"],
    offset_x = -3.0,
    offset_y = 0.5,
    size_mod = 1.0,
    increment = 400,
    begin = 0,
}
ore_setup {
    type = data.raw["resource"]["coal"],
    offset_x = -2.0,
    offset_y = 0.5,
    size_mod = 1.0,
    increment = 400,
    begin = 0,
}
ore_setup {
    type = data.raw["resource"]["stone"],
    offset_x = -1.0,
    offset_y = 0.5,
    size_mod = 1.0,
    increment = 400,
    begin = 0,
}
ore_setup {
    type = data.raw["resource"]["crude-oil"],
    offset_x = 4.75,
    offset_y = 0.25,
    size_mod = 0.5,
    increment = 350000,
    begin = 2,
}
ore_setup {
    type = data.raw["resource"]["uranium-ore"],
    offset_x = 4.0,
    offset_y = 0.5,
    size_mod = 1.0,
    increment = 200,
    begin = 3,
}
