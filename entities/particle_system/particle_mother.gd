extends Node2D

@export var collectable_particle_scene : PackedScene

@export var asteroid_destroy_scene :PackedScene

func _ready() -> void:
    EventManager.collectable_done.connect(_spawn_particle_after_collectable)

### SPAWNING A PLONG EFFECT PARTICLE SYSTEM AFTER COLLECTING
func _spawn_particle_after_collectable(_position : Vector2)->void :
    var _spawn = collectable_particle_scene.instantiate()
    add_child(_spawn)
    _spawn.global_position = _position
    _spawn.emitting = true
    