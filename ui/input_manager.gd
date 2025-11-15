extends Node
class_name Input_Manager
signal interact_pressed
signal pause_pressed
signal menu_pressed

func _input(event: InputEvent) -> void:
    if event.is_action_pressed("interact"):
        interact_pressed.emit()

    if event.is_action_pressed("pause"):
        pause_pressed.emit()
        
    if event.is_action_pressed("menu"):
        menu_pressed.emit()

