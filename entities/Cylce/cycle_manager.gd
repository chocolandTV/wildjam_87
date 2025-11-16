extends Node

signal cycle_changed(cycle_stored_upgrades : Dictionary)

var current_cycle :int = 0
var current_lifetime : float = 60

var cycle_stored_upgrades : Dictionary = {
    "upgrade_lifetime" : 0,
    "upgrade_speed" : 0,
    "upgrade_scan_efficiency" : 0,
    "upgrade_mining_efficiency" : 0
}
func _physics_process(delta: float) -> void:
    if current_lifetime > 0:
        current_lifetime -= delta
    else:
        next_cycle()
############################################ PUBLIC METHODS ############################################
func next_cycle() -> void:
    current_cycle += 1
    print("CycleManager: Advancing to next cycle.Now on cycle %d" % current_cycle)
    cycle_changed.emit(cycle_stored_upgrades)
    # give new upgrade to the player
    #increase lifetime upgrade by 1
    #Reset cycle stored upgrades
    cycle_stored_upgrades = {
        "upgrade_lifetime" : 0,
        "upgrade_speed" : 0,
        "upgrade_scan_efficiency" : 0,
        "upgrade_mining_efficiency" : 0
    }
    #Reset lifetime for next cycle
    current_lifetime =  60 + PersistentData.player_progress.get("upgrade_lifetime", 1)
