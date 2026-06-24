extends Area2D

@onready var luggage_content_screen = $"../../../Canvas/Screens/Luggage"

func _ready() -> void:
	pickTexture()

func pickTexture() -> void:
	var luggage_types = Array($AnimatedSprite2D.sprite_frames.get_animation_names())
	$AnimatedSprite2D.animation = luggage_types.pick_random()
	$AnimatedSprite2D.frame = 1
	$AnimationPlayer.play("luggage_appear")

func _input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton \
	and event.button_index == MOUSE_BUTTON_LEFT \
	and event.is_pressed() \
	and !$AnimationPlayer.is_playing():
		self.trigger_luggage_open()

func trigger_luggage_open() -> void:
	print("1. Click en valija, frame:", $AnimatedSprite2D.frame)
	luggage_content_screen.set_luggage_content_type($AnimatedSprite2D.frame)

func _process(delta: float) -> void:
	pass
