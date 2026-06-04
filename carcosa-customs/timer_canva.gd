extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
var tiempo := 0.0

func _process(delta):
	tiempo += delta
	$Label.text = str(round(tiempo))
