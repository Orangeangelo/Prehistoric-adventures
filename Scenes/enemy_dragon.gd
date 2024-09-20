extends Area2D
@export var flip_time = 1
var direction = 1
# Called when the node enters the scene tree for the first time.
func _ready():
	$Timer.wait_time = flip_time


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float):
	translate(Vector2.RIGHT * direction)
	$AnimatedSprite2D.flip_h = direction < 0




func _on_timer_timeout():
	direction *= -1 
	


func _on_body_entered(body):
	if body.name == "Player":
		get_tree().reload_current_scene()
