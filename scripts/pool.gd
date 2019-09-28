class_name Pool

var dict 
var size

func _init():
	dict = {}
	size = 0
	
func insert(card):
	if not dict.has(card.id):
		dict[card.id] = card
	size = size + 1

func pull(id):
	if(size < 1):
		return null
	var card = dict[id]
	dict.erase(id)
	size = size - 1
	return card
	
func select_succ(card, answer):
	var succ_list = card.get_successors(answer)
	if(size == 0):
		return -1
	randomize()
	#if no successors get one of the general ones at random
	if succ_list.empty():
		return get_general_card()
	#just one successors
	elif succ_list.size() == 1:
		return succ_list.keys()[0]
	#mor than one successors
	else: 
		#Select the succ that are still in the pool of cards
		var actual_succ_list = {}
		var option_sum = 0
		for key in succ_list.keys():
			if(dict.has(key)):
				option_sum += int(succ_list[key])
				actual_succ_list[key] = succ_list[key]
		#if there are no succecsors take one of the general 
		if(option_sum == 0):
			return get_general_card()
		else:
			var random = randi() % option_sum
			var range_start = 0
			
			for key in succ_list.keys():
				var range_end = int(succ_list[key]) + range_start
				if random >= range_start and random <= range_end:
					return key
				else:
					range_start = range_end
		

func get_general_card():
	var random = randi() % 100
	var possible_succ = []
	for key in dict.keys():
		if dict[key].is_general():
			possible_succ.append(key)
	return possible_succ[randi() % possible_succ.size()]		


