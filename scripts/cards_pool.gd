extends Node2D

var all_pools = {}

var index_offset = 6
var n_c_stats = 4
var n_d_stats = 3
var n_dep = 3
var n_stats =  n_c_stats + (n_d_stats * n_dep)


func load_csv():
	var file = File.new()
	file.open("res://data/cards_pool.csv", file.READ)
	file.get_csv_line ()
	var header = file.get_csv_line ()
	var stats = []
	for i in range(index_offset, index_offset+2*n_stats):
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
	
	
func build_card(line, stats):
	var id = line[0]
	var dep = line[1]
	var task = line[2]
	var gen = line[3]
	var acc = line[4]
	var rej = line[5]
	
	#index 6-18
	var pos_e = {}
	#index 19-31
	var neg_e = {}
	
	for stat in range(0,n_stats):
		pos_e[stats[stat]] = line[index_offset+stat]
		
	for stat in range(n_stats, 2*n_stats):
		neg_e[stats[stat]] = line[index_offset+stat]
	
	#index 32
	var pos_s = {}
	var succ = line[index_offset+2*n_stats]
	if(succ.length() > 2):
		succ = succ.substr(1,succ.length()-2)
		for s in succ.rsplit(','):
			var item = s.rsplit(':')
			pos_s[item[0]] = item[1]
	
	#index 33
	var neg_s = {}
	if(succ.length() > 2):
		succ = line[index_offset+2*n_stats + 1]
		succ = succ.substr(1,succ.length()-2)
		for s in succ.rsplit(','):
			var item = s.rsplit(':')
			neg_s[item[0]] = item[1]
	
	
	return load("res://scripts/card.gd").new(id,gen,dep,task,acc,rej,pos_e, neg_e, pos_s, neg_s) 
	

