extends Node2D

#jdfoei
func _ready():
	GlobalPools.load_csv()

func _input(event):
    if Input.is_action_just_pressed("ui_accept"):
    	get_tree().change_scene("res://ControlsScreen.tscn")