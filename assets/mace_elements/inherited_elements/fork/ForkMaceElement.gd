class_name ForkMaceElement

extends BaseMaceElement

func getExpansion() -> int:
	return 2

func getInstanceId() -> String:
	return str("Fork@", str(get_instance_id()))
