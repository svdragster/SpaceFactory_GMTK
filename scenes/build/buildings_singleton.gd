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
		"coins": 150_000,
		"resources": 15_000,
		"population": 100_000,
	},
	"interstellar_travel": {
		"coins": 100_000,
		"resources": 100_000,
		"energy": 100_000,
	},
	"dark_matter_collector": {
		"coins": 100_000_000,
		"energy": 250_000,
		"resources": 10_000_000,
	}
}

static var production = {
	"city": {
		"population": 12.0,
		"coins": 3.0,
	},
	"mine": {
		"ore": 2.0,
		"population": -1.0,
	},
	"factory": {
		"ore": -5.0,
		"resources": 1.0,
		"coins": 100.0,
		"population": -10.0,
	},
	"space_station": {
		"coins": -25.0,
		"population": -1.0,
	},
	"dyson_sphere": {
		"energy": 1.0,
		"coins": -1000.0,
		"resources": -500.0,
	},
	"interstellar_travel": {
		"energy": -1.0,
		"coins": -200.0,
	},
	"dark_matter_collector": {
		"dark_matter": 1.0,
		"energy": -1000.0,
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
