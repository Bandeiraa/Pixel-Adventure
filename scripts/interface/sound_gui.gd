extends Control

onready var animation: AnimationPlayer = get_node("Animation")
onready var song_text: TextureRect = get_node("SongText")

var tracks: Array = ["celestial", "red carpet wooden floor", "windless slopes"]

func display_song(target: String) -> void:
	song_text.texture = load("res://assets/interface/text/song_text/" + tracks[tracks.find(target)] + ".png")
	animation.play("show_song")
