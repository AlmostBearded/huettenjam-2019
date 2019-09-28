extends Node2D

func _ready():
	GlobalPools.load_csv()

func _input(event):
    if event is InputEventKey and event.pressed:
    	get_tree().change_scene("res://SplitscreenFusion.tscn")