class_name MaceObjectManager

extends Node

var maceElements: Dictionary[String, BaseMaceElement]

var actualElement: BaseMaceElement

func registerMaceElement(element: BaseMaceElement) -> Vector3:
	print(str("registered trail element: ", element.getInstanceId()))
	maceElements[element.getInstanceId()] = element
	print(str("now managing ", str(maceElements.size()), " objects"))
	var calculatedPosition: Vector3
	if actualElement != null:
		calculatedPosition = actualElement.calculateSuccessorPosition(actualElement)
		print(str("calculated position: ", str(calculatedPosition)))
	else:
		calculatedPosition = Vector3.ZERO
		print("calculated NULL position...")
	actualElement = element
	return calculatedPosition
