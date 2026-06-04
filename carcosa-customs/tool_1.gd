extends Area2D

@export var cursor_texture: Texture2D

func _ready():
	input_pickable = true
	self.input_event.connect(_on_input_event)

func _on_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			
			Input.set_custom_mouse_cursor(cursor_texture)
