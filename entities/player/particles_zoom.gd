extends CPUParticles2D

const BASE_PARTICLEBOX : Vector2 = Vector2( 1000,1000)

func _ready() -> void:
    EventManager.camera_zoom_changed.connect(_on_camera_zoom_changed)


func _on_camera_zoom_changed(_zoom :Vector2) ->void:

    emission_rect_extents = BASE_PARTICLEBOX / _zoom

    #scale_amount_min = 0.1 / _zoom.x
    #scale_amount_max = 0.5 / _zoom.x

    amount = int(555.0 + (10/ _zoom.x))