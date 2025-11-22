extends Node2D
class_name Mining_Arm
# Mining arm logic will be implemented here
#Export variable
@export var _cursor_color :Color 
# on ready variables
@onready var _area : Area2D = $Arm_Area2D
@onready var _cursor : Sprite2D =$Cursor
#const Variables
const BASE_MINING_TIME : float = 1.0
# Private Variables
var _is_button_pressed: bool = false
var _mining_target : Node2D = null
var _temp_timer : float = 0.0
# Ready Method connect to signals
func _ready() -> void:

	_area.area_entered.connect(_on_area_entered)
	_area.area_exited.connect(_on_area_exited)
	_cursor.modulate = _cursor_color
	_cursor.hide()

# Input Method Hold to mine
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("interact"):
		_on_button_pressed()
	elif event.is_action_released("interact"):
		_on_button_released()

func _physics_process(delta: float) -> void:
	_check_mining(delta)

##################################### AREA DETECTION #####################################
func _on_area_entered(area: Area2D) -> void:
	if area is Asteroid_Area:
		_mining_target = area
		GameUi.setup_asteroid_mining_box(true)
		#_is_button_pressed = true
		#_timer.start()
func _on_area_exited(area: Area2D) -> void:
	if area == _mining_target:
		_mining_target = null
		GameUi.setup_asteroid_mining_box(false)
####################################################################
#start mining when button is pressed and target is in range
func _on_button_pressed() -> void:
	if _mining_target != null:
		_is_button_pressed = true
		_cursor.show()
		_cursor.global_position = (_mining_target.get_parent()as Node2D).global_position
		# process asteroid mining logic here

# stop mining when button is released
func _on_button_released() -> void:
	_is_button_pressed = false
	_cursor.hide()
	# stop mining logic here

func _check_mining(_delta : float) -> void:
	if _is_button_pressed and _mining_target != null:
		_cursor.global_position = (_mining_target.get_parent()as Node2D).global_position
		_temp_timer += _delta
		var _timeout :float = max(0.1,BASE_MINING_TIME - (PersistentData.player_progress.get("upgrade_mining_efficiency")* 0.1))
		if _temp_timer >= _timeout:
			_temp_timer= 0
			_mining_target.get_resource()
