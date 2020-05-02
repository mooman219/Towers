require("util")
require("defines")
require("lib/misc")

if settings.startup[PARAM_BETTER_INSERTERS_NAME].value then
    data:extend({
        {
            type = "technology",
            name = "fast-stack-inserter",
            icon = "__Tower__/graphics/technology/fast-stack-inserter.png",
            icon_size = 128,
            effects = {
                {type = "unlock-recipe", recipe = "fast-stack-inserter"},
                {type = "unlock-recipe", recipe = "fast-stack-filter-inserter"},
            },
            prerequisites = {"advanced-electronics-2", "stack-inserter"},
            unit = {
                count = 100,
                ingredients = {
                    {"automation-science-pack", 1},
                    {"logistic-science-pack", 1},
                    {"chemical-science-pack", 1},
                },
                time = 30,
            },
            upgrade = false,
            order = "c-o-a",
        },
    })
end

local red_base_platform = {
    sheet = {
        filename = "__base__/graphics/entity/long-handed-inserter/long-handed-inserter-platform.png",
        priority = "extra-high",
        width = 46,
        height = 46,
        shift = {0.09375, 0},
        hr_version = {
            filename = "__base__/graphics/entity/long-handed-inserter/hr-long-handed-inserter-platform.png",
            priority = "extra-high",
            width = 105,
            height = 79,
            shift = util.by_pixel(1.5, 7.5 - 1),
            scale = 0.5,
        },
    },
};

local item_stack = deepcopy(data.raw["item"]["stack-inserter"])
local inserter_stack = deepcopy(data.raw["inserter"]["stack-inserter"])

item_stack.name = "fast-stack-inserter";
item_stack.place_result = "fast-stack-inserter";
item_stack.order = "h[fast-stack-inserter]";
item_stack.icon = "__Tower__/graphics/fast-stack-inserter.png";

inserter_stack.name = "fast-stack-inserter";
inserter_stack.minable = {mining_time = 0.1, result = "fast-stack-inserter"};
inserter_stack.icon = "__Tower__/graphics/fast-stack-inserter.png";
inserter_stack.extension_speed = 10;
inserter_stack.rotation_speed = 10;
inserter_stack.energy_per_movement = "45KJ";
inserter_stack.energy_per_rotation = "45KJ";
inserter_stack.platform_picture = red_base_platform;

local item_filter = deepcopy(data.raw["item"]["stack-filter-inserter"])
local inserter_filter = deepcopy(data.raw["inserter"]["stack-filter-inserter"])

item_filter.name = "fast-stack-filter-inserter";
item_filter.place_result = "fast-stack-filter-inserter";
item_filter.order = "i[fast-stack-filter-inserter]";
item_filter.icon = "__Tower__/graphics/fast-stack-filter-inserter.png";

inserter_filter.name = "fast-stack-filter-inserter";
inserter_filter.minable = {mining_time = 0.1, result = "fast-stack-filter-inserter"};
inserter_filter.icon = "__Tower__/graphics/fast-stack-filter-inserter.png";
inserter_filter.extension_speed = 10;
inserter_filter.rotation_speed = 10;
inserter_filter.energy_per_movement = "45KJ";
inserter_filter.energy_per_rotation = "45KJ";
inserter_filter.platform_picture = red_base_platform;

data:extend({
    {
        type = "recipe",
        name = "fast-stack-inserter",
        enabled = false,
        ingredients = {{"stack-inserter", 1}, {"advanced-circuit", 15}, {"processing-unit", 1}},
        result = "fast-stack-inserter",
    },
    {
        type = "recipe",
        name = "fast-stack-filter-inserter",
        enabled = false,
        ingredients = {{"fast-stack-inserter", 1}, {"processing-unit", 1}},
        result = "fast-stack-filter-inserter",
    },
    item_stack,
    item_filter,
    inserter_stack,
    inserter_filter,
})
