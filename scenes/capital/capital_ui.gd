extends Control

@export var capital: Capital

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for c in $VBoxContainer.get_children():
		c.capital = capital


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
