class_name LevelData
extends Resource

@export var goal_name: String = ""
@export var goal: Array[SymbolData]
@export var given_symbols: Array[SymbolData]
@export var messages: Array[MessageData]


func _init(p_goal_name: String = "", p_goal: Array[SymbolData] = [],
		p_given_symbols: Array[SymbolData] = [], p_messages: Array[MessageData] = []) -> void:
	goal_name = p_goal_name
	goal = p_goal
	given_symbols = p_given_symbols
	messages = p_messages
