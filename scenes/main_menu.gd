extends Control

@export var universe: Universe

func _ready() -> void:
	_on_music_volume_value_changed(%MusicVolume.value)
	_on_sound_volume_value_changed(%SoundVolume.value)

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
	Globals.on_button_sound.emit()
	await get_tree().create_timer(0.4).timeout
	get_tree().quit()


func _on_music_volume_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), linear_to_db(value))


func _on_sound_volume_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("SoundEffects"), linear_to_db(value))
	Globals.on_button_sound.emit()
