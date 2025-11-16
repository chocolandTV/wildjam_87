extends Node

signal cycle_changed(cycle_stored_upgrades : Dictionary)

var current_cycle :int = 0
var current_lifetime : int = 60

var cycle_stored_upgrades : Dictionary = {
    "upgrade_lifetime" : 0,
    "upgrade_speed" : 0,
    "upgrade_scan_efficiency" : 0,
    "upgrade_mining_efficiency" : 0
}
############################################ PUBLIC METHODS ############################################
func next_cycle() -> void:
    current_cycle += 1
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