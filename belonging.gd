class_name Belonging
extends Area2D

@onready var collision_shape := $CollisionShape2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pickTexture()
	pass # Replace with function body.

func pickTexture() -> void:
	# 0: black , 1: blue , 2: brown , 3: green , 4: red
	var luggage_types = Array($AnimatedSprite2D.sprite_frames.get_animation_names())
	$AnimatedSprite2D.animation = luggage_types.pick_random()
	$AnimatedSprite2D.frame = randi() % 14
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
