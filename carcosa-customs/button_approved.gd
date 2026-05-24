extends Button

@onready var luggage := $"../../Luggage"
@onready var anim := $"../../Luggage/AnimationPlayer"

func _ready() -> void:
	pressed.connect(_button_pressed)

func _button_pressed() -> void:
	anim.play("luggage_disappear")

	await anim.animation_finished

	luggage.pickTexture()

	anim.play("luggage_appear")
