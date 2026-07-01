extends Area2D

@onready var start = $SwipeStart
@onready var finish = $SwipeEnd
@onready var card = $"../../Wallet/Card"
@onready var result_label = $"../../LabelResult"
var swiping := false
var finished := false
var start_time := 0
var last_x := 0.0
var moving_right := false

func _ready():
	last_x = card.global_position.x

func _process(_delta):
	moving_right = card.global_position.x > last_x

	# Solo iniciar si se mueve hacia la derecha
	if !swiping \
	and card.is_active() \
	and moving_right \
	and card.global_position.x >= start.global_position.x \
	and card.global_position.x <= finish.global_position.x:
		swiping = true
		start_time = Time.get_ticks_msec()
		
	# Solo terminar si sigue moviéndose hacia la derecha
	if swiping \
	and card.is_active() \
	and moving_right \
	and card.global_position.x >= finish.global_position.x:

		var elapsed = Time.get_ticks_msec() - start_time
		trigger_result(elapsed)
		reset_swipe()

	last_x = card.global_position.x
	
func reset_swipe():
	swiping = false
	start_time = 0


func trigger_result(elapsed_time: int) -> void:
	if elapsed_time > 250 and elapsed_time < 350:
		$"../../AnimationPlayer".play("green_flash")

		if card.is_forbidden():
			result_label.text = "Tarjeta falsificada"
		else:
			result_label.text = "Tarjeta original"

	else:
		$"../../AnimationPlayer".play("red_flash")
		result_label.text = "Lectura fallida"
