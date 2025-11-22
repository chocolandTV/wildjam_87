extends Camera2D
class_name Base_Game_Camera

# Const Variables
const SMOOTH_FOLLOW :float = 8.0

# Export Variables
@export var is_auto_zoom_enabled : bool = true
@export var planets : Array[Node2D] = []
@export var player : Node2D = null

# Public Variables
var min_zoom : float = 0.5
var max_zoom : float = 4.0
var zoom_speed: float = 2.0

# Private Variables
var _velocity : Vector2 = Vector2.ZERO


func _process(delta: float) -> void:
    if player != null:
        _smooth_follow(delta)
        _auto_zoom(delta)

## Base function to follow the player smooth
func _smooth_follow(_delta : float) ->void:
    pass

# function to zoom out if planet is nearby otherwhise zoom in
func _auto_zoom(_delta: float) ->void:
    pass