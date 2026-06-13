# luggage_grid.gd
class_name LuggageGrid

extends Node

var width : int
var height : int

var occupied := {}
var occupied_count := 0

func _init(w:int,h:int):
	width = w
	height = h

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func can_place(
	start_x:int,
	start_y:int,
	object_w:int,
	object_h:int
) -> bool:

	if start_x + object_w > width:
		return false

	if start_y + object_h > height:
		return false

	for y in range(start_y,start_y+object_h):
		for x in range(start_x,start_x+object_w):

			if occupied.has(Vector2i(x,y)):
				return false

	return true

func occupy(
	start_x:int,
	start_y:int,
	object_w:int,
	object_h:int
):

	for y in range(start_y,start_y+object_h):
		for x in range(start_x,start_x+object_w):

			occupied[Vector2i(x,y)] = true
			occupied_count += 1

func get_fill_percentage() -> float:

	return float(occupied_count) / float(width * height)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
