extends Sprite
class_name Pawn

const RESOLUTION = Global.RESOLUTION

var usable: bool = false
var mouse_entered: bool = false
var clicked: bool = false
var mouse_on_movement_range = false

signal player_moved
signal piece_evolved(piece)


func get_class() : return "Pawn"

func _process(delta):
	if Input.is_action_just_pressed("left_click"):
		left_click()
	if Input.is_action_just_pressed("right_click"):
		right_click()

func left_click():
	
	for piece in get_tree().get_nodes_in_group("pieces"):
		if piece != self and piece.clicked == true:
			return

	var movement_tiles = get_movement_tiles()
	if usable:
		if mouse_entered and not clicked:
			clicked = true
			for tile in movement_tiles: tile.piece_moving(self)
		elif mouse_entered and clicked:
			clicked = false
			for tile in movement_tiles: tile.piece_not_moving()
		elif clicked and mouse_on_movement_range:
			for tile in movement_tiles:
				if tile.mouse_entered:
					var error = tile.piece_moved(self)
					if not error:
						print("there is no error")
						for tile2 in movement_tiles:
							tile2.piece_not_moving()
						clicked = false
						emit_signal("player_moved")
						return

func right_click():
	var movement_tiles = get_movement_tiles()
	if mouse_entered and clicked:
		clicked = false
		for tile in movement_tiles: tile.piece_not_moving()
		evolve()

func evolve():
	print("I Evolve!")
	
	emit_signal("piece_evolved", self)
	emit_signal("player_moved")

func get_movement_tiles():
	var movement_tiles = []
	for area in $MovementBox.get_overlapping_areas():
		var tile = area.get_parent()
		if tile.get_class() == "Tile": movement_tiles.append(tile)
	return movement_tiles

func _on_Hitbox_mouse_entered():
	mouse_entered = true

func _on_Hitbox_mouse_exited():
	mouse_entered = false

func _on_player_entered(area):
	pass


func _on_MovementBox_mouse_entered():
	mouse_on_movement_range = true


func _on_MovementBox_mouse_exited():
	mouse_on_movement_range = false
