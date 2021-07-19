extends Spatial

onready var Camera01 = $Camera01
onready var Camera02 = $Camera02

var Camera01Current = false

func _ready():
	pass # Replace with function body.

func _process(_delta):
	if Input.is_action_just_pressed("ui_focus_next"):
		Camera01Current = !Camera01Current
		
		if Camera01Current:
			Camera01.current = true
			Camera02.current = false
		else:
			Camera01.current = false
			Camera02.current = true
