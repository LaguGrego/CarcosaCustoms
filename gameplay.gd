extends Node2D
@onready var luggage_generator:=  $"../Canvas/Screens/Luggage/LuggageGenerator"
@onready var notepad:= $"../Canvas/Screens/Docs/notepad_contain"
 
var score : int



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#TDOD : esto va a recibir niveles
	luggage_generator._generete_forbiddens(1)
	notepad.update_forbidden_list(luggage_generator)
	score = 0
	pass # Replace with function body.

func _update_score(choice : String  = "RECHAZAR") -> void:
	print('Accion: ',choice)
	if luggage_generator._has_forbidden() and choice == "RECHAZAR":
		score = score+1
	print('SCORE: ',score)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
