class_name LevelData
extends Resource

@export var goal_name: String = ""
@export var goal: Array[SymbolData]
@export var given_symbols: Array[SymbolData]


func _init(p_goal_name: String = "", p_goal: Array[SymbolData] = [],
		p_given_symbols: Array[SymbolData] = []) -> void:
	goal_name = p_goal_name
	goal = p_goal
	given_symbols = p_given_symbols
