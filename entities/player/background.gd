extends Sprite2D

const IMAGE_SCALE_FACTOR : float = 1.793103448

func _ready() -> void:
    #EventManager.camera_player_entered_planet_zone.connect(_on_camera_zoom_out)
    #EventManager.camera_player_exited_planet_zone.connect(_on_camera_zoom_in)
    #EventManager.camera_player_changed.connect(_on_camera_player_input)
    EventManager.camera_zoom_changed.connect(_on_camera_zoom_changed)

func _on_camera_zoom_out(_radius :float) ->void:
    var _new_scale : float = _radius / IMAGE_SCALE_FACTOR
    scale = Vector2.ONE *_new_scale
    
func _on_camera_zoom_in() ->void:
    scale = Vector2.ONE

func _on_camera_player_input(_current_zoom : Vector2)->void:
    scale = Vector2.ONE / _current_zoom * 1.793103448

func _on_camera_zoom_changed(_vector2_zoom : Vector2) -> void:
    print("got signal camera zoom : ", _vector2_zoom.x)
    scale = Vector2.ONE / _vector2_zoom / IMAGE_SCALE_FACTOR