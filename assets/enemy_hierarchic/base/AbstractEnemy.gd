@abstract class_name AbstractEnemy

extends CharacterBody3D

const MAX_HITPOINTS = 10

var applied_hits: int = 0

func applyWeaponHit() -> void:
	applied_hits += 1
	var hitPointsleft: int = MAX_HITPOINTS - applied_hits
	# print(str("hit points left --> ", str(hitPointsleft)))
	if hitPointsleft <= 0:
		die()

@abstract func die() -> void
