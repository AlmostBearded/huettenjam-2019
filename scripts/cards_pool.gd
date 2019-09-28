extends Node2D

var all_pools = {}

var index_offset = 6
var n_c_stats = 4
var n_d_stats = 3
var n_dep = 3
var n_all_stats =  (n_c_stats + n_d_stats * n_dep) * 2

var pos_indexes = [0,1,2,3,8,9,10,14,15,16,20,21,22]
var neg_indexes = [4,5,6,7,11,12,13,17,18,19,23,24,25]

func load_csv():
	var file = File.new()
	file.open("res://data/story_data.csv", file.READ)
	var header = file.get_csv_line ()
	var stats = []
	for i in range(index_offset, index_offset+n_all_stats):
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
	
	for stat in pos_indexes:
		var name = stats[stat].replace("pos_","")
		pos_e[name] = line[index_offset+stat]
		
	for stat in neg_indexes:
		var name = stats[stat].replace("neg_","")
		neg_e[name] = line[index_offset+stat]
	
	
	var pos_s = {}
	var succ = line[index_offset + 26]
	if(succ.length() > 2):
		succ = succ.substr(1,succ.length()-2)
		for s in succ.rsplit(','):
			var item = s.rsplit(':')
			pos_s[item[0]] = item[1]
	
	var neg_s = {}
	succ = line[index_offset + 27]
	if(succ.length() > 2):
		succ = succ.substr(1,succ.length()-2)
		for s in succ.rsplit(','):
			var item = s.rsplit(':')
			neg_s[item[0]] = item[1]
	
	
	return load("res://scripts/card.gd").new(id,gen,dep,task,acc,rej,pos_e, neg_e, pos_s, neg_s) 
	

