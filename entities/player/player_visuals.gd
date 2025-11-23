extends Sprite2D
class_name Player_Visuals

@export var _point_light : PointLight2D

####lifecycle Textures
@export var _full_life_tex : Texture2D
@export var _half_life_tex : Texture2D
@export var _tenseconds_life_tex: Texture2D
@export var _dying_life_tex : Texture2D

# enum
enum LIFE_STATE {
    FULL,
    HALF,
    BEFORE,
    DEAD
}

#### Private Variables
var _parent : CharacterBody2D
var _is_right : bool = true
var _current_state : LIFE_STATE
var _game_over :bool = false
func _ready() -> void:
    _parent = get_parent()
    EventManager.game_over.connect(_on_game_over)
func _on_game_over()->void:
    _game_over = true
func _physics_process(_delta: float) -> void:
    if _game_over:
        return
    _handle_life()
    if _parent.get_player_facing_right() and _is_right:
        return
    if _parent.get_player_facing_right():
        _is_right = true
        flip_h = !_is_right
        _point_light.scale = Vector2(1,1)
    else:
        _is_right = false
        flip_h = !_is_right
        _point_light.scale = Vector2(-1,1)


func _handle_life() ->void:
    var _current_life :float = CycleManager.get_current_lifetime_in_percent()
    var _new_state : LIFE_STATE

    if _current_life > 0.5:
        _new_state = LIFE_STATE.FULL
    elif _current_life > 0.25:
        _new_state = LIFE_STATE.HALF
    elif _current_life > 0.05:
        _new_state = LIFE_STATE.BEFORE
    else:
        _new_state = LIFE_STATE.DEAD
    # Test new state
    if _new_state != _current_life:
        #set new state
        _current_state = _new_state
        #change Texture
        if _new_state == LIFE_STATE.FULL:

            texture = _full_life_tex
            _point_light.texture =_full_life_tex
        elif _new_state == LIFE_STATE.HALF:

            texture = _half_life_tex
            _point_light.texture =_half_life_tex
        elif _new_state == LIFE_STATE.BEFORE:

            texture = _tenseconds_life_tex
            _point_light.texture =_tenseconds_life_tex
        else:

            texture = _dying_life_tex
            _point_light.texture =_dying_life_tex

#### LATER ANIMATIONS
