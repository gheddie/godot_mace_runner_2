class_name MaceElementFactory

extends Node

var forkInstance: PackedScene = preload("res://assets/mace_elements/inherited_elements/fork/ForkMaceElement.tscn")	
var trailInstance: PackedScene = preload("res://assets/mace_elements/inherited_elements/trail/TrailMaceElement.tscn")	

enum MaceElementType {
	TRAIL, FORK
}

func buildTrailElement() -> TrailMaceElement:
	return trailInstance.instantiate();
	
func buildForkElement() -> ForkMaceElement:
	return forkInstance.instantiate();
