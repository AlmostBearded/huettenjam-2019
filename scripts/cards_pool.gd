extends Node2D

var all_pools = {}
var n_stats = 3

var curr_card = null
var the_end = false 

# Called when the node enters the scene tree for the first time.
func _ready():
	var file = File.new()
	file.open("res://data/cards_pool.csv", file.READ)
	var header = file.get_csv_line ()
	var stats = []
	for i in range(5, 5 + 2*n_stats):
		var temp = header[i]
		stats.append(header[i])
	while !file.eof_reached():
		var csv = file.get_csv_line()
		#check department
		var department = csv[1]
		var curr_poll 
		if(all_pools.has(department)):
			curr_poll = all_pools[department]
		else:
			curr_poll = load("res://scripts/pool.gd").new() 
			all_pools[department] = curr_poll
		var c = build_card(csv, stats)
		curr_poll.insert(c)
	file.close()
	
#IMPORTANT !! TOY EXAMPLE WITH PLAYER 1 = DEPARTME a
#(should be done per-player)
func _process(delta):
	if(curr_card == null):
		curr_card = draw_card('a',str(1))
	
	var accepted = -1
	if Input.is_action_pressed("accept_p1"):
		accepted = 1
	if Input.is_action_pressed("reject_p1"):
		accepted = 0
	if(accepted > -1):
		var new_card = select_next('a', curr_card, true if accepted == 1 else false)
		if(new_card == null):
			#EMPTY
			the_end = true
		if(curr_card.is_general()):
			add_card('a',curr_card)
		curr_card = new_card
	

func draw_card(department, card_id):
	return all_pools[department].pull(card_id)
	
func add_card(department,card):
	all_pools[department].insert(card)
	
func select_next(department, curr_card, answer):
	var succ_list = curr_card.get_successors(answer)
	var selected_succ = str(all_pools[department].select_succ(succ_list))
	if(int(selected_succ) == -1):
		return null
	return draw_card(department, selected_succ)
	

func build_card(line, stats):
	var id = line[0]
	var dep = line[1]
	var task = line[2]
	var gen = line[3]
	var acc = line[4]
	var rej = line[5]
	
	var pos_e = {}
	var neg_e = {}
	
	for stat in range(0,n_stats):
		pos_e[stat] = line[6+stat]
		
	for stat in range(n_stats, 2*n_stats):
		neg_e[stat] = line[6+stat]
	
	var pos_s = {}
	var succ = line[6+2*n_stats]
	if(succ.length() > 2):
		succ = succ.substr(1,succ.length()-2)
		for s in succ.rsplit(','):
			var item = s.rsplit(':')
			pos_s[item[0]] = item[1]
	
	var neg_s = {}
	if(succ.length() > 2):
		succ = line[6+2*n_stats + 1]
		succ = succ.substr(1,succ.length()-2)
		for s in succ.rsplit(','):
			var item = s.rsplit(':')
			neg_s[item[0]] = item[1]
	
	
	return load("res://scripts/card.gd").new(id,gen,dep,task,acc,rej,pos_e, neg_e, pos_s, neg_s) 
	

