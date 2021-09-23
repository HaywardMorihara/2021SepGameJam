extends HBoxContainer

var scene_name : String

func init(scene_name : String):
	self.scene_name = scene_name
	var creature_info = Global.creatures.get(self.scene_name)
	$CreatureName.text = creature_info.get("name")
	$CreatureDescription.text = creature_info.get("description")
	var sprite_name : String = creature_info.get("sprite_name")
	var sprite_x : int = creature_info.get("sprite_x")
	var sprite_y : int = creature_info.get("sprite_y")
	var t : AtlasTexture = AtlasTexture.new()
	t.atlas = load("res://assets/sprites/%s" % sprite_name)
	t.region = Rect2(0, 0, sprite_x, sprite_y)
	$CreatureImageTextureRect.texture = t


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var creature_info = Global.creatures.get(self.scene_name)
	$VBoxContainer/Count.text = String(creature_info.get("count"))


func _on_PlusButton_pressed():
	var total_count = 0
	for creature_info in Global.creatures.values():
		total_count += creature_info.get("count")
	if total_count >= Global.MAX_CREATURE_COUNT:
		print("TODO Toast")
	else:
		Global.creatures[self.scene_name]["count"] += 1


func _on_MinusButton_pressed():
	if Global.creatures.get(self.scene_name).get("count") > 0:
		Global.creatures[self.scene_name]["count"] -= 1
