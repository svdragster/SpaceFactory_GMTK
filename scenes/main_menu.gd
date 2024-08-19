extends Control

@export var universe: Universe


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	%Cog.rotate(0.5 * delta)
	%CogShadow.rotate(0.5 * delta)


func _on_play_pressed() -> void:
	hide()
	%Play.hide()
	%Continue.show()
	universe.start()

func _on_continue_pressed() -> void:
	universe.unpause()

func _on_exit_pressed() -> void:
	get_tree().quit()
