extends Node

signal upgrade_performed(upgrade_id : String, amount : int)

#functions to manage upgrades can be added here
func perform_upgrade(upgrade_id : String, amount : int) -> void:
    # Logic to apply the upgrade can be added here
    print("UpgradeManager: Performing upgrade %s to level %d" % [upgrade_id, amount])
    upgrade_performed.emit(upgrade_id, amount)