extends Node
#Constant
const PLAYER_BASE_LIFETIME : float = 60.0

const SKILL_LIFETIME : String = "upgrade_lifetime"
const SKILL_SPEED : String = "upgrade_speed"
const SKILL_SCAN_EFFICIENCY : String = "upgrade_scan_efficiency"
const SKILL_MINING_EFFICIENCY : String = "upgrade_mining_efficiency"
const SKILL_DASH : String = "upgrade_dash"

@onready var _timer : Timer = $Timer

# Persistent Data Variables
var collected_resources : Dictionary = {
    "Minerals" :0,
    "Gas" : 0,
    "Crystals" : 0,
    "Artifact" : 0
}
var scanned_planets : Dictionary = {
    "Sun" : 0,
    "Mercury" : 0,
    "Venus" : 0,
    "Earth" : 0,
    "Mars" : 0,
    "Jupiter" : 0,
    "Saturn" : 0,
    "Uranus" : 0,
    "Neptune" : 0
}

var game_settings : Dictionary = {
    "volume" : 1.0,
    "graphics_quality" : "high",
    "control_sensitivity" : 1.0
}
var player_progress : Dictionary = {
    "current_evolution" : 1,
    "au_traveled" : 0, # total distance traveled in kilometers (astronomical units)
    "player_archived_game_goal" : 0,
    "upgrade_lifetime" : 1,
    "upgrade_speed" : 1,
    "upgrade_dash" : 1,
    "upgrade_scan_efficiency" : 1,
    "upgrade_mining_efficiency" : 1
}
################################## Functions ##################################
func _ready() -> void:
    ### DEBUG 
    reset_game_data()
    ### /DEBUG
    _timer.timeout.connect(_on_timer_timeout)
    _timer.start()
    #Load existing game data if available
    load_game_data()

func _on_timer_timeout() -> void:
    save_game_data()

##################### DATA SAVE, LOAD AND RESET METHODS #####################
func save_game_data() -> void:
    var data_to_save : Dictionary = {
        "collected_resources" : collected_resources,
        "scanned_planets" : scanned_planets,
        "game_settings" : game_settings,
        "player_progress" : player_progress
    }
    # Create a ConfigFile to save the data
    var config = ConfigFile.new()
    #Store the data in the config file
    config.set_value("game_data", "data", data_to_save)
    # Save the config file to disk
    var err = config.save("user://save_game.cfg")
    if err != OK:
        print("Error saving game data: ", err)
    else :
        print("Game data saved successfully.")
    

func load_game_data() -> void:
    # Create a ConfigFile to load the data
    var config = ConfigFile.new()

    # Load the config file from disk
    var err = config.load("user://save_game.cfg")
    # If the file didn't load successfully, return
    if err != OK:
        print("No save file found, starting new game.")
        return
    # Retrieve the saved data
    var saved_data = config.get_value("game_data", "data", null)
    # If saved data exists, populate the variables
    if saved_data != null:
        collected_resources = saved_data.get("collected_resources", collected_resources)
        scanned_planets = saved_data.get("scanned_planets", scanned_planets)
        game_settings = saved_data.get("game_settings", game_settings)
        player_progress = saved_data.get("player_progress", player_progress)
        print("Game data loaded successfully.")
    else:
        print("No saved data found in the save file.")

func reset_game_data() -> void:
    collected_resources ={
    "Minerals" :0,
    "Gas" : 0,
    "Crystals" : 0,
    "Artifact" : 0
    }
    scanned_planets = {
    "Sun" : 0,
    "Mercury" : 0,
    "Venus" : 0,
    "Earth" : 0,
    "Mars" : 0,
    "Jupiter" : 0,
    "Saturn" : 0,
    "Uranus" : 0,
    "Neptune" : 0
    }

    game_settings = {
    "volume" : 1.0,
    "graphics_quality" : "high",
    "control_sensitivity" : 1.0
    }
    player_progress  = {
    "current_evolution" : 1,
    "au_traveled" : 0,
    "player_archived_game_goal" : 0,
    "upgrade_speed" : 1,
    "upgrade_scan_efficiency" : 1,
    "upgrade_mining_efficiency" : 1
    }
    # Save Reseted Data
    save_game_data()