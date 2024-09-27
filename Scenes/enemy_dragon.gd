extends Area2D
@export var flip_time = 1
var direction = 1
#This code sets the wait time.
func _ready():
	$Timer.wait_time = flip_time


# This code makes the enemy continuously go left and right
func _process(delta: float):
	translate(Vector2.RIGHT * direction)
	$AnimatedSprite2D.flip_h = direction < 0



#this inverts the enemies direction variable when the timer runs out, cuasing the enemy to change directions.
func _on_timer_timeout():
	direction *= -1 
	

#This block of code makes the player reset when it collides with the enemy
func _on_body_entered(body):
	if body.name == "Player":
		GameManager.reset_score()
		get_tree().reload_current_scene()
