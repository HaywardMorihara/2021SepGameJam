extends Particles2D


func _on_Timer_timeout():
	print("Cleaning up particle %s" % self)
	queue_free()
