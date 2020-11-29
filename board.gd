extends Node2D


const RESOLUTION = 32

var tile = preload("res://scenes/Tile.tscn")
var pawn = preload("res://scenes/pawn.tscn")
var tile_grid = []
func _ready():
	for i in range(-5, 6):
		for j in range(-5, 6):
			var t = tile.instance()
			t.position = Vector2(i, j) * RESOLUTION
			add_child(t)
	var p1 = pawn.instance()
	p1.position = Vector2(0, -5) * RESOLUTION
	add_child(p1)
	var p2 = pawn.instance()
	p2.position = Vector2(0, 5) * RESOLUTION
	add_child(p2)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
