extends Node
### THIS SCRIPT HANDLES ASTEROIDS SPAWNING AND OBJECT POOLING

@export var asteroid_scene : PackedScene
@export var asteroid_spawning_rate : float = 2.0
@export var min_max_spawning_asteroids : Vector2 = Vector2( 1, 100)
@export var min_max_spawning_size : Vector2 = Vector2(0.1, 1)
@export var timer : Timer

#Private Variables
var _player : Node2D = null
var _mother : Node2D = null
var _objects_spawned : Array[RigidBody2D]

func _ready() -> void:
    #Timer settings
    timer.timeout.connect(on_timer_timeout)
    timer.wait_time = asteroid_spawning_rate

    # get player and mother
    _player = EventManager.player_node
    _mother = EventManager.asteroids_mother
    #initial _object_pool

func _handle_asteroids() ->void :
    #Check if asteroid is unused
        #if rand chance 
            #spawn and set random resource, lifetime
    pass
    


func _spawn_asteroid(_position :Vector2, _size : Vector2, _resource: Dictionary)->void: 
    pass

############### GLOBAL FUNCTION #

## RESET ASTEROID AND GO BACK TO POOL -> KILLCODE
func reset_asteroid(_asteroid :RigidBody2D)->void:
    #hide
    #delete resource
    # position to 0
    pass
func on_timer_timeout() ->void:
    # NEXT SPAWNING CYCLE
    _handle_asteroids()