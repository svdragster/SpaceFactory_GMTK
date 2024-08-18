extends Node

signal on_built_event(player: Node, building_type: String, amount: int)

var speed: int = 1

var disable_rays := false
