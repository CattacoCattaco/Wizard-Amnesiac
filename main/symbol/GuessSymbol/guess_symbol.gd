@tool
class_name GuessSymbol
extends SymbolDisplay

@export var symbol_buttons: Array[SymbolDisplay]


func _ready() -> void:
	for symbol_button: SymbolDisplay in symbol_buttons:
		symbol_button.pressed.connect(add_symbol.bind(symbol_button.symbol))
	
	super()


func _input(event: InputEvent) -> void:
	if event is InputEventKey:
		if event.pressed:
			if event.keycode == KEY_BACKSPACE:
				remove_symbol()
			elif event.keycode == KEY_R:
				clear_symbols()


func add_symbol(new_symbol: SymbolData) -> void:
	new_symbol = new_symbol.duplicate()
	
	if new_symbol.border_type == SymbolData.BorderType.SQUARE:
		new_symbol.border_type = SymbolData.BorderType.SQUARE_HIDDEN
	
	symbol.child_symbols.append(new_symbol)
	update = true


func remove_symbol() -> void:
	symbol.child_symbols.pop_back()
	update = true


func clear_symbols() -> void:
	symbol.child_symbols = []
	update = true
