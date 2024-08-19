extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hide()
	Globals.on_win.connect(_on_win_listener)


func _on_win_listener() -> void:
	var total_play_time_seconds: float = get_node("/root/Universe").play_time
	var play_time_minutes: int = int(total_play_time_seconds / 60)
	var play_time_seconds: int = int(total_play_time_seconds - int(play_time_minutes*60))
	%Playtime.text = "{0}m {1}s".format([play_time_minutes, play_time_seconds])
	show()
	Globals.on_win_sound.emit()


func _on_button_pressed() -> void:
	hide()
	Globals.on_button_sound.emit()
