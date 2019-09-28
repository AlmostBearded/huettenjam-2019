extends Node2D


# stats

var stakeholders setget set_stakeholders, get_stakeholders
var customers setget set_customers, get_customers
var environment setget set_environment, get_environment
var government setget set_government, get_government


# accessors

func set_stakeholders(value):
	stakeholders = value

func get_stakeholders():
	return stakeholders

func set_customers(value):
	customers = value

func get_customers():
	return customers

func set_environment(value):
	environment = value

func get_environment():
	return environment

func set_government(value):
	government = value

func get_government():
	return government


# lifecycle

func _init():
	stakeholders = 0.5
	customers = 0.5
	environment = 0.5
	government = 0.5
	print_debug("company initialized")

#func _process(delta):
#	pass
