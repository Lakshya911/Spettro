extends Node2D

@onready var progress_bar = $%LL
@onready var status_label = $Label
@onready var status_labe = $Label2

var scene_path = "res://3d_main.tscn"
var progress = []
var loading_stage = 0
var hidden_viewport = null
var environment_resource = null
var placeholder_camera = null
var placeholder_environment = null
var black_overlay = null

func _ready():
	print("Advanced loading system initialized")
	progress_bar.value = 0
	status_label.text = "Preparing..."
	status_labe.text = "Preparing..."
	
	# Create a full-screen black overlay to hide any brown flash
	black_overlay = ColorRect.new()
	black_overlay.color = Color(0, 0, 0, 1) # Solid black
	black_overlay.size = get_viewport_rect().size
	black_overlay.mouse_filter = Control.MOUSE_FILTER_IGNORE
	add_child(black_overlay)
	
	# Start the loading process
	call_deferred("_initialize_loading")

func _initialize_loading():
	# Stage 1: Create a hidden sub-viewport for pre-rendering
	hidden_viewport = SubViewport.new()
	hidden_viewport.size = Vector2(64, 64) # Small size for efficiency
	hidden_viewport.render_target_update_mode = SubViewport.UPDATE_ALWAYS
	hidden_viewport.transparent_bg = false
	hidden_viewport.disable_3d = false
	add_child(hidden_viewport)
	
	# Create a default environment for the hidden viewport
	placeholder_environment = WorldEnvironment.new()
	var env = Environment.new()
	env.background_mode = Environment.BG_COLOR
	env.background_color = Color(0, 0, 0) # Black background
	env.ambient_light_color = Color(1, 1, 1)
	env.ambient_light_energy = 1.0
	placeholder_environment.environment = env
	hidden_viewport.add_child(placeholder_environment)
	
	# Add a camera to the hidden viewport
	placeholder_camera = Camera3D.new()
	placeholder_camera.current = true
	hidden_viewport.add_child(placeholder_camera)
	
	# Wait one frame to ensure the viewport is properly set up
	await get_tree().process_frame
	
	# Start async loading of the target scene
	status_label.text = "Loading resources..."
	status_labe.text = "Loading resources..."
	ResourceLoader.load_threaded_request(scene_path)
	loading_stage = 1

func _process(delta):
	match loading_stage:
		1: # Monitoring resource loading
			var status = ResourceLoader.load_threaded_get_status(scene_path, progress)
			
			if progress.size() > 0:
				progress_bar.value = progress[0] * 50 # First half of the progress bar
				
			if status == ResourceLoader.THREAD_LOAD_LOADED:
				print("Main scene loaded in memory, preparing for display")
				status_label.text = "Preparing scene..."
				status_labe.text = "Preparing scene..."
				loading_stage = 2
				call_deferred("_prepare_scene")
				
		2: # Scene is being prepared, progress is handled in _prepare_scene
			pass
			
		3: # Transitioning to the actual scene
			pass

func _prepare_scene():
	# Get the loaded scene resource
	var scene_resource = ResourceLoader.load_threaded_get(scene_path)
	
	if !scene_resource:
		print("ERROR: Failed to load scene resource")
		return
	
	# Create a temporary instance for the hidden viewport
	var temp_instance = scene_resource.instantiate()
	
	# First search for the environment to preload it
	var world_environment = _find_world_environment(temp_instance)
	if world_environment and world_environment.environment:
		print("Found WorldEnvironment, preloading...")
		# Store this for later use
		environment_resource = world_environment.environment
	
	# Add the instance to our hidden viewport
	hidden_viewport.add_child(temp_instance)
	
	# Gather all materials, meshes and textures
	status_label.text = "Preloading graphics..."
	status_labe.text = "Preloading graphics..."
	
	# Wait for 2 frames to let the viewport start rendering
	await get_tree().process_frame
	await get_tree().process_frame
	
	# Let the GPU process the scene briefly
	for i in range(10):
		progress_bar.value = 50 + (i * 2) # Second half of progress
		await RenderingServer.frame_post_draw
		await get_tree().process_frame
	
	# Force several more frames for good measure
	status_label.text = "Finalizing..."
	status_labe.text = "Finalizing..."
	progress_bar.value = 95
	
	for i in range(5):
		await RenderingServer.frame_post_draw
		await get_tree().process_frame
	
	# Clean up the temporary instance and viewport
	if is_instance_valid(temp_instance):
		temp_instance.queue_free()
	
	# One more frame to make sure the temporary instance is gone
	await get_tree().process_frame
	
	# We're ready to transition now
	loading_stage = 3
	_transition_to_scene(scene_resource)

func _transition_to_scene(scene_resource):
	# For ultimate safety, we will:
	# 1. Keep the black overlay visible
	# 2. Directly set the WorldEnvironment if we found one earlier
	# 3. Then change the scene
	# 4. Apply a final fade-out of the overlay once everything is ready

	# Use a custom scene switching approach
	var new_scene_instance = scene_resource.instantiate()
	
	# Get the current scene root
	var current_root = get_tree().current_scene
	
	# Add our instance as a sibling (not child) of current root
	get_tree().root.add_child(new_scene_instance)
	
	# If we preloaded the environment, apply it to fix skybox/lighting immediately
	if environment_resource:
		var env_node = _find_world_environment(new_scene_instance)
		if env_node:
			env_node.environment = environment_resource
	
	# Hide the new scene until fully ready
	new_scene_instance.visible = false
	
	# Wait a few frames to ensure everything is ready
	for i in range(3):
		await RenderingServer.frame_post_draw
		await get_tree().process_frame
	
	# Make new scene visible
	new_scene_instance.visible = true
	
	# Properly set it as the current scene
	get_tree().current_scene = new_scene_instance
	
	# Wait another frame
	await get_tree().process_frame
	
	# Create a new overlay in the new scene
	var final_overlay = ColorRect.new()
	final_overlay.color = Color(0, 0, 0, 1)
	final_overlay.size = get_viewport_rect().size
	final_overlay.mouse_filter = Control.MOUSE_FILTER_IGNORE
	new_scene_instance.add_child(final_overlay)
	
	# Remove the old scene
	current_root.queue_free()
	
	# Clean up our hidden viewport
	if is_instance_valid(hidden_viewport):
		hidden_viewport.queue_free()
	
	# Fade out the black overlay
	var tween = get_tree().create_tween()
	tween.tween_property(final_overlay, "modulate", Color(0, 0, 0, 0), 0.5)
	await tween.finished
	
	# Clean up the overlay when done
	final_overlay.queue_free()
	
	print("Scene transition complete!")

# Helper function to find WorldEnvironment in the scene
func _find_world_environment(node):
	if node is WorldEnvironment:
		return node
	
	for child in node.get_children():
		var result = _find_world_environment(child)
		if result:
			return result
	
	return null
