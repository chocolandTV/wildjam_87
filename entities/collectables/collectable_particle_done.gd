extends CPUParticles2D


func _ready() -> void:
    finished.connect(on_particle_one_Shot)

func on_particle_one_Shot() ->void:
    queue_free()