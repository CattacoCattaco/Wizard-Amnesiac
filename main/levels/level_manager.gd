class_name LevelManager
extends Node

@export var levels: Array[LevelData]
@export var current_level_index: int = 0

@export var goal_label: Label
@export var guess_symbol: GuessSymbol
@export var symbol_button_container: HBoxContainer

var symbol_buttons: Array[SymbolDisplay] = []


func _ready() -> void:
	load_level(current_level_index)
	guess_symbol.symbol_added.connect(_check_guess)


func load_level(index: int) -> void:
	current_level_index = index
	
	var current_level: LevelData = levels[index]
	
	goal_label.text = current_level.goal_name
	guess_symbol.clear_symbols()
	
	for symbol_button in symbol_buttons:
		symbol_button.queue_free()
	
	symbol_buttons = []
	
	for data in current_level.given_symbols:
		var symbol_button := SymbolDisplay.new()
		
		symbol_button.symbol = data
		
		symbol_button.is_button = true
		
		symbol_button.bg_color = Color(1, 1, 1, 0.25)
		symbol_button.hover_color = Color(0.5, 0.5, 0.5, 0.25)
		symbol_button.pressed_color = Color(0, 0, 0, 0.25)
		
		symbol_button.pressed.connect(guess_symbol.add_symbol.bind(data))
		
		symbol_button_container.add_child(symbol_button)
		symbol_buttons.append(symbol_button)


func _check_guess(guess: Array[SymbolData]) -> void:
	var current_level: LevelData = levels[current_level_index]
	
	if len(guess) != len(current_level.goal):
		return
	
	for i in len(guess):
		if not guess[i].matches(current_level.goal[i]):
			return
	
	win()


func win() -> void:
	print("You win!")
	
	if current_level_index < len(levels) - 1:
		load_level(current_level_index + 1)
