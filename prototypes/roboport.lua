require("util")
require("defines")
require("lib/misc")

if settings.startup[PARAM_BETTER_ROBOPORTS_NAME].value then
    data:extend({
        {
            type = "technology",
            name = "advanced-roboport",
            icon = "__Tower__/graphics/technology/advanced-roboport.png",
            icon_size = 128,
            effects = {{type = "unlock-recipe", recipe = "advanced-roboport"}},
            prerequisites = {"utility-science-pack"},
            unit = {
                count = 750,
                ingredients = {
                    {"automation-science-pack", 1},
                    {"logistic-science-pack", 1},
                    {"chemical-science-pack", 1},
                    {"utility-science-pack", 1},
                },
                time = 30,
            },
            upgrade = false,
            order = "c-k-d-z",
        },
    })
end

local item_roboport = deepcopy(data.raw["item"]["roboport"])
local roboport = deepcopy(data.raw["roboport"]["roboport"])

item_roboport.name = "advanced-roboport";
item_roboport.place_result = "advanced-roboport";
item_roboport.order = "c[signal]-b[roboport]";
item_roboport.icon = "__Tower__/graphics/roboport.png";

roboport.name = "advanced-roboport";
roboport.minable = {mining_time = 0.1, result = "advanced-roboport"};
roboport.energy_source = {
    type = "electric",
    usage_priority = "secondary-input",
    input_flow_limit = "40MW",
    buffer_capacity = "800MJ",
};
roboport.charging_energy = "4000kW";
roboport.charging_offsets = {
    {-1.5, -0.5},
    {1.5, -0.5},
    {1.5, 1.5},
    {-1.5, 1.5},
    {-1.5, -0.5},
    {1.5, -0.5},
    {1.5, 1.5},
    {-1.5, 1.5},
};
roboport.base = {
    layers = {
        {
            filename = "__Tower__/graphics/roboport-base.png",
            width = 143,
            height = 135,
            shift = {0.5, 0.25},
            hr_version = {
                filename = "__Tower__/graphics/hr-roboport-base.png",
                width = 228,
                height = 277,
                shift = util.by_pixel(2, 7.75),
                scale = 0.5,
            },
        },
        {
            filename = "__base__/graphics/entity/roboport/roboport-shadow.png",
            width = 147,
            height = 101,
            draw_as_shadow = true,
            shift = util.by_pixel(28.5, 19.25),
            hr_version = {
                filename = "__base__/graphics/entity/roboport/hr-roboport-shadow.png",
                width = 294,
                height = 201,
                draw_as_shadow = true,
                force_hr_shadow = true,
                shift = util.by_pixel(28.5, 19.25),
                scale = 0.5,
            },
        },
    },
};
roboport.base_patch = {
    filename = "__Tower__/graphics/roboport-base-patch.png",
    priority = "medium",
    width = 69,
    height = 50,
    frame_count = 1,
    shift = {0.03125, 0.203125},
    hr_version = {
        filename = "__Tower__/graphics/hr-roboport-base-patch.png",
        priority = "medium",
        width = 138,
        height = 100,
        frame_count = 1,
        shift = util.by_pixel(1.5, 5),
        scale = 0.5,
    },
};
roboport.icon = "__Tower__/graphics/roboport.png";

data:extend({
    {
        type = "recipe",
        name = "advanced-roboport",
        enabled = false,
        ingredients = {{"roboport", 1}, {"processing-unit", 15}},
        result = "advanced-roboport",
    },
    item_roboport,
    roboport,
})
