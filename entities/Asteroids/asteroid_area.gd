extends Area2D
class_name Asteroid_Area


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
    if mining_component.max_count >0:
        # check if minerals are there
        if mining_component.total_resources.get("Minerals") > 0:
            mining_component.max_count -= 1
            mining_component.total_resources.set("Minerals", mining_component.total_resources.get("Minerals",0)-1)
            # SIGNAL GET 1 MINERAL
            PersistentData.collected_resources.set("Minerals", (PersistentData.collected_resources.get("Minerals",0))+ 1)

        if mining_component.total_resources.get("Gas") > 0:
            mining_component.max_count -= 1
            mining_component.total_resources.set("Gas", mining_component.total_resources.get("Gas",0)-1)
            # SIGNAL GET 1 MINERAL
            PersistentData.collected_resources.set("Gas", (PersistentData.collected_resources.get("Gas",0))+ 1)

        if mining_component.total_resources.get("Crystals") > 0:
            mining_component.max_count -= 1
            mining_component.total_resources.set("Crystals", mining_component.total_resources.get("Crystals",0)-1)
            # SIGNAL GET 1 MINERAL
            PersistentData.collected_resources.set("Crystals", (PersistentData.collected_resources.get("Crystals",0))+ 1)

        if mining_component.total_resources.get("Artifact") > 0:
            mining_component.max_count -= 1
            mining_component.total_resources.set("Artifact", mining_component.total_resources.get("Artifact",0)-1)
            # SIGNAL GET 1 MINERAL
            PersistentData.collected_resources.set("Artifact", (PersistentData.collected_resources.get("Artifact",0))+ 1)
    _set_scale()
    _check_asteroid_is_dead()

func _set_scale() ->void:
    _asteroid.scale = _start_scale * (float(mining_component.max_count) / _start_count)

func _check_asteroid_is_dead() ->void:
    if mining_component.max_count <= 0:

        #add mining skill efficiency
        UpgradeManager.perform_upgrade(PersistentData.SKILL_MINING_EFFICIENCY)

        ##Shrink animation particle and sound 
        get_parent().queue_free()