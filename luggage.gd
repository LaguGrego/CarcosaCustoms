extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pickTexture()
	pass # Replace with function body.

func pickTexture() -> void:
	var luggage_types = Array($AnimatedSprite2D.sprite_frames.get_animation_names())
	$AnimatedSprite2D.animation = luggage_types.pick_random()
	$AnimatedSprite2D.frame = randi() % 4
	$AnimationPlayer.play("luggage_appear")
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
