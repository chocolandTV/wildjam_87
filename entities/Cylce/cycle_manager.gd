extends Node

signal cycle_changed(cycle_stored_upgrades : Dictionary)

var current_cycle :int = 0
var current_lifetime : float = PersistentData.PLAYER_BASE_LIFETIME

var cycle_stored_upgrades : Dictionary = {
    "upgrade_lifetime" : 0,
    "upgrade_speed" : 0,
    "upgrade_scan_efficiency" : 0,
    "upgrade_mining_efficiency" : 0
}

############################################# FUNCTIONS #############################################
func _ready() -> void:
    UpgradeManager.upgrade_performed.connect(_on_upgrade_performed)

func _physics_process(delta: float) -> void:
    if current_lifetime > 0:
        current_lifetime -= delta
    else:
        next_cycle()
        # Later small checkbox for new upgrades increase Speciecs Evolution Goal

############################################ PUBLIC METHODS ############################################
func next_cycle() -> void:
    current_cycle += 1
    # Update Current Evolution
    PersistentData.player_progress["current_evolution"] = current_cycle

    print("CycleManager: Advancing to next cycle.Now on cycle %d" % current_cycle)
    var _temp_stored_upgrades : Dictionary = cycle_stored_upgrades.duplicate()
    cycle_changed.emit(_temp_stored_upgrades)
    # give new upgrade to the player
    #increase lifetime upgrade by 1
    #Reset cycle stored upgrades
    cycle_stored_upgrades = {
        "upgrade_lifetime" : 0,
        "upgrade_speed" : 0,
        "upgrade_scan_efficiency" : 0,
        "upgrade_mining_efficiency" : 0
    }
    UpgradeManager.perform_upgrade(PersistentData.SKILL_LIFETIME, 2)
    #Reset lifetime for next cycle
    current_lifetime =  PersistentData.PLAYER_BASE_LIFETIME + PersistentData.player_progress.get(PersistentData.SKILL_LIFETIME, 1)

func upgrade_cycle_stored_data(upgrade_id : String, amount : int) -> void:
    if cycle_stored_upgrades.has(upgrade_id):
        cycle_stored_upgrades[upgrade_id] += amount
        print("CycleManager: Upgraded %s by %d for current cycle." % [upgrade_id, amount])
    else:
        print("CycleManager: Invalid upgrade ID %s" % upgrade_id)

############################################ PRIVATE METHODS ############################################
func _on_upgrade_performed(upgrade_id : String, amount : int) -> void:
    upgrade_cycle_stored_data(upgrade_id, amount)