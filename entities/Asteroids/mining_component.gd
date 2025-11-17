extends Node
class_name Mining_Resources_Component
# This component handles the mining resources of an asteroid
@export var total_resources : Dictionary = {
    "Minerals" : 0,
    "Gas" : 0,
    "Crystals" : 0,
    "Artifact" : 0
}
var max_count : int  =0

func _ready() -> void:
    max_count += total_resources.get("Minerals")
    max_count += total_resources.get("Gas")
    max_count += total_resources.get("Crystals")
    max_count += total_resources.get("Artifact")
