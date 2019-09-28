extends Node2D
class_name Department

# general stats

var managers setget set_managers, get_managers
var workers setget set_workers, get_workers
var custom setget set_custom, get_custom

func set_managers(value):
	managers = value

func get_managers():
	return managers

func set_workers(value):
	workers = value

func get_workers():
	return workers

func set_custom(value):
	custom = value

func get_custom():
	return custom


# lifecycle

func _ready():
	managers = 0.5
	workers = 0.5
	custom = 0.5
