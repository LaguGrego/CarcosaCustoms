class_name LuggageGenerator
extends Node2D

@export var grid_width := 10
@export var grid_height := 10
@export var item_textures: Array[Texture2D] = []
@export var item_scale: float = 0.5
@export var items_to_spawn := 8
@export var max_attempts := 2000
@export var max_occupancy := 0.8

var area: Area2D
var area_rect: Rect2
var belongings: Array[BelongingSpawnEngine.Belonging] = []
var spawned_nodes: Array[Node] = []

# Variables para drag
var dragged_item: Node2D = null
var drag_offset: Vector2 = Vector2.ZERO

@onready var spawn_container = $"../SpawnContainer"


func _ready() -> void:
	spawn_container.luggage_type_changed.connect(_on_luggage_type_changed)


func _on_luggage_type_changed(luggage_code: int, new_area: Area2D) -> void:
	# Si ya hay objetos, no regenerar
	if not spawned_nodes.is_empty():
		return

	area = new_area

	if not _rebuild_area_rect():
		return

	_create_new_belongings()


func clear() -> void:
	_clean_belongings()


func _rebuild_area_rect() -> bool:
	if area == null:
		return false

	var collision_shape := area.get_node_or_null("CollisionShape2D")
	if collision_shape == null:
		return false

	var shape = collision_shape.shape
	if not (shape is RectangleShape2D):
		return false

	var rect_shape := shape as RectangleShape2D
	var size_px: Vector2 = rect_shape.size
	var center: Vector2 = area.global_position + collision_shape.position
	area_rect = Rect2(center - size_px / 2.0, size_px)
	return true


func _clean_belongings() -> void:
	for node in spawned_nodes:
		if is_instance_valid(node):
			node.queue_free()
	spawned_nodes.clear()
	belongings.clear()
	dragged_item = null


func _create_new_belongings() -> void:
	if item_textures.is_empty():
		return

	var item_pool: Array = []
	for tex in item_textures:
		item_pool.append({
			"texture": tex,
			"size": tex.get_size() * item_scale
		})

	var cell_size := Vector2(
		area_rect.size.x / float(grid_width),
		area_rect.size.y / float(grid_height)
	)

	belongings = BelongingSpawnEngine.generate_random_belongings(
		area_rect, item_pool, items_to_spawn, max_attempts, cell_size, max_occupancy
	)

	for b in belongings:
		var instance := b.instantiate_node()
		if instance == null:
			continue
		instance.scale = Vector2(item_scale, item_scale)
		add_child(instance)
		spawned_nodes.append(instance)


func _input(event: InputEvent) -> void:
	if spawned_nodes.is_empty():
		return

	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			# Buscar qué item está bajo el mouse
			for item in spawned_nodes:
				if not item is Sprite2D:
					continue
				var tex_size: Vector2 = (item as Sprite2D).texture.get_size() * item.scale
				var item_rect := Rect2(item.global_position, tex_size)
				if item_rect.has_point(event.global_position):
					dragged_item = item
					drag_offset = item.global_position - event.global_position
					get_viewport().set_input_as_handled()
					break
		else:
			dragged_item = null

	elif event is InputEventMouseMotion and dragged_item != null:
		dragged_item.global_position = event.global_position + drag_offset
		get_viewport().set_input_as_handled()
