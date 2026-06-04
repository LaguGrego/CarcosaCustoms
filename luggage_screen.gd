extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func set_luggage_content_type(luggage_code: int):
	# 0: black , 1: blue , 2: brown , 3: green , 4: red
	match luggage_code:
		0:
			print(luggage_code)
			$Black/BlackInsideSprite.visible = !$Black/BlackInsideSprite.visible
		1:
			print(luggage_code)
			$Blue/BlueInsideSprite.visible = !$Blue/BlueInsideSprite.visible
		2:
			print(luggage_code)
			$Brown/BrownInsideSprite.visible = !$Brown/BrownInsideSprite.visible
		3:
			print(luggage_code)
			$Green/GreenInsideSprite.visible = !$Green/GreenInsideSprite.visible
		4:
			print(luggage_code)
			$Red/RedInsideSprite.visible = !$Red/RedInsideSprite.visible
		_:
			print('wtf')
			print(luggage_code)
			
func clear_lugage_inside_window() -> void:
	$Black/BlackInsideSprite.visible = 0
	$Blue/BlueInsideSprite.visible = 0
	$Brown/BrownInsideSprite.visible = 0
	$Green/GreenInsideSprite.visible = 0
	$Red/RedInsideSprite.visible = 0
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
