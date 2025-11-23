class_name WatchedAnimation

extends Object

var animationPlayer: AnimationPlayer

var animationIdentifier: String

func _init(aPlayer: AnimationPlayer, aIdentifier: String) -> void:
	animationPlayer = aPlayer;
	animationIdentifier = aIdentifier;

func is_playing() -> bool:
	return animationPlayer.is_playing()
	
func play() -> void:
	animationPlayer.play(animationIdentifier)
