class_name AnimationWatcher

extends Object

var watchedItems : Array[WatchedAnimation] = []
	
func registerAnimation(player: AnimationPlayer, animIdentifier: String) -> void:	
	watchedItems.append(WatchedAnimation.new(player, animIdentifier))

func tick() -> void:
	for watchedItem in watchedItems:
		if !watchedItem.is_playing():
			watchedItem.play()
