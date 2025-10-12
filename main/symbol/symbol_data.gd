@tool
class_name SymbolData
extends Resource

enum SymbolType {
	HOPE,
	STABILITY,
	LOVE,
	LOSS,
	ENTROPY,
	CURIOSITY,
	MULTISYMBOL,
}

enum BorderType {
	SQUARE,
	SQUARE_HIDDEN,
	CIRCLE,
}

@export var border_type: BorderType = BorderType.SQUARE
@export var symbol: SymbolType = SymbolType.HOPE
@export var child_symbols: Array[SymbolData] = []


func is_square() -> bool:
	return border_type != BorderType.CIRCLE


func get_width() -> float:
	match symbol:
		SymbolType.MULTISYMBOL:
			var width: float = 0
			
			for child in child_symbols:
				width += child.get_width()
			
			return width
		SymbolType.STABILITY:
			return 2/3.0 if is_square() else 1.0
		SymbolType.CURIOSITY:
			return 1/2.0 if is_square() else 1.0
		_:
			return 1.0
