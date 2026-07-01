extends Node2D
@onready var luggage_generator:=  $"../Canvas/Screens/Luggage/LuggageGenerator"
@onready var notepad:= $"../Canvas/Screens/Docs/notepad_contain"
 
var score : int
var selected_tool : int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#TDOD : esto va a recibir niveles
	$No_Interactives/Timer_canva/Timer.timeout.connect(_on_timer_timeout)
	luggage_generator._generete_forbiddens(1)
	notepad.update_forbidden_list(luggage_generator)
	score = 5
	pass # Replace with function body.

func _update_score(choice : String  = "RECHAZAR") -> void:
	print('Accion: ',choice)
	if luggage_generator._has_forbidden() and choice == "RECHAZAR":
		score = score+1
	elif !luggage_generator._has_forbidden() and choice == "RECHAZAR":
		score = score-1
	elif !luggage_generator._has_forbidden() and choice == "ACEPTAR":
		score = score+1
	elif luggage_generator._has_forbidden() and choice == "ACEPTAR":
		score = score-2
	print('SCORE: ',score)
	if score<0: get_tree().quit()
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
	
func set_cursor_type(tool_code: int) -> void:
	selected_tool = tool_code


func _on_timer_timeout() -> void:
	get_tree().quit()
	pass
	
func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton \
	and event.button_index == MOUSE_BUTTON_RIGHT \
	and event.pressed:
		print('AAAAAA')
		set_cursor_type(-1)
		Input.set_custom_mouse_cursor(null, Input.CURSOR_ARROW)
