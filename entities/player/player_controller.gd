extends CharacterBody2D
class_name Player_Controller

#Constants
const SPEED_BASE : float = 300.0 # Base Movement speed of the player
const DASH_SPEED : float = 800.0 # Dash speed of the player
const DASH_COOLDOWN : float = 5.0 # Dash cooldown time in seconds
#Private Variables
var _looks_right : bool = true # Track the direction the player is facing
var _input_vector : Vector2 = Vector2.ZERO # Store the player's input vector
var _can_move : bool = true # Track if the player can move
var _can_dash : bool = true # Track if the player can _dash
var _killometers_traveled : float = 0.0 # Track distance traveled by the player
var _start_position : Vector2 = Vector2.ZERO # Starting position for distance calculation
# on ready varaibles
@onready var _dash_timer : Timer = $Dash_Timer

######################### FUNCTIONS #########################
func _ready() -> void:
	_dash_timer.wait_time = DASH_COOLDOWN - (PersistentData.player_progress.get(PersistentData.SKILL_DASH, 1)* 0.1)
	# minimum _dash cooldown time
	if _dash_timer.wait_time < 0.25:
		_dash_timer.wait_time = 0.25
	## timer timeout reset can_dash and can_move
	_dash_timer.timeout.connect(_on_dash_timer_timeout)
	CycleManager.cycle_changed.connect(_on_cycle_changed)
	_start_position = global_position

## Input Method
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("dash"):
		_dash()

func _physics_process(_delta: float) -> void:
	_start_position = global_position
	if _can_move:
		_process_input()
		_move_player(_delta)
	move_and_slide()
	# Update distance traveled
	_killometers_traveled += global_position.distance_to(_start_position)

################################# PRIVATE METHODS #################################
func _process_input() -> void:
	# Get the input vector from player controls
	_input_vector = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	# Update facing direction based on input
	if _input_vector.x != 0:
		_looks_right = _input_vector.x > 0
func _move_player(_delta: float) -> void:
	# Calculate velocity based on input and speed
	velocity = _input_vector.normalized() * SPEED_BASE

# Public Methods
func get_player_facing_right() -> bool:
	return _looks_right

func get_can_move() -> bool:
	return _can_move

func set_can_move(can_move: bool) -> void:
	_can_move = can_move

func _dash() -> void:
	# _dash sound
	if _can_dash:
		_can_dash = false

		var dash_speed : float = DASH_COOLDOWN + ((PersistentData.player_progress.get(PersistentData.SKILL_DASH, 1)*5))
		var _temp_input = Input.get_vector("move_left", "move_right", "move_up", "move_down")
		velocity = _temp_input.normalized() * dash_speed
		_dash_timer.start()

func _on_dash_timer_timeout() -> void:
	#animation and sound
	_can_dash = true


func _on_cycle_changed(_cycle_stored_upgrades : Dictionary) -> void:
	# Update dash cooldown based on upgrades
	_dash_timer.wait_time = DASH_COOLDOWN - (PersistentData.player_progress.get(PersistentData.SKILL_DASH, 1)* 0.1)
	# minimum _dash cooldown time
	if _dash_timer.wait_time < 0.25:
		_dash_timer.wait_time = 0.25
