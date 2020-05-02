require("defines")
require("lib/misc")
local noise = require("noise")
local tne = noise.to_noise_expression

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

spawner_create {
    type = data.raw["unit-spawner"]["biter-spawner"],
    name = "small-infestation-cyst",
    entities = {{"small-biter", {{0.00, 0.2}}}, {"small-spitter", {{0.00, 0.1}}}},
}
spawner_create {
    type = data.raw["unit-spawner"]["biter-spawner"],
    name = "medium-infestation-cyst",
    entities = {{"medium-biter", {{0.00, 0.2}}}, {"medium-spitter", {{0.00, 0.1}}}},
}
spawner_create {
    type = data.raw["unit-spawner"]["spitter-spawner"],
    name = "big-infestation-cyst",
    entities = {{"big-biter", {{0.00, 0.2}}}, {"big-spitter", {{0.00, 0.1}}}},
}
spawner_create {
    type = data.raw["unit-spawner"]["spitter-spawner"],
    name = "behemoth-infestation-cyst",
    entities = {{"behemoth-biter", {{0.00, 0.2}}}, {"behemoth-spitter", {{0.00, 0.1}}}},
}

-- Enemy configurations.
local function enemy_setup(options)
    if (options.order) then
        options.type.autoplace.order = options.order
    end
    local probability = function(x, y, tile, map)
        local y_mod = noise.clamp(noise.absolute_value(y) - (options.begin * ORE_CHUNK), 0, ENEMY_MAX_CHUNK)
        local prob = (y_mod / ENEMY_MAX_CHUNK) * options.prob_max
        return prob ^ 1.5
    end;
    options.type.autoplace.probability_expression = noise.define_noise_function(probability)
end

enemy_setup {type = data.raw["unit-spawner"]["small-infestation-cyst"], order = "ad", prob_max = 1 / 50, begin = 1}
enemy_setup {type = data.raw["unit-spawner"]["medium-infestation-cyst"], order = "ac", prob_max = 1 / 50, begin = 3}
enemy_setup {type = data.raw["unit-spawner"]["big-infestation-cyst"], order = "ab", prob_max = 1 / 50, begin = 4}
enemy_setup {type = data.raw["unit-spawner"]["behemoth-infestation-cyst"], order = "aa", prob_max = 1 / 50, begin = 5}
enemy_setup {type = data.raw["turret"]["small-worm-turret"], order = "bd", prob_max = 1 / 25, begin = 1}
enemy_setup {type = data.raw["turret"]["medium-worm-turret"], order = "bc", prob_max = 1 / 25, begin = 3}
enemy_setup {type = data.raw["turret"]["big-worm-turret"], order = "bb", prob_max = 1 / 25, begin = 4}
enemy_setup {type = data.raw["turret"]["behemoth-worm-turret"], order = "ba", prob_max = 1 / 25, begin = 5}
