extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AlarmTimer.set_wait_time(30 + randi() % 30)
	$AlarmTimer.start()
	$AlarmAudio.set_volume_linear(9)
	$ColorRect.z_index = 50

	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if $AlarmAudio.is_playing():
		pass
	pass


func _on_timer_timeout() -> void:
	$AlarmAudio.play()
	$AnimationPlayer.play("alarm")
	$AnimatedSprite2D.play("alarm_blink")
	pass # Replace with function body.

func _deactivate_alarm() -> void:
	$AlarmTimer.stop()
	$AlarmTimer._reset_timer()
	pass
