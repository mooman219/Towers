require("defines")

data:extend({
    {
        type = "bool-setting",
        name = PARAM_WORKER_ROBOTS_STORAGE_NAME,
        setting_type = "startup",
        default_value = PARAM_WORKER_ROBOTS_STORAGE,
        order = "a"
    },
    {
        type = "bool-setting",
        name = PARAM_WORKER_ROBOTS_BATTERY_NAME,
        setting_type = "startup",
        default_value = PARAM_WORKER_ROBOTS_BATTERY,
        order = "b"
    }
})