extends Department

export var id = 1
export var department = 'a' 

var custom_stats_start_index = 0
var custom_stats = []

var my_status
var my_status_labels

var pool
var curr_card
onready var text = $ViewportContainer/QuestionPanel/Label

var initiated = false
func _ready():
	add_to_group("DepartmentNode")

func _process(delta):
	if initiated :
		get_input()

func initiate_department():
	pool = GlobalPools.all_pools[department]
	var first_card = pool.dict.keys()[0]
	curr_card = pool.dict[first_card]
	
	custom_stats_start_index = GlobalPools.n_c_stats #+ GlobalPools.index_offset 
	custom_stats_start_index +=  (id - 1) * GlobalPools.n_d_stats
	
	my_status = [$StatusPanel/Status, $StatusPanel/Status2, $StatusPanel/Status3]
	my_status_labels = [$StatusPanel/Status/Label, $StatusPanel/Status2/Label, $StatusPanel/Status3/Label]
	
	var stats = curr_card.positive_effects.keys()
	var local_i = 0
	for i in range(custom_stats_start_index, custom_stats_start_index + GlobalPools.n_d_stats):
		my_status_labels[local_i].text = stats[i]
		custom_stats.append(stats[i])
		local_i += 1
		
	text.text = "DILEMMA: " + curr_card.task
	
	choice == NEUTRAL
	update_stats_ui(get_all_stats())
	
	initiated = true

func get_input():		
	if Input.is_action_just_pressed("accept_p%s" %id):
		if choice == NEUTRAL:
			simulate_influences(curr_card, true)
			text.text = curr_card.accept_opt
			choice = RIGHT
		elif choice == RIGHT:
			comupute_influences(curr_card, true)
			go_ahead(true)
			choice = NEUTRAL
			reset_indicators_ui()
		else:
			text.text = str(curr_card.id) + ". " + curr_card.task
			choice = NEUTRAL	
			reset_indicators_ui()
	if Input.is_action_just_pressed("reject_p%s" %id):
		if choice == NEUTRAL:
			simulate_influences(curr_card, false)
			text.text = curr_card.reject_opt
			choice = LEFT
		elif choice == LEFT:
			comupute_influences(curr_card, false)
			go_ahead(false)
			choice = NEUTRAL
			reset_indicators_ui()
		else:
			text.text = str(curr_card.id) + ". " + curr_card.task
			choice = NEUTRAL	
			reset_indicators_ui()
			
			
func simulate_influences(curr_card, answer):
	var effects = curr_card.positive_effects
	if not answer:
		effects = curr_card.negative_effects
		
	var l = []
	for i in range(custom_stats_start_index, custom_stats_start_index + GlobalPools.n_d_stats):
		l.append(effects.values()[i])	
	
	update_indicators_ui(l)
	
		
func comupute_influences(curr_card, answer):
	var effects = curr_card.positive_effects
	if not answer:
		effects = curr_card.negative_effects
	
	var dep_deltas = {}
	for dep in range(1,3+1):
		var start_index = GlobalPools.n_c_stats 
		start_index +=  (dep - 1) * GlobalPools.n_d_stats
		var l = []
		for i in range(start_index, start_index + GlobalPools.n_d_stats):
			l.append(effects.values()[i])
		dep_deltas[str(dep)] = l
	
	var gov = effects['gov'] 
	var env = effects['env']  
	var cust = effects['custom'] 
	var stak = effects['stake'] 
	Company.update_stats(gov, env, cust, stak, dep_deltas)
	update_stats_ui(get_all_stats())
	
func update_stats_ui(values):
	for i in range(0, GlobalPools.n_d_stats):
		my_status[i].set_influence(float(values[i]))

func update_indicators_ui(values):
	for i in range(0, GlobalPools.n_d_stats):
		my_status[i].show_influence(float(values[i]))	
		
func reset_indicators_ui():
	for i in range(0, GlobalPools.n_d_stats):
		my_status[i].reset_influence()
		
func go_ahead(answer):
	var succ_id = pool.select_succ(curr_card, true)
	var new_card = pool.pull(succ_id)
	if(curr_card.is_general()):
		pool.insert(curr_card)
	curr_card = new_card
	text.text = "DILEMMA: " + curr_card.task		
