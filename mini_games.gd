extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _trigger_minigame(belonging: BelongingSpawnEngine.Belonging) -> void:
	if $"../../../World".selected_tool == 4:
		$CardSwipe.visible = true
		$CardSwipe.set_forbidden(belonging.is_forbidden())

		# Pausa todo el juego
		get_tree().paused = true

		# Este nodo y el minijuego siguen funcionando
		process_mode = Node.PROCESS_MODE_WHEN_PAUSED
		$CardSwipe.process_mode = Node.PROCESS_MODE_WHEN_PAUSED

func close_minigame():
	get_tree().paused = false
	$CardSwipe.visible = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
