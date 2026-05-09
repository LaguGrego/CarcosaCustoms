extends Button

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print(get_parent().get_children())
	pressed.connect(_button_pressed)
	pass # Replace with function body.

func _button_pressed():
	get_node("../CharacterBody2D/miRobot").move()
	get_node("../CharacterBody2D2/miRobot").show_robot()
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
