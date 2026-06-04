extends Sprite2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

# Function to move the sprite
func move():
	if position.x<720:
		position.x += 50
		position.y += 50
		rotation += 1
	else :
		position.x =0
		position.y = 0
