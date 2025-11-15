class_name MaceObjectManager

extends Node

var maceElements: Dictionary[String, BaseMaceElement]

var actualElement: BaseMaceElement

func registerMaceElement(element: BaseMaceElement) -> Vector3:
	print(str("registered trail element: ", element.getInstanceId()))
	actualElement = element
	maceElements[element.getInstanceId()] = element
	print(str("now managing ", str(maceElements.size()), " objects"))
	return Vector3(0.0, 0.0, 0.0)
