extends Node

signal on_built_event(player: Node, space_object: Node3D, building_type: String, amount: int)
signal on_object_select_event(player: Node, space_object: Node3D)
signal on_zoom(universe: Universe)

signal on_win()

signal on_buy_sound()
signal on_error_sound()
signal on_button_sound()
signal on_win_sound()
signal on_attention_sound()

var speed: int = 1

var buy_factor: int = 1

var disable_rays := false
