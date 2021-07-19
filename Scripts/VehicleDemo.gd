extends Spatial

var Accelerating = false
var Reversing = false

export var CollisionShapes = []

var IsGrounded = false

onready var RF_6DOF = $RF_6DOF
onready var LF_6DOF = $LF_6DOF
onready var RR_6DOF = $RR_6DOF
onready var LR_6DOF = $LR_6DOF

onready var RF_Wheel = $RF_Wheel
onready var LF_Wheel = $LF_Wheel
onready var RR_Wheel = $RR_Wheel
onready var LR_Wheel = $LF_Wheel

# Engine power (multiplies angular motor TARGET VELOCITY): max speed
# Wheel Force Limit (multiplies angular motor FORCE LIMIT): acceleration

var ENGINE_POWER = 60 # Top Speed of 150 km/h
var WHEEL_FORCE_LIMIT = 10000 # 0-100 km/h in 5.9 seconds (asphalt)
var STEER_FORCE = 100

func _ready():
	
	Steer(0)
	RearSteer(0)
	
	EnableMotor(true)
	
	RF_6DOF.set_param_x(Generic6DOFJoint.PARAM_ANGULAR_MOTOR_FORCE_LIMIT, WHEEL_FORCE_LIMIT)
	RR_6DOF.set_param_x(Generic6DOFJoint.PARAM_ANGULAR_MOTOR_FORCE_LIMIT, WHEEL_FORCE_LIMIT)
	LF_6DOF.set_param_x(Generic6DOFJoint.PARAM_ANGULAR_MOTOR_FORCE_LIMIT, WHEEL_FORCE_LIMIT)
	LR_6DOF.set_param_x(Generic6DOFJoint.PARAM_ANGULAR_MOTOR_FORCE_LIMIT, WHEEL_FORCE_LIMIT)
	
func _physics_process(_delta):

	"""
	
	INPUTS
	
	"""
	
	if Input.is_action_pressed("Handbrake"):
		#print("brake")
		HandBrake(0)
		
	if Input.is_action_pressed("Reverse"):
		Reverse(Input.get_action_strength("Reverse"))
		
	if Input.is_action_just_pressed(("Reverse")):
		Reversing = true
		
	if Input.is_action_just_released("Reverse"):
		Reverse(0)
		Reversing = false

	if Input.is_action_pressed("Accelerate"):
		Accelerate(Input.get_action_strength("Accelerate"))
		Accelerating = true
		
	if Input.is_action_just_released("Accelerate"):
		Accelerate(0)
		Accelerating = false
	
	if Input.is_action_pressed("SteerLeft"):
		Steer(-Input.get_action_strength("SteerLeft"))

	if Input.is_action_pressed("SteerRight"):
		Steer(Input.get_action_strength("SteerRight"))

	if Input.is_action_just_released("SteerLeft"):
		Steer(0)

	if Input.is_action_just_released("SteerRight"):
		Steer(0)
		
	if Input.is_action_pressed("RearSteerRight"):
		RearSteer(-Input.get_action_strength("RearSteerRight"))

	if Input.is_action_pressed("RearSteerLeft"):
		RearSteer(Input.get_action_strength("RearSteerLeft"))
			
	if Input.is_action_just_released("RearSteerRight"):
		RearSteer(0)
		
	if Input.is_action_just_released("RearSteerLeft"):
		RearSteer(0)
		
func EnableMotor(enable):
	
	RF_6DOF.set_flag_x(Generic6DOFJoint.FLAG_ENABLE_MOTOR, enable)
	LF_6DOF.set_flag_x(Generic6DOFJoint.FLAG_ENABLE_MOTOR, enable)
	RR_6DOF.set_flag_x(Generic6DOFJoint.FLAG_ENABLE_MOTOR, enable)
	LR_6DOF.set_flag_x(Generic6DOFJoint.FLAG_ENABLE_MOTOR, enable)
	
func Steer(Amount):
	#print(Amount)
	var angle = 0.523599 # 30 degrees
	
	if Amount < 0.1 and Amount > -0.1:
		#print("no steer")
		
		RF_6DOF.set_param_y(Generic6DOFJoint.PARAM_ANGULAR_LOWER_LIMIT, 0)
		RF_6DOF.set_param_y(Generic6DOFJoint.PARAM_ANGULAR_UPPER_LIMIT, 0)
		
		LF_6DOF.set_param_y(Generic6DOFJoint.PARAM_ANGULAR_LOWER_LIMIT, 0)
		LF_6DOF.set_param_y(Generic6DOFJoint.PARAM_ANGULAR_UPPER_LIMIT, 0)

	else:
		#print("steer")
		
		if Amount > 0:
			RF_6DOF.set_param_y(Generic6DOFJoint.PARAM_ANGULAR_UPPER_LIMIT, angle * Amount)
			LF_6DOF.set_param_y(Generic6DOFJoint.PARAM_ANGULAR_UPPER_LIMIT, angle * Amount)
		else:
			RF_6DOF.set_param_y(Generic6DOFJoint.PARAM_ANGULAR_LOWER_LIMIT, angle * Amount)
			LF_6DOF.set_param_y(Generic6DOFJoint.PARAM_ANGULAR_LOWER_LIMIT, angle * Amount)

		RF_6DOF.set_param_y(Generic6DOFJoint.PARAM_ANGULAR_MOTOR_TARGET_VELOCITY, Amount * STEER_FORCE)
		LF_6DOF.set_param_y(Generic6DOFJoint.PARAM_ANGULAR_MOTOR_TARGET_VELOCITY, Amount * STEER_FORCE)

func RearSteer(Amount):
	
	#print("RearSteer")
	
	if Amount < 0.1 and Amount > -0.1:
		RR_6DOF.set_param_y(Generic6DOFJoint.PARAM_ANGULAR_LOWER_LIMIT, 0)
		RR_6DOF.set_param_y(Generic6DOFJoint.PARAM_ANGULAR_UPPER_LIMIT, 0)
		
		LR_6DOF.set_param_y(Generic6DOFJoint.PARAM_ANGULAR_LOWER_LIMIT, 0)
		LR_6DOF.set_param_y(Generic6DOFJoint.PARAM_ANGULAR_UPPER_LIMIT, 0)
	else:
		RR_6DOF.set_param_y(Generic6DOFJoint.PARAM_ANGULAR_LOWER_LIMIT, -0.523599)
		RR_6DOF.set_param_y(Generic6DOFJoint.PARAM_ANGULAR_UPPER_LIMIT, 0.523599)
		
		LR_6DOF.set_param_y(Generic6DOFJoint.PARAM_ANGULAR_LOWER_LIMIT, -0.523599)
		LR_6DOF.set_param_y(Generic6DOFJoint.PARAM_ANGULAR_UPPER_LIMIT, 0.523599)
		
		RR_6DOF.set_param_y(Generic6DOFJoint.PARAM_ANGULAR_MOTOR_TARGET_VELOCITY, Amount * STEER_FORCE)
		LR_6DOF.set_param_y(Generic6DOFJoint.PARAM_ANGULAR_MOTOR_TARGET_VELOCITY, Amount * STEER_FORCE)
	
func Accelerate(Amount):
	#print(Amount)
	
	if Amount == 0:
		EnableMotor(false)
		
	else:
		EnableMotor(true)
	
		RF_6DOF.set_param_x(Generic6DOFJoint.PARAM_ANGULAR_MOTOR_TARGET_VELOCITY, -Amount * ENGINE_POWER)
		LF_6DOF.set_param_x(Generic6DOFJoint.PARAM_ANGULAR_MOTOR_TARGET_VELOCITY, -Amount * ENGINE_POWER)
		RR_6DOF.set_param_x(Generic6DOFJoint.PARAM_ANGULAR_MOTOR_TARGET_VELOCITY, -Amount * ENGINE_POWER)
		LR_6DOF.set_param_x(Generic6DOFJoint.PARAM_ANGULAR_MOTOR_TARGET_VELOCITY, -Amount * ENGINE_POWER)
	
func Reverse(Amount):
	if Amount == 0:
		EnableMotor(false)
		
	else:
		EnableMotor(true)
		
		RF_6DOF.set_param_x(Generic6DOFJoint.PARAM_ANGULAR_MOTOR_TARGET_VELOCITY, Amount * ENGINE_POWER)
		LF_6DOF.set_param_x(Generic6DOFJoint.PARAM_ANGULAR_MOTOR_TARGET_VELOCITY, Amount * ENGINE_POWER)
		RR_6DOF.set_param_x(Generic6DOFJoint.PARAM_ANGULAR_MOTOR_TARGET_VELOCITY, Amount * ENGINE_POWER)
		LR_6DOF.set_param_x(Generic6DOFJoint.PARAM_ANGULAR_MOTOR_TARGET_VELOCITY, Amount * ENGINE_POWER)	
	
func HandBrake(Amount):
	EnableMotor(true)
	
	RF_6DOF.set_param_x(Generic6DOFJoint.PARAM_ANGULAR_MOTOR_TARGET_VELOCITY, Amount)
	LF_6DOF.set_param_x(Generic6DOFJoint.PARAM_ANGULAR_MOTOR_TARGET_VELOCITY, Amount)
	RR_6DOF.set_param_x(Generic6DOFJoint.PARAM_ANGULAR_MOTOR_TARGET_VELOCITY, Amount)
	LR_6DOF.set_param_x(Generic6DOFJoint.PARAM_ANGULAR_MOTOR_TARGET_VELOCITY, Amount)
