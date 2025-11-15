extends CharacterBody2D
class_name Player_Controller

#Constants
const SPEED_BASE : float = 300.0 # Base Movement speed of the player

#Private Variables
var _looks_right : bool = true # Track the direction the player is facing
var _input_vector : Vector2 = Vector2.ZERO # Store the player's input vector
var _can_move : bool = true # Track if the player can move

# functions
func _ready() -> void:
    pass

func _physics_process(_delta: float) -> void:
    if _can_move:
        _process_input()
        _move_player(_delta)
    move_and_slide()

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

