class_name AssetGobbler

extends Object

var asset: AbstractRessourceAsset

func _init(theAsset: AbstractRessourceAsset) -> void:
	asset = theAsset

func process() -> void:
	"""
	var presentation: Node3D = asset.getPresentationNode()
	presentation.scale -= Vector3(0.01, 0.01, 0.01)	
	var origScale = presentation.global_scale
	presentation.global_scale(Vector3(origScale.x-0.01,origScale.y-0.01,origScale.z-0.01))
	"""
	pass
