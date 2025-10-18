@tool
class_name SymbolDisplay
extends Control

signal pressed()

enum State {
	NORMAL,
	HOVERED,
	PRESSED,
}

@export var symbol_height: int = 100:
	set(value):
		symbol_height = value
		queue_redraw()

@export var symbol: SymbolData:
	set(value):
		symbol = value
		queue_redraw()

@export var update: bool = false:
	set(value):
		update = false
		queue_redraw()

@export var bg_color: Color:
	set(value):
		bg_color = value
		queue_redraw()

@export var is_button: bool

@export var hover_color: Color
@export var pressed_color: Color

var symbol_lines: Line2D

var child_symbols: Array[SymbolDisplay]

var state: State = State.NORMAL

func _ready() -> void:
	symbol_lines = Line2D.new()
	add_child(symbol_lines)
	
	symbol_lines.default_color = Color.BLACK
	symbol_lines.width = 5
	
	symbol_lines.begin_cap_mode = Line2D.LINE_CAP_ROUND
	symbol_lines.end_cap_mode = Line2D.LINE_CAP_ROUND
	symbol_lines.joint_mode = Line2D.LINE_JOINT_ROUND


func _draw() -> void:
	if not symbol:
		return
	
	for symbol_display in child_symbols:
		symbol_display.queue_free()
	
	child_symbols = []
	
	draw_symbol()
	
	match symbol.border_type:
		SymbolData.BorderType.SQUARE:
			draw_square()
		SymbolData.BorderType.CIRCLE:
			var half_height: float = symbol_height / 2.0
			draw_circle(Vector2(half_height, half_height), half_height, get_bg_color())
			draw_circle(Vector2(half_height, half_height), half_height, Color.BLACK, false, 5)


func draw_square() -> void:
	var bounds := get_symbol_rect()
	
	draw_rect(bounds, get_bg_color())
	
	var corners: PackedVector2Array
	
	corners = PackedVector2Array([
		Vector2(0, 0),
		Vector2(0, symbol_height),
		Vector2(symbol_height * symbol.get_width(), symbol_height),
		Vector2(symbol_height * symbol.get_width(), 0),
		Vector2(0, 0),
	])
	
	draw_polyline(corners, Color.BLACK, 5)


func get_symbol_rect() -> Rect2:
	return Rect2(Vector2(0, 0), Vector2(symbol_height * symbol.get_width(), symbol_height))


func get_bg_color() -> Color:
	match state:
		State.NORMAL:
			return bg_color
		State.HOVERED:
			return hover_color
		State.PRESSED:
			return pressed_color
	
	return bg_color


func draw_symbol() -> void:
	match symbol.symbol:
		SymbolData.SymbolType.HOPE:
			draw_hope()
		SymbolData.SymbolType.STABILITY:
			draw_stability()
		SymbolData.SymbolType.LOVE:
			draw_love()
		SymbolData.SymbolType.LOSS:
			draw_loss()
		SymbolData.SymbolType.ENTROPY:
			draw_entropy()
		SymbolData.SymbolType.CURIOSITY:
			draw_curiosity()
		SymbolData.SymbolType.MULTISYMBOL:
			draw_multisymbol()


func draw_hope() -> void:
	var vertices: PackedVector2Array
	if symbol.is_square():
		vertices = PackedVector2Array([
			Vector2(-symbol_height / 2.0, symbol_height / 2.0),
			Vector2(0, 0),
			Vector2(symbol_height / 2.0, symbol_height / 2.0),
			Vector2(symbol_height / 2.0 * 0.6, -symbol_height / 2.0 * 0.6),
			Vector2(symbol_height / 2.0 * 0.2, -symbol_height / 2.0 * 0.2),
		])
	else:
		vertices = PackedVector2Array([
			Vector2(-symbol_height / 2.0 * cos(PI / 4), symbol_height / 2.0 * sin(PI / 4)),
			Vector2(0, 0),
			Vector2(symbol_height / 2.0 * cos(PI / 4), symbol_height / 2.0 * sin(PI / 4)),
			Vector2(symbol_height / 2.0 * cos(PI / 4), -symbol_height / 2.0 * sin(PI / 4)),
			Vector2(symbol_height / 2.0 * 0.3, -symbol_height / 2.0 * 0.3),
		])
	
	for i in len(vertices):
		vertices[i] = vertices[i] + Vector2(symbol_height / 2.0, symbol_height / 2.0)
	
	symbol_lines.points = vertices


func draw_stability() -> void:
	var vertices: PackedVector2Array
	if symbol.is_square():
		vertices = PackedVector2Array([
			Vector2(0, 0),
			Vector2(symbol_height * 2 / 3.0, symbol_height * 2 / 3.0),
			Vector2(symbol_height / 2.0, symbol_height / 2.0),
			Vector2(symbol_height / 4.0, symbol_height * 3 / 4.0),
			Vector2(symbol_height / 2.0, symbol_height),
			Vector2(0, symbol_height / 2.0),
			Vector2(symbol_height / 4.0, symbol_height / 4.0),
		])
	else:
		vertices = PackedVector2Array([
			Vector2(symbol_height / 2.0 * (1 + sqrt(7)) / 4.0, -symbol_height / 2.0 * (-(1 + sqrt(7)) / 4.0 + 0.5)),
			Vector2(symbol_height / 2.0 * (1 - sqrt(7)) / 4.0, -symbol_height / 2.0 * (-(1 - sqrt(7)) / 4.0 + 0.5)),
			Vector2(symbol_height / 4.0, 0),
			Vector2(0, symbol_height / 4.0),
			Vector2(symbol_height / 2.0 * -(1 - sqrt(7)) / 4.0, -symbol_height / 2.0 * ((1 - sqrt(7)) / 4.0 - 0.5)),
			Vector2(-symbol_height / 4.0, 0),
			Vector2(0, -symbol_height / 4.0),
		])
		
		for i in len(vertices):
			vertices[i] = vertices[i] + Vector2(symbol_height / 2.0, symbol_height / 2.0)
	
	symbol_lines.points = vertices


func draw_love() -> void:
	var vertices: PackedVector2Array
	if symbol.is_square():
		vertices = PackedVector2Array([
			Vector2(-symbol_height / 2.0, -symbol_height / 2.0),
			Vector2(0, -symbol_height / 3.0),
			Vector2(-symbol_height / 3.0, 0),
			Vector2(symbol_height / 12.0, symbol_height / 6.0),
			Vector2(-symbol_height / 4.0, symbol_height / 2.0),
			Vector2(symbol_height / 2.0, -symbol_height / 4.0),
		])
	else:
		vertices = PackedVector2Array([
			Vector2(symbol_height / 2.0 * -cos(atan(-5 / 3.0)), symbol_height / 2.0 * sin(atan(-5 / 3.0))),
			Vector2(symbol_height / 12.0, -symbol_height / 3.0),
			Vector2(-symbol_height / 4.0, 0),
			Vector2(symbol_height / 12.0, symbol_height / 12.0),
			Vector2(symbol_height / 2.0 * (1 - sqrt(17)) / 6, -symbol_height / 2.0 * ((1 - sqrt(17)) / 6 - 1 / 3.0)),
			Vector2(symbol_height / 2.0 * (1 + sqrt(17)) / 6, -symbol_height / 2.0 * ((1 + sqrt(17)) / 6 - 1 / 3.0)),
		])
	
	for i in len(vertices):
		vertices[i] = vertices[i] + Vector2(symbol_height / 2.0, symbol_height / 2.0)
	
	symbol_lines.points = vertices


func draw_loss() -> void:
	var vertices: PackedVector2Array
	if symbol.is_square():
		vertices = PackedVector2Array([
			Vector2(-symbol_height / 2.0, symbol_height / 2.0),
			Vector2(-symbol_height / 6.0, -symbol_height / 6.0),
			Vector2(symbol_height / 4.0, symbol_height / 4.0),
			Vector2(-symbol_height / 6.0, -symbol_height / 6.0),
			Vector2(0, -symbol_height / 2.0),
			Vector2(symbol_height / 4.0, -symbol_height / 4.0),
			Vector2(symbol_height / 2.0, -symbol_height / 2.0),
		])
	else:
		vertices = PackedVector2Array([
			Vector2(symbol_height / 2.0 * (-20 - 8 * sqrt(2)) / (51),
					-symbol_height / 2.0 * (4 * (-20 - 8 * sqrt(2)) / 51 + 5 / 3.0)),
			Vector2(-symbol_height / 6.0, -symbol_height / 6.0),
			Vector2(symbol_height / 6.0, symbol_height / 6.0),
			Vector2(-symbol_height / 6.0, -symbol_height / 6.0),
			Vector2(symbol_height / 2.0 * (-20 + 8 * sqrt(2)) / (51),
					-symbol_height / 2.0 * (4 * (-20 + 8 * sqrt(2)) / 51 + 5 / 3.0)),
			Vector2(symbol_height / 6.0, -symbol_height / 4.0),
			Vector2(symbol_height / 2.0 * (-1 + sqrt(71)) / 12,
					-symbol_height / 2.0 * ((-1 + sqrt(71)) / 12 + 1 / 6.0)),
		])
	
	for i in len(vertices):
		vertices[i] = vertices[i] + Vector2(symbol_height / 2.0, symbol_height / 2.0)
	
	symbol_lines.points = vertices


func draw_entropy() -> void:
	var vertices: PackedVector2Array
	if symbol.is_square():
		vertices = PackedVector2Array([
			Vector2(-symbol_height / 2.0, symbol_height / 2.0),
			Vector2(-symbol_height / 4.0, symbol_height / 4.0),
			Vector2(symbol_height / 4.0, symbol_height / 4.0),
			Vector2(-symbol_height / 4.0, -symbol_height / 4.0),
			Vector2(symbol_height / 4.0, -symbol_height / 4.0),
			Vector2(symbol_height / 2.0, -symbol_height / 2.0),
		])
	else:
		vertices = PackedVector2Array([
			Vector2(-symbol_height / 2.0 * cos(PI / 4), symbol_height / 2.0 * sin(PI / 4)),
			Vector2(-symbol_height / 6.0, symbol_height / 6.0),
			Vector2(symbol_height / 6.0, symbol_height / 6.0),
			Vector2(-symbol_height / 6.0, -symbol_height / 6.0),
			Vector2(symbol_height / 6.0, -symbol_height / 6.0),
			Vector2(symbol_height / 2.0 * cos(PI / 4), -symbol_height / 2.0 * sin(PI / 4)),
		])
	
	for i in len(vertices):
		vertices[i] = vertices[i] + Vector2(symbol_height / 2.0, symbol_height / 2.0)
	
	symbol_lines.points = vertices


func draw_curiosity() -> void:
	var vertices: PackedVector2Array
	
	if symbol.is_square():
		vertices = PackedVector2Array([
			Vector2(symbol_height / 4.0, symbol_height),
			Vector2(symbol_height / 4.0, symbol_height * 3 / 4.0),
			Vector2(symbol_height / 2.0, symbol_height / 2.0),
			Vector2(symbol_height / 4.0, symbol_height / 4.0),
			Vector2(0, symbol_height / 2.0),
			Vector2(symbol_height / 4.0, symbol_height / 4.0),
			Vector2(symbol_height / 4.0, 0),
		])
	else:
		vertices = PackedVector2Array([
			Vector2(0, symbol_height / 2.0),
			Vector2(0, symbol_height / 4.0),
			Vector2(symbol_height / 4.0, 0),
			Vector2(0, -symbol_height / 4.0),
			Vector2(-symbol_height / 4.0, 0),
			Vector2(0, -symbol_height / 4.0),
			Vector2(0, -symbol_height / 2.0),
		])
		for i in len(vertices):
			vertices[i] = vertices[i] + Vector2(symbol_height / 2.0, symbol_height / 2.0)
	
	symbol_lines.points = vertices


func draw_multisymbol() -> void:
	symbol_lines.points = PackedVector2Array([])
	
	var progress: float = 0
	for symbol_data in symbol.child_symbols:
		var child_symbol := SymbolDisplay.new()
		child_symbol.symbol_height = symbol_height
		child_symbol.symbol = symbol_data
		
		add_child(child_symbol)
		child_symbols.append(child_symbol)
		
		child_symbol.position = Vector2(progress, 0)
		progress += symbol_data.get_width() * child_symbol.symbol_height


func _get_minimum_size():
	return Vector2(symbol.get_width() * symbol_height, symbol_height)


func _input(event: InputEvent) -> void:
	if not is_button:
		return
	
	if event is InputEventMouseMotion:
		if contains_point(get_local_mouse_position()):
			if state == State.NORMAL:
				state = State.HOVERED
				queue_redraw()
				print("a")
		elif state == State.HOVERED:
			state = State.NORMAL
			queue_redraw()
			print("b")
	elif event is InputEventMouseButton:
		var left: bool = event.button_index == MOUSE_BUTTON_LEFT
		
		if contains_point(get_local_mouse_position()) and left and event.pressed:
			state = State.PRESSED
			pressed.emit()
			queue_redraw()
		elif state == State.PRESSED and left:
			if contains_point(get_local_mouse_position()):
				state = State.HOVERED
			else:
				state = State.NORMAL
			queue_redraw()


func contains_point(point: Vector2) -> bool:
	if symbol.is_square():
		return get_symbol_rect().has_point(point)
	else:
		var scaled_point: Vector2 = point / (symbol_height as float)
		
		var distance_from_center: float
		distance_from_center = pow(scaled_point.x - 0.5, 2) + pow(scaled_point.y - 0.5, 2)
		
		return distance_from_center <= 1.0
