extends Area2D

@onready var notepad_screen := $"../../../Canvas/Screens/Docs/Notepad"
@onready var notepad_contain:= $"../../../Canvas/Screens/Docs/notepad_contain"
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.input_event.connect(_on_input_event)
	pass # Replace with function body.
	

func _on_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			notepad_screen.visible = !notepad_screen.visible
			notepad_contain.visible = !notepad_contain.visible



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
