extends Node2D

func _ready() -> void:
	pass

func set_luggage_content_type(luggage_code: int):
	print("2. luggage_screen recibió código:", luggage_code)
	# 0: black, 1: blue, 2: brown, 3: green, 4: red
	match luggage_code:
		#0:
			#$Black/BlackInsideSprite.visible = !$Black/BlackInsideSprite.visible
		1:
			$Blue/BlueInsideSprite.visible = !$Blue/BlueInsideSprite.visible
		#2:
			#$Brown/BrownInsideSprite.visible = !$Brown/BrownInsideSprite.visible
		#3:
			#$Green/GreenInsideSprite.visible = !$Green/GreenInsideSprite.visible
		#4:
			#$Red/RedInsideSprite.visible = !$Red/RedInsideSprite.visible
		_:
			print("código de valija no soportado todavía:", luggage_code)

	$SpawnContainer.set_luggage_type(luggage_code)

func clear_lugage_inside_window() -> void:
	print("clear llamado")
	#$Black/BlackInsideSprite.visible = false
	$Blue/BlueInsideSprite.visible = false
	#$Brown/BrownInsideSprite.visible = false
	#$Green/GreenInsideSprite.visible = false
	#$Red/RedInsideSprite.visible = false
	$LuggageGenerator.clear()

func _process(delta: float) -> void:
	pass
