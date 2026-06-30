## BelongingSpawnEngine.gd
##
## Puerto a GDScript de "belonging_spawn_engine.py".
## Coloca objetos ("Belongings") al azar SIN superposición dentro de
## un área rectangular (la pantalla de la valija abierta), usando una
## grilla de colisión por celdas. Misma idea que el prototipo en
## Python, pero con Rect2/Vector2 nativos de Godot.
##
## Diferencias a propósito respecto al original:
## - No hay una clase "Menu" aparte: el área a llenar es el Rect2 de
##   tu propio Control (la pantalla/panel de la valija), así que se
##   pasa directamente como parámetro a generate_random_belongings().
## - Se corrigió el bug de límite que te hacía crashear ("CRASH EN
##   CELDA..."): cuando el borde derecho/inferior de un objeto caía
##   justo en el límite de la grilla, la celda calculada quedaba
##   fuera de rango (índice == cols/rows). Acá se recorta (clamp) al
##   límite válido en vez de explotar.
## - Se usa la lógica de "debug_generate_random_belongings" (con AND),
##   que es la que realmente corre al final de tu script, en vez de
##   "generate_random_belongings" (con OR), que seguía intentando
##   colocar objetos incluso después de llegar a la cantidad pedida.
## - Si un objeto no entra en el área (item más grande que el
##   espacio disponible), se acota su posición en vez de crashear
##   como hacía random.randint con low > high.

class_name BelongingSpawnEngine
extends RefCounted



## Un objeto a colocar dentro del área (equivalente a "Belonging" en Python).
##
## Soporta dos formas de definir el objeto visual:
## - texture: una imagen simple (Texture2D) -> se crea un Sprite2D al vuelo.
## - scene:   una escena completa (PackedScene) -> para más adelante,
##            cuando los objetos necesiten ser clickeables/interactivos.
## Si no se especifica "size", y hay textura, el tamaño se deriva del
## tamaño real de la imagen.
class Belonging:
	extends RefCounted

	var texture: Texture2D
	var scene: PackedScene
	var size: Vector2
	var position: Vector2
	var z_index: int
	var item_code: int

	func _init(
		area: Rect2,
		p_size: Vector2,
		p_item_code: int,
		p_texture: Texture2D = null,
		p_scene: PackedScene = null,
		p_z_index: int = 0,
	) -> void:
		item_code = p_item_code
		texture = p_texture
		scene = p_scene
		z_index = p_z_index
		size = Vector2(1,1)

		var min_x := int(area.position.x)
		var max_x: int = max(min_x, int(area.end.x - p_size.x))
		var min_y := int(area.position.y)
		var max_y: int = max(min_y, int(area.end.y - p_size.y))
		
		position = Vector2(
			randi_range(min_x, max_x),
			randi_range(min_y, max_y)
		)

	func _is_special() -> bool:
		if item_code == 15:
			return true
		return false

	func get_rect() -> Rect2:
		return Rect2(position, size)

	func is_forbidden(forbidden_ids:Array[int]) -> bool:
		if item_code in forbidden_ids:
			return true
		return false
		
		
	## Crea el nodo visual ya ubicado (Sprite2D para texturas, o la
	## escena instanciada). El que llama solo necesita add_child().
	func instantiate_node() -> Node2D:
		var node: Node2D
		
		if texture != null:
			var sprite := Sprite2D.new()
			sprite.z_index = z_index
			sprite.texture = texture
			sprite.centered = false  # para que calce con la posición calculada
			node = sprite
		elif scene != null:
			node = scene.instantiate()
		else:
			push_error("Belonging sin texture ni scene asignados")
			return null

		node.global_position = position
		return node


class SpecialBelonging:
	extends RefCounted

	var allowed: bool
	var texture: Texture2D
	var scene: PackedScene
	var size: Vector2
	var position: Vector2
	var z_index: int
	var item_code: int


	func _init(
		area: Rect2,
		p_size: Vector2,
		p_item_code: int,
		p_texture: Texture2D = null,
		p_scene: PackedScene = null,
		p_z_index: int = 0,
	) -> void:
		allowed= randi() % 2
		item_code = p_item_code
		texture = p_texture
		scene = p_scene
		z_index = p_z_index
		size = Vector2(1,1)

		var min_x := int(area.position.x)
		var max_x: int = max(min_x, int(area.end.x - p_size.x))
		var min_y := int(area.position.y)
		var max_y: int = max(min_y, int(area.end.y - p_size.y))
		
		position = Vector2(
			randi_range(min_x, max_x),
			randi_range(min_y, max_y)
		)

	func get_rect() -> Rect2:
		return Rect2(position, size)

	func is_allowed()->bool:
		return allowed

		
	## Crea el nodo visual ya ubicado (Sprite2D para texturas, o la
	## escena instanciada). El que llama solo necesita add_child().
	func instantiate_node() -> Node2D:
		var node: Node2D
		
		if texture != null:
			var sprite := Sprite2D.new()
			sprite.z_index = z_index
			sprite.texture = texture
			sprite.centered = false  # para que calce con la posición calculada
			node = sprite
		elif scene != null:
			node = scene.instantiate()
		else:
			push_error("Belonging sin texture ni scene asignados")
			return null

		node.global_position = position
		return node

	
## Grilla de ocupación (equivalente a "Grid" en Python).
class SpawnGrid:
	extends RefCounted

	var origin: Vector2
	var cell_size: Vector2
	var rows: int
	var cols: int
	var occupied: Array  # occupied[row][col] -> bool

	func _init(p_origin: Vector2, area_size: Vector2, p_cell_size: Vector2) -> void:
		origin = p_origin
		cell_size = p_cell_size
		cols = roundi(area_size.x / cell_size.x)
		rows = roundi(area_size.y / cell_size.y)

		occupied = []
		for r in range(rows):
			var row: Array = []
			row.resize(cols)
			row.fill(false)
			occupied.append(row)

	func get_intersection_cells(rect: Rect2) -> Array[Vector2i]:
		var c0 := floori((rect.position.x - origin.x) / cell_size.x)
		var r0 := floori((rect.position.y - origin.y) / cell_size.y)
		var c1 := floori((rect.end.x - origin.x) / cell_size.x)
		var r1 := floori((rect.end.y - origin.y) / cell_size.y)

		# Recorte de límites (fix del bug "CRASH EN CELDA" del original)
		c0 = clamp(c0, 0, cols - 1)
		r0 = clamp(r0, 0, rows - 1)
		c1 = clamp(c1, 0, cols - 1)
		r1 = clamp(r1, 0, rows - 1)

		var cells: Array[Vector2i] = []
		for c in range(c0, c1 + 1):
			for r in range(r0, r1 + 1):
				cells.append(Vector2i(c, r))
		return cells

	func can_place(belonging: Belonging) -> bool:
		for cell in get_intersection_cells(belonging.get_rect()):
			if occupied[cell.y][cell.x]:
				return false
		return true

	func place(belonging: Belonging) -> void:
		for cell in get_intersection_cells(belonging.get_rect()):
			occupied[cell.y][cell.x] = true

	func occupancy() -> float:
		var total := rows * cols
		if total == 0:
			return 0.0
		var filled := 0
		for r in range(rows):
			for c in range(cols):
				if occupied[r][c]:
					filled += 1
		return float(filled) / float(total)


## Genera y coloca objetos al azar sin superposición dentro de "area".
##
## area:          Rect2 del panel/pantalla a llenar (ej: $Interior.get_rect()).
## item_pool:      Array de Dictionary. Cada uno necesita "texture"
##                 (Texture2D) o "scene" (PackedScene). "size" es
##                 opcional: si hay textura y no se da size, se usa
##                 el tamaño real de la imagen.
## amount:         Cantidad de objetos que se intenta colocar.
## max_attempts:   Tope de intentos (default 200, igual al original).
## cell_size:      Tamaño de celda de la grilla (default 64x64, igual al original).
## max_occupancy:  Corte por porcentaje de ocupación (default 0.8, igual al original).
##
## Devuelve un Array[Belonging] con scene/texture/size/position ya
## resueltos, listo para instanciar con belonging.instantiate_node().
static func generate_random_belongings(
	area: Rect2,
	item_pool: Array,
	amount: int,
	max_attempts: int = 200,
	cell_size: Vector2 = Vector2(64, 64),
	max_occupancy: float = 0.8
) -> Array[Belonging]:

	var grid := SpawnGrid.new(area.position, area.size, cell_size)
	var placed: Array[Belonging] = []

	var created := 0
	var attempts := 0

	while created < amount and attempts < max_attempts and grid.occupancy() < max_occupancy:
		var item_code:int = randi() % item_pool.size()
		var item_data: Dictionary = item_pool[item_code]

		var texture: Texture2D = item_data.get("texture")
		var scene: PackedScene = item_data.get("scene")
		var item_size: Vector2 = item_data.get("size", Vector2.ZERO)

		if item_size == Vector2.ZERO and texture != null:
			item_size = Vector2(2,2)
		
		var belonging := Belonging.new(area, item_size, item_code, texture, scene, created)
		
		if grid.can_place(belonging):
			grid.place(belonging)
			placed.push_front(belonging)
			created += 1
		
		attempts += 1
	
	return placed

	
