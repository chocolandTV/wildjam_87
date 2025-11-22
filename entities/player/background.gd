extends Sprite2D

const IMAGE_SCALE_FACTOR : float = 1.793103448

func _ready() -> void:
    EventManager.camera_player_entered_planet_zone.connect(_on_camera_zoom_out)
    EventManager.camera_player_exited_planet_zone.connect(_on_camera_zoom_in)

func _on_camera_zoom_out(_radius :float) ->void:
    var _new_scale : float = _radius / IMAGE_SCALE_FACTOR
    scale = Vector2.ONE *_new_scale
    
func _on_camera_zoom_in() ->void:
    scale = Vector2.ONE