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
		"population": 2_500,
		"ore": 150,
	},
	"space_station": {
		"coins": 1_500,
		"population": 2_000,
	},
	"dyson_sphere": {
		"coins": 150_000,
		"resources": 15_000,
		"population": 100_000,
	},
	"interstellar_travel": {
		"coins": 1_000_000,
		"resources": 100_000,
		"energy": 30_000,
	},
	"dark_matter_collector": {
		"coins": 100_000_000,
		"energy": 250_000,
		"resources": 1_000_000,
	}
}

static var production = {
	"city": {
		"population": 10.0,
		"coins": 2.0,
	},
	"mine": {
		"ore": 2.0,
		"population": -4.0,
	},
	"factory": {
		"ore": -5.0,
		"resources": 3.0,
		"coins": 75.0,
		"population": -75.0,
	},
	"space_station": {
		"coins": -25.0,
		"population": -1.0,
	},
	"dyson_sphere": {
		"energy": 1.0,
		"coins": -2000.0,
		"resources": -100.0,
	},
	"interstellar_travel": {
		"energy": -1.0,
		"coins": -10_000.0,
	},
	"dark_matter_collector": {
		"dark_matter": 1.0,
		"energy": -100.0,
		"coins": -10_000.0,
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
