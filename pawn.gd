extends Sprite


var entered
var clicked
var movement_tiles

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


func _process(delta):
	if entered:
		if Input.is_action_just_pressed("click"):
			if clicked:
				clicked = false
				print('unclicked')
			else:
				clicked = true
				movement_tiles = $Hitbox.get_overlapping_areas()
				for tile in movement_tiles:
					tile.emit_signal("player_moving")

	if clicked and not entered:
		if Input.is_action_just_released("click"):
			self.position = get_global_mouse_position()
			clicked = false
			print('unclicked')

func _on_Hitbox_mouse_entered():
	entered = true
	print('entered')


func _on_Hitbox_mouse_exited():
	entered = false
	print('exited')
