extends Node2D


const RESOLUTION = Global.RESOLUTION

var tile = preload("res://scenes/Tile.tscn")
var pawn = preload("res://scenes/Pawn.tscn")
var tile_grid = []

func _ready():
	for i in range(-5, 6):
		for j in range(-5, 6):
			var t = tile.instance()
			t.position = Vector2(i, j) * RESOLUTION
			add_child(t)
	
	_invoke_pawn(Vector2(0, -5), "player1")
	_invoke_pawn(Vector2(3, -3), "player1")
	_invoke_pawn(Vector2(0, 5), "player2")

	for piece in get_tree().get_nodes_in_group("player1"):
		piece.usable = true


func _process(delta):
	pass

func _invoke_pawn(position: Vector2, player_group: String):
	var p = pawn.instance()
	p.position = position * RESOLUTION
	p.add_to_group(player_group)
	p.add_to_group("pieces")
	p.connect("player_moved", self, "_on_player_moved")
	p.connect("piece_evolved", self, "_on_piece_evolved")
	add_child(p)



func _on_player_moved():
	for piece in get_tree().get_nodes_in_group("pieces"):
		if piece.usable:
			piece.usable = false
		else:
			piece.usable = true

func _on_piece_evolved(piece):
	var piece_type = piece.get_class()
	
	match piece_type:
		"Pawn":
			piece.queue_free()
			
