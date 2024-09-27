extends Control

#This code allows you to play the game. When you press Play you are brought to the game
func _on_play_pressed():
	get_tree().change_scene_to_file("res://Scenes/world.tscn")


#This code allows you to quit. When you press quit you're exited from the game.
func _on_quit_pressed():
	get_tree().quit()
