extends Node2D

signal game_over


# stats
var stakeholders setget set_stakeholders, get_stakeholders
var customers setget set_customers, get_customers
var environment setget set_environment, get_environment
var government setget set_government, get_government

var departments = {}
var DEPARTMENT_CLASS = load("res://scripts/department_instance.gd")

const MAX_VAL = 10

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

func check_status():
	return government > 0 and environment > 0 and customers > 0 and stakeholders > 0

func update_stats(gov, env, cust, stak, dep_stats):
	government = clamp(government + float(gov) / MAX_VAL, 0, 1)
	environment = clamp(environment + float(env) / MAX_VAL, 0, 1)
	customers = clamp(customers + float(cust) / MAX_VAL, 0, 1)
	stakeholders = clamp(stakeholders + float(stak) / MAX_VAL, 0, 1)
	
	for dep_ids in departments.keys():
		departments[dep_ids].update_stats(dep_stats[dep_ids])
	
	print_debug("stakeholders: %f\ncustomers: %f\nenvironment: %f\ngovernment: %f" %
			[stakeholders, customers, environment, government])
	
	if government <= 0 || environment <= 0 || customers <= 0 || stakeholders <= 0:
		emit_signal("game_over")
	
	return check_status()

func get_stats_dict():
	var dict = {'government':government,'environment':environment,
				'customers':customers, 'stakeholders':stakeholders}
	for dep_ids in departments.keys():
		dict['manager_%s'%departments[dep_ids].department] = departments[dep_ids].get_manager()
		dict['workers_%s'%departments[dep_ids].department] = departments[dep_ids].get_workers()
		dict['custom_%s'%departments[dep_ids].department] = departments[dep_ids].get_custom()
	return dict
	
func get_stats_array():
	var list = [government,environment,customers,stakeholders]
	for dep_ids in departments.keys():
		list.insert(departments[dep_ids].get_manager())
		list.insert(departments[dep_ids].get_workers())
		list.insert(departments[dep_ids].get_custom())
	return list
	
	
# lifecycle
func _init():
	stakeholders = 0.5
	customers = 0.5
	environment = 0.5
	government = 0.5

func set_up_game():
	var deps = get_tree().get_nodes_in_group("DepartmentNode")
	for d in deps:
		d.initiate_department()
		departments[str(d.id)] = d
