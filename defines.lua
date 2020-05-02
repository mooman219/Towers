-- Tower generation settings for ore, land, water, and enemies.
ORE_REPEAT = 10
TOWER_WIDTH = 10
WATER_WIDTH = 20
ENEMY_MAX = 60

-- Computed values for the tower generation settings.
CHUNK = 32
RIDGE = 16
TELEPORT_DISTANCE = CHUNK * (TOWER_WIDTH + WATER_WIDTH)
TOWER_RIDGE = TOWER_WIDTH * RIDGE
WATER_RIDGE = WATER_WIDTH * RIDGE
ORE_RIDGE = ORE_REPEAT * RIDGE
ORE_CHUNK = ORE_REPEAT * CHUNK
ENEMY_MAX_CHUNK = ENEMY_MAX * CHUNK

-- Parameters
PARAM_WORKER_ROBOTS_STORAGE = true
PARAM_WORKER_ROBOTS_STORAGE_NAME = 'worker-robots-storage-research'
PARAM_WORKER_ROBOTS_BATTERY = true
PARAM_WORKER_ROBOTS_BATTERY_NAME = 'worker-robot-battery-research'
PARAM_INSERTER_CAPACITY = true
PARAM_INSERTER_CAPACITY_NAME = 'inserter-capacity-research'
PARAM_LAB_SPEED = true
PARAM_LAB_SPEED_NAME = 'lab-speed-research'
PARAM_BETTER_INSERTERS = true
PARAM_BETTER_INSERTERS_NAME = 'better-inserters-research'
PARAM_BETTER_ROBOPORTS = true
PARAM_BETTER_ROBOPORTS_NAME = 'better-roboports-research'
