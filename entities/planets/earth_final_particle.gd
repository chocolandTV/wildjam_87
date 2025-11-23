extends CPUParticles2D

@export var end_scene : PackedScene

func _ready() -> void:
    EventManager.game_over.connect(_on_game_over)
    finished.connect(_scene_change)

func _on_game_over()->void:
    emitting =true

func _scene_change() ->void:
    get_tree().change_scene_to_packed(end_scene)
    #change_pack_to_file(end_scene)