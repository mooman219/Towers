require("prototypes/decorative")
require("prototypes/elevation")
require("prototypes/enemy")
require("prototypes/inserter")
require("prototypes/ore")
require("prototypes/research")
require("prototypes/roboport")
require("prototypes/pollution")

-- Nerf manual artillery for multiplayer.
data.raw["artillery-turret"]["artillery-turret"].manual_range_modifier = 0.99
data.raw["artillery-wagon"]["artillery-wagon"].manual_range_modifier = 0.99
