extends Camera2D
class_name Base_Game_Camera

#Const Variable
const BASE_ZOOM_OUT_FACTOR : float = 28.8888

# private variable 
var _min_zoom : float = 0.1
var _max_zoom : float = 1.0
var _zoom_step: float = 0.05
var _current_zoom : Vector2 = Vector2.ZERO


######################## FUNCTIONS
func _ready() -> void:
    EventManager.camera_player_entered_planet_zone.connect(_auto_zoom)
    EventManager.camera_player_exited_planet_zone.connect(_auto_zoom_in)

##############################################################
# function to zoom out if planet is nearby otherwhise zoom in
func _auto_zoom(_planet_radius :float) ->void:
    _planet_zoom_out(_planet_radius)

func _auto_zoom_in() ->void:
    _zoom_in()
##############################################################

func _planet_zoom_out(_radius : float) ->void:
	#lerpy
    _current_zoom = Vector2.ONE * (_radius / BASE_ZOOM_OUT_FACTOR)
    zoom =_current_zoom
    print("camera zoomed out")

func _zoom_out() ->void:
    #calculate current_zoom - step max _min_zoom
    _current_zoom = Vector2.ONE * (max(_min_zoom, _current_zoom.x -_zoom_step))
    # apply to camera
    zoom = _current_zoom

func _zoom_in() ->void: 
    #calculate current_zoom + step max _min_zoom
    _current_zoom = Vector2.ONE * (max(_max_zoom, _current_zoom.x +_zoom_step))
    # apply to camera
    zoom = _current_zoom
