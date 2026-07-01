extends TextureRect

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Card.visible = false
	pass # Replace with function body.

func _gui_input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.pressed:
				$Card.set_active(true)
				$Card.visible = true
				
				
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
