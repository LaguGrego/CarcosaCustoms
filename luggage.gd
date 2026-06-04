extends Area2D

@onready var luggage_content_screen = $"../../../Canvas/Screens/Luggage"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pickTexture()
	pass # Replace with function body.

func pickTexture() -> void:
	# 0: black , 1: blue , 2: brown , 3: green , 4: red
	var luggage_types = Array($AnimatedSprite2D.sprite_frames.get_animation_names())
	$AnimatedSprite2D.animation = luggage_types.pick_random()
	$AnimatedSprite2D.frame = randi() % 5
	$AnimationPlayer.play("luggage_appear")
	

func _input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton \
	and event.button_index == MOUSE_BUTTON_LEFT \
	and event.is_pressed() \
	and !$AnimationPlayer.is_playing():
		self.trigger_luggage_open()

func trigger_luggage_open():
	luggage_content_screen.set_luggage_content_type($AnimatedSprite2D.frame)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
