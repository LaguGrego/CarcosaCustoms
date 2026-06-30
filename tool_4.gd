extends Area2D

@export var cursor_texture: Texture2D

func _ready():
	input_pickable = true
	self.input_event.connect(_on_input_event)

func _on_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			var imagen = cursor_texture.get_image()
			$"../../World".set_cursor_type(4)
			# Calculás el nuevo tamaño al 15%
			var nuevo_ancho = int(imagen.get_width() * 0.15)
			var nuevo_alto = int(imagen.get_height() * 0.15)
			imagen.resize(nuevo_ancho, nuevo_alto)
			var nueva_textura = ImageTexture.create_from_image(imagen)
			Input.set_custom_mouse_cursor(nueva_textura)



	
