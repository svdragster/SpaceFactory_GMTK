extends Node

var index := 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	%Start.play()
	Globals.on_buy_sound.connect(_on_buy_sound_listener)
	Globals.on_error_sound.connect(_on_error_sound_listener)
	Globals.on_button_sound.connect(_on_button_sound_listener)
	Globals.on_win_sound.connect(_on_win_sound_listener)
	Globals.on_attention_sound.connect(_on_attention_sound_listener)


func _on_start_finished() -> void:
	%Game1.seek(0)
	%Game1.play()


func _on_game_1_finished() -> void:
	%Game2.seek(0)
	%Game2.play()


func _on_game_2_finished() -> void:
	%Game1.seek(0)
	%Game1.play()

func _on_buy_sound_listener() -> void:
	%Buy.pitch_scale = randf_range(0.8, 1.3)
	%Buy.play()
	
func _on_error_sound_listener() -> void:
	%Error.pitch_scale = randf_range(0.9, 1.1)
	%Error.play()
	
func _on_button_sound_listener() -> void:
	%Button.play()
	
func _on_win_sound_listener() -> void:
	%Win.play()
	
func _on_attention_sound_listener() -> void:
	%Attention.play()
