extends Node2D

func _ready():
	pass

func _on_retry_pressed():
	get_tree().change_scene_to_file("res://overworld.tscn")

func _on_quit_pressed():
	get_tree().quit()
