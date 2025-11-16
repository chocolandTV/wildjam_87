extends Node

signal upgrade_performed(upgrade_id : String)

#functions to manage upgrades can be added here
func perform_upgrade(upgrade_id : String) -> void:
    # Logic to apply the upgrade can be added here
    print("UpgradeManager: Performing upgrade %s" % [upgrade_id])
    upgrade_performed.emit(upgrade_id)