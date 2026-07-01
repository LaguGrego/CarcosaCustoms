extends TextureRect

@onready var active := false
var dragging := false
var drag_offset := Vector2.ZERO
var original_y := 0.0
var original_x := 0.0
var forbidden := false


func _gui_input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.pressed:
				dragging = true
				drag_offset = get_global_mouse_position() - global_position
			else:
				dragging = false

# Called when the node enters the scene tree for the first time.
func _ready():
	original_y = global_position.y
	original_x = global_position.x
	
func is_active()->bool:
	return self.active
	
func is_forbidden()->bool:
	return self.forbidden

func set_forbidden(forbidden : bool)->void:
	self.forbidden = forbidden

func set_active(active : bool)->void:
	self.active = active
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if dragging:
		global_position.x = get_global_mouse_position().x - drag_offset.x
		global_position.y = original_y
	else:
		global_position.y = original_y
		global_position.x = original_x
