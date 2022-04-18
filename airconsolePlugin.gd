tool
extends EditorPlugin

func _enter_tree():
	add_custom_type("Airconsole", "Node", preload("airconsole.gd"), preload("airconsole.png"))

func _exit_tree():
	remove_custom_type("Airconsole")