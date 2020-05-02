require("defines")

data:extend({
    {
        type = "bool-setting",
        name = PARAM_WORKER_ROBOTS_STORAGE_NAME,
        setting_type = "startup",
        default_value = PARAM_WORKER_ROBOTS_STORAGE,
        order = "a",
    },
    {
        type = "bool-setting",
        name = PARAM_WORKER_ROBOTS_BATTERY_NAME,
        setting_type = "startup",
        default_value = PARAM_WORKER_ROBOTS_BATTERY,
        order = "b",
    },
    {
        type = "bool-setting",
        name = PARAM_INSERTER_CAPACITY_NAME,
        setting_type = "startup",
        default_value = PARAM_INSERTER_CAPACITY,
        order = "c",
    },
    {
        type = "bool-setting",
        name = PARAM_LAB_SPEED_NAME,
        setting_type = "startup",
        default_value = PARAM_LAB_SPEED,
        order = "d",
    },
    {
        type = "bool-setting",
        name = PARAM_BETTER_INSERTERS_NAME,
        setting_type = "startup",
        default_value = PARAM_BETTER_INSERTERS,
        order = "e",
    },
    {
        type = "bool-setting",
        name = PARAM_BETTER_ROBOPORTS_NAME,
        setting_type = "startup",
        default_value = PARAM_BETTER_ROBOPORTS,
        order = "f",
    },
})
