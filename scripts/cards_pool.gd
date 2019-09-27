extends Node2D

var pool
var n_stats = 3
	
# Called when the node enters the scene tree for the first time.
func _ready():
	pool = load("res://scripts/pool.gd").new() 
	var file = File.new()
	file.open("res://data/cards_pool.csv", file.READ)
	var header = file.get_csv_line ()
	var stats = []
	for i in range(5, 5 + 2*n_stats):
		var temp = header[i]
		stats.append(header[i])
	while !file.eof_reached():
		var csv = file.get_csv_line()
		var c = build_card(csv, stats)
		pool.insert(c)
	file.close()

func draw_card(id):
	return pool.pull(id)
	
func add_card(card):
	pool.insert(card)
	
func select_next(curr_card, answer):
	var succ_list = curr_card.get_successors(answer)
	return draw_card(pool.select_succ(succ_list))

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
	

