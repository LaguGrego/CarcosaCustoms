class_name LuggageGenerator

extends Node2D

@export var grid_width := 20
@export var grid_height := 20

var occupied := {}

var rows: int
var columns: int

var cell_width: float
var cell_height: float

var area: Area2D

var belongings: Array[Belonging] = []

@onready var spawn_container = $SpawnContainer

func _ready() -> void:
	spawn_container.luggage_type_changed.connect(
		_on_luggage_type_changed
	)

func _on_luggage_type_changed(
	luggage_code: int,
	new_area: Area2D
) -> void:

	print("Nuevo tipo:", luggage_code)

	area = new_area

	print("Area seleccionada:", area.name)

	_rebuild_grid()

	_clean_belongings()

	_create_new_belongings()

func _rebuild_grid() -> void:

	if area == null:
		push_error("No hay area seleccionada")
		return

	var collision_shape := area.get_node_or_null("CollisionShape2D")

	if collision_shape == null:
		push_error("%s no tiene CollisionShape2D" % area.name)
		return

	var shape = collision_shape.shape

	if shape is RectangleShape2D:

		var rect_shape := shape as RectangleShape2D

		# RectangleShape2D.size es el tamaño total
		var width_px := rect_shape.size.x
		var height_px := rect_shape.size.y

		cell_width = width_px / float(grid_width)
		cell_height = height_px / float(grid_height)

		rows = grid_height
		columns = grid_width

		occupied.clear()

		print("Grid reconstruida")
		print("Width:", width_px)
		print("Height:", height_px)
		print("Cell Width:", cell_width)
		print("Cell Height:", cell_height)

	else:
		push_error(
			"%s usa una shape que no es RectangleShape2D"
			% area.name
		)

func _clean_belongings() -> void:

	for child in get_children():

		# evita borrar nodos propios del sistema
		if child == spawn_container:
			continue

		child.queue_free()

func _create_new_belongings() -> void:

	print("TODO: generar objetos")

	# ejemplo futuro:
	#
	# while porcentaje_ocupado < target_fill:
	#     item = item_database.get_random()
	#     intentar_spawnear(item)
