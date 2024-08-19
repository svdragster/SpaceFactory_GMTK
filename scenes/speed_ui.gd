extends Control


func _on_speed_1_pressed() -> void:
	Globals.on_button_sound.emit()
	Globals.speed = 1


func _on_speed_2_pressed() -> void:
	Globals.on_button_sound.emit()
	Globals.speed = 3


func _on_speed_3_pressed() -> void:
	Globals.on_button_sound.emit()
	Globals.speed = 8

# Annoying workaround bullshit to prevent clicking through GUI
func _on_mouse_enter() -> void:
	Globals.disable_rays = true

func _on_mouse_exit() -> void:
	Globals.disable_rays = false
