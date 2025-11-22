extends Area2D
class_name Asteroid_Area

## store scenes to instantiate
@export var collectable_mineral : PackedScene
@export var collectable_gas : PackedScene
@export var collectable_crystal : PackedScene
@export var collectable_artifact : PackedScene

## get asteroid big resource
@export var mining_component : Mining_Resources_Component
var _start_scale : Vector2 =Vector2.ZERO
var _asteroid : Node2D
var _start_count : int

func _ready() -> void:
    _asteroid = get_parent()
    _start_scale = _asteroid.scale
    _start_count = mining_component.max_count

func get_resource() ->void :
    print("Start getting resource")
    UpgradeManager.perform_upgrade(PersistentData.SKILL_MINING_EFFICIENCY)
    ### NEW DROP UNIT
    if mining_component.max_count >0:
        # check if minerals are there
        if mining_component.total_resources.get("Minerals") > 0:
            mining_component.max_count -= 1
            mining_component.total_resources.set("Minerals", mining_component.total_resources.get("Minerals",0)-1)
            # SIGNAL GET 1 MINERAL
            _spawn_collectable(collectable_mineral)

        if mining_component.total_resources.get("Gas") > 0:
            mining_component.max_count -= 1
            mining_component.total_resources.set("Gas", mining_component.total_resources.get("Gas",0)-1)
            # SIGNAL GET 1 MINERAL
            _spawn_collectable(collectable_gas)

        if mining_component.total_resources.get("Crystals") > 0:
            mining_component.max_count -= 1
            mining_component.total_resources.set("Crystals", mining_component.total_resources.get("Crystals",0)-1)
            # SIGNAL GET 1 MINERAL
            _spawn_collectable(collectable_crystal)

        if mining_component.total_resources.get("Artifact") > 0:
            mining_component.max_count -= 1
            mining_component.total_resources.set("Artifact", mining_component.total_resources.get("Artifact",0)-1)
            # SIGNAL GET 1 MINERAL
            _spawn_collectable(collectable_artifact)

    _set_scale()
    _check_asteroid_is_dead()

func _set_scale() ->void:
    _asteroid.scale = _start_scale * (float(mining_component.max_count) / _start_count)

func _check_asteroid_is_dead() ->void:
    if mining_component.max_count <= 0:

        #add mining skill efficiency
        UpgradeManager.perform_upgrade(PersistentData.SKILL_MINING_EFFICIENCY)

        ##Shrink animation particle and sound 
        AsteroidManager.reset_asteroid(get_parent())

func _spawn_collectable(_scene : PackedScene)->void:
    # create new variable
    # instantiate
    var _new_instance = _scene.instantiate()
    #set position
    _new_instance.global_position = _asteroid.global_position
    # attach to mother
    EventManager.collectable_mother.add_child(_new_instance)
    _new_instance.add_force(_get_random_force())
    # give random force

func _get_random_force()->Vector2:
    var _new : Vector2 = Vector2(randf_range(-5, +5), randf_range(-5,+5))
    return _new