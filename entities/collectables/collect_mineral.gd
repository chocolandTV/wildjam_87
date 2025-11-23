extends Area2D
## "Minerals"  "Gas"  "Crystals" or "Artifact"
@export var collect_id :String ="Minerals"

@export var particles_scene : PackedScene

var _is_allready_collected : bool = false
var _lifetime : float = 60
func _ready() -> void:
    body_entered.connect(on_body_entered)

func _physics_process(delta: float) -> void:
    _lifetime -= delta
    if _lifetime < 0:
        get_parent().queue_free()

func on_body_entered(_body : Node2D) ->void:
    # if player 
    if _body is Player_Controller and !_is_allready_collected:
        _is_allready_collected = true

        PersistentData.collected_resources.set(collect_id, (PersistentData.collected_resources.get(collect_id,0))+ 1)
        if collect_id == "Artifact":
            CycleManager.get_bonus_life()
            if randf() < 0.1:
                print("10%% chance to get extra DASH SKILL")
                UpgradeManager.perform_upgrade(PersistentData.SKILL_LIFETIME)

        if collect_id == "Crystals":
            if randf() < 0.2:
                print("20%% chance to get extra DASH SKILL")
                UpgradeManager.perform_upgrade(PersistentData.SKILL_DASH)
        if collect_id == "Gas":
            if randf() < 0.2:
                print("20%% chance to get extra Gas Speed SKILL")
                UpgradeManager.perform_upgrade(PersistentData.SKILL_SPEED)
        if collect_id == "Minerals":
            if randf() < 0.2:
                print("20%% chance to get extra Mineral Speed SKILL")
                UpgradeManager.perform_upgrade(PersistentData.SKILL_SPEED)

        #create particle System
        EventManager.on_collectable_done(get_parent().global_position)
        if randf() < 0.1:
            #add mining skill efficiency
            print("Upgrade: Mining Efficiency")
            UpgradeManager.perform_upgrade(PersistentData.SKILL_MINING_EFFICIENCY)
        #kill self
        get_parent().queue_free()
