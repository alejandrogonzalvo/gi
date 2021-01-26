extends Sprite
class_name Tile

var occupied:bool = false
var movable:bool = true
var mouse_entered:bool = false
var piece


func get_class(): return "Tile"

func piece_moving(mov_piece):
	if occupied and not piece.usable:
		modulate = Color(1, 0.5, 0.5)
	elif not occupied:
		modulate = Color(0.5, 0.5, 1)

func piece_not_moving():
	self.modulate = Color(1, 1, 1)

func piece_moved(mov_piece):
	if not occupied:
		mov_piece.position = position
		return false
	elif not piece.usable:
		piece.queue_free()
		piece = mov_piece
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
	mouse_entered = true


func _on_Area2D_mouse_exited():
	mouse_entered = false
