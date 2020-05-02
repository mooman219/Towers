require("defines")

if settings.startup[PARAM_LAB_SPEED_NAME].value then
    data:extend({
        {
            type = "technology",
            name = "research-speed-7",
            icon_size = 128,
            icon = "__base__/graphics/technology/research-speed.png",
            effects = {{type = "laboratory-speed", modifier = 0.6}},
            prerequisites = {"research-speed-6"},
            unit = {
                count_formula = "2^(L-6)*1000",
                ingredients = {
                    {"automation-science-pack", 1},
                    {"logistic-science-pack", 1},
                    {"chemical-science-pack", 1},
                    {"production-science-pack", 1},
                    {"utility-science-pack", 1},
                    {"space-science-pack", 1},
                },
                time = 60,
            },
            upgrade = true,
            max_level = "infinite",
            order = "c-m-d",
        },
    })
end

if settings.startup[PARAM_INSERTER_CAPACITY_NAME].value then
    data:extend({
        {
            type = "technology",
            name = "inserter-capacity-bonus-8",
            icon = "__base__/graphics/technology/inserter-capacity.png",
            icon_size = 128,
            prerequisites = {"inserter-capacity-bonus-7", "space-science-pack"},
            effects = {
                {type = "inserter-stack-size-bonus", modifier = 0.25},
                {type = "stack-inserter-capacity-bonus", modifier = 1},
            },
            unit = {
                count_formula = "2^(L-7)*1000",
                ingredients = {
                    {"automation-science-pack", 1},
                    {"logistic-science-pack", 1},
                    {"chemical-science-pack", 1},
                    {"production-science-pack", 1},
                    {"utility-science-pack", 1},
                    {"space-science-pack", 1},
                },
                time = 60,
            },
            max_level = "infinite",
            upgrade = true,
            order = "c-k-f-e",
        },
    })
end

if settings.startup[PARAM_WORKER_ROBOTS_STORAGE_NAME].value then
    data:extend({
        {
            type = "technology",
            name = "worker-robots-storage-4",
            icon = "__base__/graphics/technology/worker-robots-storage.png",
            icon_size = 128,
            prerequisites = {"worker-robots-storage-3", "space-science-pack"},
            effects = {{type = "worker-robot-storage", modifier = 1}},
            unit = {
                count_formula = "2^(L-4)*1000",
                ingredients = {
                    {"automation-science-pack", 1},
                    {"logistic-science-pack", 1},
                    {"chemical-science-pack", 1},
                    {"production-science-pack", 1},
                    {"utility-science-pack", 1},
                    {"space-science-pack", 1},
                },
                time = 60,
            },
            max_level = "infinite",
            upgrade = true,
            order = "c-k-f-e",
        },
    })
end

if settings.startup[PARAM_WORKER_ROBOTS_BATTERY_NAME].value then
    data:extend({
        {
            type = "technology",
            name = "worker-robot-battery-1",
            icon = "__Tower__/graphics/technology/worker-robot-battery.png",
            icon_size = 128,
            effects = {{type = "worker-robot-battery", modifier = 0.1}},
            prerequisites = {"robotics"},
            unit = {
                count_formula = "100*L",
                ingredients = {
                    {"automation-science-pack", 1},
                    {"logistic-science-pack", 1},
                    {"chemical-science-pack", 1},
                },
                time = 30,
            },
            upgrade = true,
            max_level = "3",
            order = "c-k-h-e",
        },
        {
            type = "technology",
            name = "worker-robot-battery-4",
            icon = "__Tower__/graphics/technology/worker-robot-battery.png",
            icon_size = 128,
            effects = {{type = "worker-robot-battery", modifier = 0.1}},
            prerequisites = {"worker-robot-battery-1"},
            unit = {
                count_formula = "100*L",
                ingredients = {
                    {"automation-science-pack", 1},
                    {"logistic-science-pack", 1},
                    {"chemical-science-pack", 1},
                    {"production-science-pack", 1},
                },
                time = 45,
            },
            upgrade = true,
            max_level = "7",
            order = "c-k-h-e",
        },
        {
            type = "technology",
            name = "worker-robot-battery-8",
            icon = "__Tower__/graphics/technology/worker-robot-battery.png",
            icon_size = 128,
            effects = {{type = "worker-robot-battery", modifier = 0.1}},
            prerequisites = {"worker-robot-battery-4"},
            unit = {
                count_formula = "100*L",
                ingredients = {
                    {"automation-science-pack", 1},
                    {"logistic-science-pack", 1},
                    {"chemical-science-pack", 1},
                    {"production-science-pack", 1},
                    {"utility-science-pack", 1},
                },
                time = 60,
            },
            upgrade = true,
            max_level = "11",
            order = "c-k-h-e",
        },
        {
            type = "technology",
            name = "worker-robot-battery-12",
            icon = "__Tower__/graphics/technology/worker-robot-battery.png",
            icon_size = 128,
            effects = {{type = "worker-robot-battery", modifier = 0.1}},
            prerequisites = {"worker-robot-battery-8", "space-science-pack"},
            unit = {
                count_formula = "2^(L-11)*1000",
                ingredients = {
                    {"automation-science-pack", 1},
                    {"logistic-science-pack", 1},
                    {"chemical-science-pack", 1},
                    {"production-science-pack", 1},
                    {"utility-science-pack", 1},
                    {"space-science-pack", 1},
                },
                time = 60,
            },
            upgrade = true,
            max_level = "infinite",
            order = "c-k-h-e",
        },
    })
end
