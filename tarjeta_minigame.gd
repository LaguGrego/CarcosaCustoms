extends Control

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$"Reader/GreenLight".visible = false
	$Reader/RedLight.visible = false
	pass # Replace with function body.

func set_forbidden(forbidden : bool)->void:
	$Wallet/Card.set_forbidden(forbidden)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
