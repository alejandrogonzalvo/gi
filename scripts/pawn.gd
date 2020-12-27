extends Sprite

const RESOLUTION = Global.RESOLUTION

var usable: bool = false
var mouse_entered: bool = false
var clicked: bool = false
var mouse_on_movement_range = false

signal player_moved

func _process(delta):
	if Input.is_action_just_pressed("click"):
		click()

func click():
	for piece in get_tree().get_nodes_in_group("pieces"):
		if piece != self and piece.clicked == true:
			return
	if usable: 
		var movement_tiles = []
		for area in $MovementBox.get_overlapping_areas():
			if area.get_class() == "TileHitbox": movement_tiles.append(area)

		if mouse_entered and not clicked:
			clicked = true
			for tile in movement_tiles: tile.emit_signal("player_moving")
		elif mouse_entered and clicked:
			clicked = false
			for tile in movement_tiles: tile.emit_signal("player_not_moving")
		elif clicked and mouse_on_movement_range:
			for tile in movement_tiles:
				if tile.mouse_entered:
					var error = tile.get_parent()._on_player_moved(self)
					if not error:
						print("there is no error")
						for tile2 in movement_tiles:
							tile2.emit_signal("player_not_moving")
						clicked = false
						emit_signal("player_moved")
						return

func _on_Hitbox_mouse_entered():
	mouse_entered = true

func _on_Hitbox_mouse_exited():
	mouse_entered = false

func _on_player_entered(area):
	if not usable and area.get_collision_layer() == 2:
		print(area.name)
		print("dead!")
		queue_free()
		area.queue_free()


func _on_MovementBox_mouse_entered():
	mouse_on_movement_range = true


func _on_MovementBox_mouse_exited():
	mouse_on_movement_range = false
