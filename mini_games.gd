extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func _trigger_minigame(belonging : BelongingSpawnEngine.Belonging) -> void:
	if ($"../../../World".selected_tool == 4 ):
		print("modo especial")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
