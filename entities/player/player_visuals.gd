extends Sprite2D
class_name Player_Visuals

@export var _point_light : PointLight2D

var _parent : CharacterBody2D
var _is_right : bool = true

func _ready() -> void:
    _parent = get_parent()

func _physics_process(_delta: float) -> void:

    if _parent.get_player_facing_right() and !_is_right:
        _is_right = true
        flip_h = _is_right
        _point_light.scale = Vector2(1,1)
    else:
        _is_right = false
        flip_h = _is_right
        _point_light.scale = Vector2(-1,1)

#### LATER ANIMATIONS
