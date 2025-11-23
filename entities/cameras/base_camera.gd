extends Camera2D
class_name Base_Game_Camera

#Const Variable
const BASE_ZOOM_OUT : float = 0.135

# private variable 
var _min_zoom : float = 0.1
var _max_zoom : float = 1.0
var _zoom_step: float = 0.2
var _current_zoom : Vector2 = Vector2.ONE
var _zoom_duration : float = 0.55

######################## FUNCTIONS
func _ready() -> void:
    EventManager.camera_player_entered_planet_zone.connect(_auto_zoom)
    EventManager.camera_player_exited_planet_zone.connect(_auto_zoom_in)

######## INPUT ZOOM FUNCTION  +  / -  ZOOM_STEP
func _input(event: InputEvent) -> void:
    if event.is_action_pressed("zoom_out"):
        print("Zoom out")
        _current_zoom -= Vector2.ONE * _zoom_step
        if _current_zoom.x <= 0.1:
            _current_zoom = Vector2.ONE *_min_zoom
            EventManager.on_player_changed_zoom(_current_zoom)

        _personal_zoom(_current_zoom)
    if event.is_action_pressed("zoom_in"):
        print("zoom in")
        _current_zoom += Vector2.ONE * _zoom_step
        if _current_zoom.x >= 1:
            _current_zoom = Vector2.ONE *_max_zoom
            EventManager.on_player_changed_zoom(_current_zoom)
            
        _personal_zoom(_current_zoom)

##############################################################
# function to zoom out if planet is nearby otherwhise zoom in
func _auto_zoom(_planet_radius :float) ->void:
    _planet_zoom_out(_planet_radius)

func _auto_zoom_in() ->void:
    _zoom_in()
##############################################################

func _planet_zoom_out(_radius : float) ->void:
    var target = Vector2.ONE * BASE_ZOOM_OUT
    _tween_to_zoom(target)
    _current_zoom = target

func _zoom_out() ->void:
    # increase zoom (zoom out) up to _max_zoom
    var new_x = min(_max_zoom, _current_zoom.x + _zoom_step)
    var target = Vector2.ONE * new_x
    _tween_to_zoom(target)
    #_current_zoom = target

func _zoom_in() ->void: 
    # decrease zoom (zoom in) down to _min_zoom
    #var target = Vector2.ONE
    _tween_to_zoom(_current_zoom)
    #_current_zoom = target

func _tween_to_zoom(target : Vector2) -> void:
    # create a SceneTreeTween and animate the camera's zoom with exponential transition
    var tw = create_tween()
    tw.tween_property(self, "zoom", target, _zoom_duration).set_trans(Tween.TRANS_EXPO).set_ease(Tween.EASE_OUT)

func _personal_zoom(_new_current_zoom) ->void:
    _tween_to_zoom(_new_current_zoom)
    _current_zoom = _new_current_zoom