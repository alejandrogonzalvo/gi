extends Sprite
class_name Tile

var occupied:bool = false
var movable:bool = true
var piece

func get_class(): return "Tile"

func _on_player_moving():
	if occupied and not piece.usable:
		self.modulate = Color(1, 0.5, 0.5)
	elif not occupied:
		self.modulate = Color(0.5, 0.5, 1)

func _on_player_not_moving():
	self.modulate = Color(1, 1, 1)

func _on_player_moved(mov_piece):
	if not occupied:
		mov_piece.position = position
		return false
	elif not piece.usable:
		piece.queue_free()
		piece = null
		mov_piece.position = position
		return false
	print("returning error")
	return true

func _on_piece_area_entered(area):
	if area.get_collision_layer() == 2:
		piece = area.get_parent()
		occupied = true

func _on_piece_area_exited(area):
	if area.get_collision_layer() == 2:
		occupied = false
		piece = null


func _on_Area2D_mouse_entered():
	$HitBox.mouse_entered = true


func _on_Area2D_mouse_exited():
	$HitBox.mouse_entered = false
