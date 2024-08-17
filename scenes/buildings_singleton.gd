extends Node

static var all_buildings = {
	"city": {
		"coins": 1000,
	},
	"mine": {
		"coins": 2000,
	},
	"factory": {
		"coins": 10_000,
		"population": 10_000,
		"ore": 100,
	},
	"space_station": {
		"coins": 100_000,
		"resources": 1_000,
	},
	"dyson_sphere": {
		"coins": 1_000_000,
		"resources": 1_000_000,
	},
	"interstellar_travel": {
		"coins": 100_000,
		"resources": 100_000,
		"energy": 100_000,
	},
	"dark_matter_collector": {
		"coins": 1_000_000_000,
		"energy": 1_000_000_000,
	}
}

static var production = {
	"city": {
		"population": 10.0,
		"coins": 1.0,
	},
	"mine": {
		"ore": 1.0,
		"coins": -5.0,
	},
	"factory": {
		"ore": -10.0,
		"resources": 1.0,
		"coins": 10.0,
		"population": -20.0,
	},
	"space_station": {
		"coins": -10.0,
	},
	"dyson_sphere": {
		"energy": 1.0,
	},
	"interstellar_travel": {
		"energy": -10.0,
	},
	"dark_matter_collector": {
		"dark_matter": 1.0,
		"energy": -100.0,
	}
}

static var mappings = {
	"population": "Population",
	"coins": "Coins",
	"ore": "Ore",
	"resources": "Resources",
	"energy": "Energy",
	"dark_matter": "Dark Matter",
	"city": "City",
	"mine": "Mine",
	"factory": "Factory",
	"space_station": "Space Station",
	"dyson_sphere": "Dyson Sphere",
	"interstellar_travel": "Interstellar Travel",
	"dark_matter_collector": "Dark Matter Collector",
}
