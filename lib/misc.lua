local noise = require("noise")

function deepcopy(orig)
    local orig_type = type(orig)
    local copy
    if orig_type == 'table' then
        copy = {}
        for orig_key, orig_value in next, orig, nil do
            copy[deepcopy(orig_key)] = deepcopy(orig_value)
        end
        setmetatable(copy, deepcopy(getmetatable(orig)))
    else -- number, string, boolean, etc
        copy = orig
    end
    return copy
end

function water_level_correction(to_be_corrected, map)
    return noise.max(map.wlc_elevation_minimum, to_be_corrected + map.wlc_elevation_offset)
end
