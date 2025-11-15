class_name TrailMaceElement

extends BaseMaceElement

func getExpansion() -> int:
	return 4

func getInstanceId() -> String:
	return str("Trail@", str(get_instance_id()))
