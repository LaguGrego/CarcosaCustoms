class_name Grid

var width: int
var height: int

var cells: Array = []

func _init(w: int, h: int):
	width = w
	height = h

	for y in range(height):
		var row := []

		for x in range(width):
			row.append(false)

		cells.append(row)
