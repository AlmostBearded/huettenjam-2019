class_name Card

var id
var general
var department
var task
var accept_opt
var reject_opt

var positive_effects
var negative_effects

var positive_succ
var negative_succ 

func _init(i, gen, d, t, acc, rej, pos_e, neg_e, pos_s, neg_s):
	id = i
	general = gen
	department = d
	task = t
	accept_opt = acc
	reject_opt = rej
	positive_effects = pos_e
	negative_effects = neg_e
	positive_succ = pos_s
	negative_succ = neg_s
	
func answer(accepted):
	if(accepted):
		return positive_effects
	else:
		return negative_effects
	
func get_successors(accepted):
	if(accepted):
		return positive_succ
	else:
		return negative_succ

func is_general():
	return general