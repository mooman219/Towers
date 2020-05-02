local noise = require("noise")
local tne = noise.to_noise_expression

-- Remove decorative placements. These bloat map sizes.
local decoratives = data.raw["optimized-decorative"]
for key, decorative in pairs(decoratives) do
    if decorative.autoplace ~= nil then
        decorative.autoplace.probability_expression = tne(0);
    end
end
