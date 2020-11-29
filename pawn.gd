extends Sprite


var entered
var clicked

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _process(delta):
	if entered:
		if Input.is_action_just_pressed("click"):
			if clicked:
				clicked = false
			else:
				clicked = true
	
	if clicked and not entered:
		if Input.is_action_just_pressed("click"):
			self.position = get_global_mouse_position()

func _on_Area2D_mouse_entered():
	entered = true


func _on_Area2D_mouse_exited():
	entered = false
