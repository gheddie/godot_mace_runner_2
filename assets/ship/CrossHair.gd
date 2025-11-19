@tool
extends Control

const TOP_OFFSET = 100

func _draw() -> void:
	
	draw_circle(Vector2(0,-TOP_OFFSET), 3, Color.WHITE)
	
	draw_line(Vector2(16,-TOP_OFFSET), Vector2(24,-TOP_OFFSET), Color.MAGENTA, 2.0)
	draw_line(Vector2(-16,-TOP_OFFSET), Vector2(-24,-TOP_OFFSET), Color.MAGENTA, 2.0)
	
	draw_line(Vector2(0,16-TOP_OFFSET), Vector2(0,24-TOP_OFFSET), Color.MAGENTA, 2.0)
	draw_line(Vector2(0,-16-TOP_OFFSET), Vector2(0,-24-TOP_OFFSET), Color.MAGENTA, 2.0)
