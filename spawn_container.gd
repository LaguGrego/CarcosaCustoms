extends Area2D

signal luggage_type_changed(luggage_code: int, new_area: Area2D)
@export var selected_content_area: Area2D
@onready var areas := {
	0: $AreaBlack,
	1: $AreaBlue,
	2: $AreaBrown,
	3: $AreaGreen,
	4: $AreaRed,
}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
	
func set_luggage_type(luggage_code: int) -> void:
	selected_content_area = areas.get(luggage_code)

	if selected_content_area == null:
		push_warning("Tipo de equipaje desconocido: %s" % luggage_code)
		return

	# Avisar a quien esté escuchando
	luggage_type_changed.emit(
		luggage_code,
		selected_content_area
	)
			
func get_selected_content_area() -> Area2D:
	if selected_content_area:
		return selected_content_area

	push_warning("No hay content area seleccionada")
	return null

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
