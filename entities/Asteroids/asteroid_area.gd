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
    # Sammle verfügbare Ressourcen
    var available := []
    if mining_component.total_resources.get("Minerals", 0) > 0:
        available.append({"resource": "Minerals", "scene": collectable_mineral})
    if mining_component.total_resources.get("Gas", 0) > 0:
        available.append({"resource": "Gas", "scene": collectable_gas})
    if mining_component.total_resources.get("Crystals", 0) > 0:
        available.append({"resource": "Crystals", "scene": collectable_crystal})
    if mining_component.total_resources.get("Artifact", 0) > 0:
        available.append({"resource": "Artifact", "scene": collectable_artifact})

    # Wenn etwas verfügbar ist, wähle zufällig eines aus und spawn es
    if available.size() > 0 and mining_component.max_count > 0:
        var rng := RandomNumberGenerator.new()
        rng.randomize()
        var idx := rng.randi_range(0, available.size() - 1)
        var choice :Dictionary= available[idx]
        var res_key = choice["resource"]
        var res_scene = choice["scene"]

        mining_component.max_count -= 1
        #minus
        var cur = mining_component.total_resources.get(res_key, 0)
        mining_component.total_resources.set(res_key, max(0, cur - 1))

        _spawn_collectable(res_scene)
    else:
        print("No resources available to extract or max_count reached.")

    _set_scale()
    _check_asteroid_is_dead()

func _set_scale() ->void:
    _asteroid.scale *= 0.9

func _check_asteroid_is_dead() ->void:
    if mining_component.max_count <= 0:

        ##Shrink animation particle and sound
        EventManager.on_asteroid_done(_asteroid.global_position)
         
        AsteroidManager.reset_asteroid(get_parent())

func _spawn_collectable(_scene : PackedScene)->void:
    # create new variable
    # instantiate
    var _new_instance = _scene.instantiate()
    #set position
    _new_instance.global_position = _asteroid.global_position
    # attach to mother
    EventManager.collectable_mother.add_child(_new_instance)
    #_new_instance.add_force(_get_random_force())
    # give random force

func _get_random_force()->Vector2:
    var _new : Vector2 = Vector2(randf_range(-5, +5), randf_range(-5,+5))
    return _new