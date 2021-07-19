extends Camera

export(NodePath) var VehiclePath
onready var Vehicle = get_node(VehiclePath)

var VehicleRigidBody = null

var VehiclePosition

func _ready():
	set_physics_process(true)
	
	VehicleRigidBody = Vehicle.get_node("VehicleRigidBody")
	
func _physics_process(_delta):
	VehiclePosition = VehicleRigidBody.get_global_transform().origin
	VehiclePosition.y += 10
	VehiclePosition.x -= 10
	self.set_translation(VehiclePosition)

