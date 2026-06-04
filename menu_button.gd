extends MenuButton


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var popup = $MenuButton.get_popup()

	popup.add_item("Escaner", 0)
	popup.add_item("", 1)
	popup.add_item("Invisible", 2)

	popup.id_pressed.connect(_menu_selected)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
	
