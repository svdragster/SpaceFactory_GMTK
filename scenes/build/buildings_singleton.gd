extends Node

static var all_buildings = {
	"city": {
		"coins": 250,
	},
	"mine": {
		"coins": 1000,
	},
	"factory": {
		"coins": 4_000,
		"population": 5_000,
		"ore": 100,
	},
	"space_station": {
		"coins": 1_500,
		"population": 2_000,
	},
	"dyson_sphere": {
		"coins": 250_000,
		"resources": 15_000,
		"population": 50_000,
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
		"population": 12.0,
		"coins": 5.0,
	},
	"mine": {
		"ore": 1.0,
		"population": -1.0,
	},
	"factory": {
		"ore": -5.0,
		"resources": 1.0,
		"coins": 10.0,
		"population": -6.0,
	},
	"space_station": {
		"coins": -20.0,
		"population": -1.0,
	},
	"dyson_sphere": {
		"energy": 1.0,
		"coins": -500.0,
	},
	"interstellar_travel": {
		"energy": -0.5,
		"coins": -50.0,
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
