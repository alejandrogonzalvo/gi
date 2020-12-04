extends Sprite


onready var colored:bool = false

func _ready():
	pass # Replace with function body.



func _process(delta):
	pass


func whiten():
	self.modulate = Color(1, 1, 1)
	print('whitened')


func _on_player_moving():
	self.modulate = Color(0, 0, 1)
	print('modulated')
