extends AnimatedSprite2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var Luggage_type = Array($AnimatedSprite2D.sprite_frames.gate_animation_names())
	$AnimatedSprite2D.animation = Luggage_type.pick_random()
	$AnimatedSprite2D.play()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
