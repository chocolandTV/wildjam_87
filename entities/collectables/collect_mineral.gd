extends Area2D
## "Minerals"  "Gas"  "Crystals" or "Artifact"
@export var collect_id :String ="Minerals"

@export var particles_scene : PackedScene

var _is_allready_collected : bool = false

func _ready() -> void:
    body_entered.connect(on_body_entered)

func on_body_entered(_body : Node2D) ->void:
    # if player 
    if _body is Player_Controller and !_is_allready_collected:
        _is_allready_collected = true
        # get resource
        print("Get 1 Mineral")
        PersistentData.collected_resources.set(collect_id, (PersistentData.collected_resources.get(collect_id,0))+ 1)
        #create particle System
        EventManager.on_collectable_done(get_parent().global_position)

        #kill self
        get_parent().queue_free()
