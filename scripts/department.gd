extends Panel
class_name Department

# general stats
const INFLUENCE_ENUM = preload("res://StatusInfluenceEnum.gd")
enum {LEFT, NEUTRAL, RIGHT}
var choice = NEUTRAL

var managers setget set_managers, get_managers
var workers setget set_workers, get_workers
var custom setget set_custom, get_custom

var score setget set_score, get_score

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
	
func set_score(value):
	score = value

func get_score():
	return score

func get_all_stats():
	return [workers,managers,custom]

func simulate_update(deltas):
	return [workers + float(deltas[0]) / Company.MAX_VAL,
			managers + float(deltas[1]) / Company.MAX_VAL, 
			custom + float(deltas[2]) / Company.MAX_VAL]
	
func update_stats(deltas):
	workers = clamp(workers + float(deltas[0]) / Company.MAX_VAL, 0, 1)
	managers = clamp(managers + float(deltas[1]) / Company.MAX_VAL, 0, 1)
	custom = clamp(custom + float(deltas[2]) / Company.MAX_VAL, 0, 1)
	
	if(managers == 0 or workers == 0 or custom == 0):
		score = 0
	else:
		score = (2*workers + 4*managers +3*custom)*100000
	
# lifecycle
func _ready():
	managers = 0.5
	workers = 0.5
	custom = 0.5
	score = 0
