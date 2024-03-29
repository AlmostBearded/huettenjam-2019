extends Panel

export var id = 1
export var department = 'a'

onready var text = $ViewportContainer/QuestionPanel/Label

enum {LEFT, NEUTRAL, RIGHT}
var choice = NEUTRAL

var pool
var curr_card = null
var custom_stats = []

var the_end = false

var is_level_loaded = false

func _ready():
	is_level_loaded = true
	pool = GlobalPools.all_pools[department]
	var first_card = pool.dict.keys()[0]
	curr_card = pool.dict[first_card]
	
	var stats = curr_card.positive_effects.keys()
	#TODO: change with index proper custom impacts
	for i in range(0,3):
		custom_stats.append(stats[i].rsplit('_')[1])
	
	$StatusPanel/Status/Label.text = custom_stats[0]
	$StatusPanel/Status2/Label.text = custom_stats[1]
	$StatusPanel/Status3/Label.text = custom_stats[2]
	
	text.text = str(curr_card.id) + ". " + curr_card.task

func get_input():
	if !is_level_loaded:
		return
	if Input.is_action_just_pressed("accept_p%s" %id):
		if choice == NEUTRAL:
			show_right_influences(curr_card)
			text.text = 'Right option chosen'
			choice = RIGHT
		elif choice == RIGHT:
			set_right_influences(curr_card)
			go_ahead(true)
			choice = NEUTRAL
			reset_influences()
		else:
			text.text = str(curr_card.id) + ". " + curr_card.task
			choice = NEUTRAL	
			reset_influences()
	if Input.is_action_just_pressed("reject_p%s" %id):
		if choice == NEUTRAL:
			show_left_influences(curr_card)
			text.text = 'Left option chosen'
			choice = LEFT
		elif choice == LEFT:
			set_left_influences(curr_card)
			go_ahead(false)
			choice = NEUTRAL
			reset_influences()
		else:
			text.text = str(curr_card.id) + ". " + curr_card.task
			choice = NEUTRAL
			reset_influences()
			
func _process(_delta):
	get_input()
	
func show_left_influences(option):
	var name = 'pos_%s'%$StatusPanel/Status/Label.text
	$StatusPanel/Status.show_influence(int(curr_card.positive_effects[name]))
	name = 'pos_%s'%$StatusPanel/Status2/Label.text
	$StatusPanel/Status2.show_influence(int(curr_card.positive_effects[name]))
	name = 'pos_%s'%$StatusPanel/Status3/Label.text
	$StatusPanel/Status3.show_influence(int(curr_card.positive_effects[name]))

func show_right_influences(option):
	var name = 'neg_%s'%$StatusPanel/Status/Label.text
	$StatusPanel/Status.show_influence(-int(curr_card.negative_effects[name]))
	name = 'neg_%s'%$StatusPanel/Status2/Label.text
	$StatusPanel/Status2.show_influence(-int(curr_card.negative_effects[name]))
	name = 'neg_%s'%$StatusPanel/Status3/Label.text
	$StatusPanel/Status3.show_influence(-int(curr_card.negative_effects[name]))
	
func set_left_influences(option):
	var name = 'pos_%s'%$StatusPanel/Status/Label.text
	$StatusPanel/Status.set_influence(int(curr_card.positive_effects[name]))
	name = 'pos_%s'%$StatusPanel/Status2/Label.text
	$StatusPanel/Status2.set_influence(int(curr_card.positive_effects[name]))
	name = 'pos_%s'%$StatusPanel/Status3/Label.text
	$StatusPanel/Status3.set_influence(int(curr_card.positive_effects[name]))

func set_right_influences(option):
	var name = 'neg_%s'%$StatusPanel/Status/Label.text
	$StatusPanel/Status.set_influence(-int(curr_card.negative_effects[name]))
	name = 'neg_%s'%$StatusPanel/Status2/Label.text
	$StatusPanel/Status2.set_influence(-int(curr_card.negative_effects[name]))
	name = 'neg_%s'%$StatusPanel/Status3/Label.text
	$StatusPanel/Status3.set_influence(-int(curr_card.negative_effects[name]))
	
func reset_influences():
	$StatusPanel/Status.reset_influence()
	$StatusPanel/Status2.reset_influence()
	$StatusPanel/Status3.reset_influence()

func go_ahead(answer):
	var succ_id = pool.select_succ(curr_card, true)
	var new_card = pool.pull(succ_id)
	if(new_card == null):
			#EMPTY
		the_end = true
	if(curr_card.is_general()):
		pool.insert(curr_card)
	curr_card = new_card
	text.text = str(curr_card.id) + ". " + curr_card.task