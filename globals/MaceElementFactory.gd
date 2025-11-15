class_name MaceElementFactory

extends Node

var forkInstance: PackedScene = preload("res://assets/mace_elements/inherited_elements/fork/ForkMaceElement.tscn")	
var trailInstance: PackedScene = preload("res://assets/mace_elements/inherited_elements/trail/TrailMaceElement.tscn")	

enum MaceElementType {
	TRAIL, FORK
}
# TODO why does this not work?
func buildElement(maceElementType: MaceElementType) -> BaseMaceElement:
	
	"""
	match (maceElementType):
		MaceElementType.TRAIL:
			print(str("building element of type trail..."))
			return trailInstance.instantiate();
		MaceElementType.FORK:
			print(str("building element of type fork..."))
			return forkInstance.instantiate();
	return null
	"""
	
	"""
	if maceElementType == MaceElementType.TRAIL:
		print(str("building element of type trail..."))
		return trailInstance.instantiate();
	elif maceElementType == MaceElementType.FORK:
		print(str("building element of type fork..."))
		return forkInstance.instantiate();
	return null
	"""
	
	return trailInstance.instantiate();
	# return forkInstance.instantiate();

func buildTrailElement() -> BaseMaceElement:
	return trailInstance.instantiate();
	
func buildForkElement() -> BaseMaceElement:
	return forkInstance.instantiate();
