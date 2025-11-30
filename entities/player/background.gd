extends Sprite2D

const IMAGE_SCALE_FACTOR : float = 12.0
const SCALE_TWEEN_DURATION : float = 0.25

func _ready() -> void:
    #EventManager.camera_player_entered_planet_zone.connect(_on_camera_zoom_out)
    #EventManager.camera_player_exited_planet_zone.connect(_on_camera_zoom_in)
    #EventManager.camera_player_changed.connect(_on_camera_player_input)
    EventManager.camera_zoom_changed.connect(_on_camera_zoom_changed)

func _on_camera_zoom_out(_radius :float) ->void:

    scale=Vector2.ONE * IMAGE_SCALE_FACTOR
    
func _on_camera_zoom_in() ->void:
    scale = Vector2.ONE

func _on_camera_player_input(_current_zoom : Vector2)->void:
    scale = _current_zoom / IMAGE_SCALE_FACTOR

func _on_camera_zoom_changed(_vector2_zoom : Vector2) -> void:

    scale= _vector2_zoom / IMAGE_SCALE_FACTOR
