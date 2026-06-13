# item_definition.gd
class_name ItemDefinition
extends Resource

@export var item_name : String
@export var scene : PackedScene

# tamaño lógico en celdas
@export var width_cells : int = 1
@export var height_cells : int = 1

# opcional para spawn aleatorio
@export var weight : float = 1.0
