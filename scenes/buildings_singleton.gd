extends Node

static var all_buildings = {
	"city": {
		"coins": 1000,
	},
	"mine": {
		"coins": 2000,
	},
	"factory": {
		"coins": 1000,
		"population": 10_000,
	},
	"space_station": {
		"coins": 100_000,
		"resources": 1_000,
	},
	"dyson_sphere": {
		"coins": 1_000_000,
		"resources": 1_000_000,
	},
	"dark_matter_collector": {
		"coins": 1_000_000_000,
		"energy": 1_000_000,
	}
}

static var production = {
	"city": {
		"population": 10.0,
	},
	"mine": {
		"resources": 1.0,
	},
	"factory": {
		"coins": 1.0,
	},
	"space_station": {
		#"coins": 1,
	},
	"dyson_sphere": {
		"energy": 1.0,
	},
	"dark_matter_collector": {
		"dark_matter": 1.0,
	}
}
