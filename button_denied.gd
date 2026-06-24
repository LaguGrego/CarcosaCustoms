extends Button

@onready var luggage := $"../../Luggage"
@onready var anim := $"../../Luggage/AnimationPlayer"
@onready var luggage_window := $"../../../../Canvas/Screens/Luggage"

func _ready() -> void:
	pressed.connect(_button_pressed)

func _button_pressed() -> void:
	if anim.is_playing(): return
	print("button")

	luggage_window.clear_lugage_inside_window()

	anim.play("luggage_disappear")
	await anim.animation_finished
	luggage.pickTexture()
	anim.play("luggage_appear")
