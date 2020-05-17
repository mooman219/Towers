-- Tiles will no longer absorb pollution.
local tiles = data.raw["tile"]
for _, tile in pairs(tiles) do
    tile.pollution_absorption_per_second = 0.0
end

-- Pollution is only absorbed by water.
tiles["deepwater"].pollution_absorption_per_second = 0.0002
tiles["deepwater-green"].pollution_absorption_per_second = 0.0002
tiles["water"].pollution_absorption_per_second = 0.0002
tiles["water-green"].pollution_absorption_per_second = 0.0002
tiles["water-shallow"].pollution_absorption_per_second = 0.0002
