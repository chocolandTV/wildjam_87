extends Node
### THIS SCRIPT HANDLES ASTEROIDS SPAWNING AND OBJECT POOLING

@export var asteroid_scene : PackedScene
@export var asteroid_spawning_rate : float = 10.0
@export var min_max_spawning_asteroids : Vector2i = Vector2( 1, 100)
@export var min_max_spawning_size : Vector2 = Vector2(0.1, 1)
@export var timer : Timer

#Private Variables
var _player : Node2D = null
var _mother : Node2D = null
var _objects_spawned : Array[RigidBody2D]

# Connect to EventManager Event mother is setted
func _ready() -> void:
    EventManager.asteroid_mother_setted.connect(_on_mother_is_set)


#### START IF MOTHER IS SET
func _on_mother_is_set() -> void:
    #Timer settings
    timer.timeout.connect(on_timer_timeout)
    timer.wait_time = asteroid_spawning_rate

    # get player and mother
    _player = EventManager.player_node
    _mother = EventManager.asteroids_mother
    #initial _object_pool
    for x in min_max_spawning_asteroids.y:
        var _spawn :RigidBody2D = asteroid_scene.instantiate()
        _mother.add_child(_spawn)
        _spawn.visible = false
        _spawn.global_position = Vector2.ZERO
        #add to object pooling array
        _objects_spawned.append(_spawn)
    timer.start()

func _handle_asteroids() ->void :
    #Check if asteroid is unused
    if _objects_spawned != null:
        for x in _objects_spawned:

            #spawn and set random resource, lifetime
            var _pos :Vector2 = _player.global_position + Vector2( randf_range(-1000,1000),randf_range(-5000,5000))
            var _size: Vector2 = Vector2.ONE * randf_range(min_max_spawning_size.x,min_max_spawning_size.y)
            var _resource : Dictionary =  {
    "Minerals" : randi_range(0,10),
    "Gas" : randi_range(0,10),
    "Crystals" : randi_range(0,10),
    "Artifact" : randi_range(0,10)
    }
            var _lifetime : float = randf_range(10, 100)
            # SPAWNING ASTEROID WITH RANDOM PARAMETERS
            _spawn_asteroid(x, _pos, _size,_resource, _lifetime)

        _objects_spawned.clear()
    else: 
        print("All Asteroids floating around")
        
    
    


func _spawn_asteroid(_asteroid, _position :Vector2, _size : Vector2, _resource: Dictionary, _lifetime : float)->void:
    _asteroid.global_position = _position 
    # Initialize in Astro function
    _asteroid.initialize_asteroid(_size, _resource, _lifetime)
    
    

############### GLOBAL FUNCTION #

## RESET ASTEROID AND GO BACK TO POOL -> KILLCODE
func reset_asteroid(_asteroid :RigidBody2D)->void:
    #hide
    _objects_spawned.append(_asteroid)
    _asteroid.visible = false
    #delete resource
    # position to 0
    pass
func on_timer_timeout() ->void:
    # NEXT SPAWNING CYCLE
    _handle_asteroids()