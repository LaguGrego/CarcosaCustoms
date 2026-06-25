extends VBoxContainer

var itemMap: Array[String] = [
	'Cinta Adhesiva','Gallesitas','Zapatillas','Lingote de oro',
	'Navaja Suiza','Libro','Gorra','Harina','Termo','Dispositivo',
	'Gorra de pescador','Alien','Patipipa','Camara','Dron'
]

var tamano_letra: int = 20

func _ready() -> void:
	pass

func update_forbidden_list(luggage_generator: LuggageGenerator) -> void:
	# Limpia labels anteriores antes de agregar los nuevos
	for child in get_children():
		child.queue_free()

	for item_index in luggage_generator.get_forbiddens():
		var label := Label.new()
		label.text = itemMap[item_index]
		label.add_theme_font_size_override("font_size", tamano_letra)
		label.add_theme_color_override("font_color", Color.BLACK)
		add_child(label)

func _process(delta: float) -> void:
	pass
