import random
import subprocess
import os
import pathlib
import time
from .. import common, helpers, settings_manager
from random import randint

settings = settings_manager.Singleton()

def help():
	return '''\
Animals thermal in Savannah scene
	- Creates a Thermal camera
	- Creates a Depth camera
	- Creates a Segmentation camera
	- Spawns animals with thermal on Savannah scene
	- Flys around as a drone, rotating height , distance and azimuth
	- Exports depth maps, thermal images, segmentation images and bounding boxes
'''

def run():
	settings.keep = True
	mycams = ['cameras/cameraRGB', 'cameras/segmentation', 'cameras/cameraDepth']
	# mycams = ['cameras/cameraRGB', 'cameras/cameraDepth']
	
	dist = 8900
	azimuth = 0
	elevation = 72
	y_rot = 0
	snapOffset = 60
	
	snapOffset_range = [ 55, 65 ]
	elevation_range = [ 32, 72 ]
	
	incr_e = -.25 # elevation increment
	incr_a = .5 # azimuth increment
	incr_d = -2.5 # distance increment
	incr_s = .5 # snap offset increment
	
	min_agc = 9
	max_agc = 35
	
	terrain_ambient_offset = 0
	terrain_ambient_bandwidth = 50
	terrain_ambient_median = 0
	
	if settings.skip_setup == False:
		common.send_data([
			'CREATE savannah tiles Savannah',
			'savannah ADD WindZone',
			'savannah SET active true'
		])
		
		helpers.global_camera_setup(
			orbitOffset=[1667.05, 32.37876, 1000],
			orbitSnap=snapOffset,
			orbitGround='savannah/Main Terrain'
		)
		
		helpers.add_camera_seg(width=1024, height=768, fov=90, clipping_far=10000)
		
		helpers.add_camera_rgb(
			width=1024, height=768, pp=None, thermal=True, envirosky=False, thermal_trees=True,
			thermal_ambientTemperature=15, thermal_minimumTemperature=9, thermal_maximumTemperature=35,
			thermal_trees_base=8, thermal_trees_bandwidth=50, thermal_trees_median=0, thermal_trees_leafs_variance=10,
			fov=90,
			clipping_far=10000
		)
		
		helpers.add_camera_depth(width=1024, height=768, fov=90)
		helpers.global_disk_setup()
		helpers.add_disk_output(mycams)
		
		# 500 animals per pool * 16 = ~10G RAM
		helpers.spawn_rectangle_generic(
			# ['+carthermal', '+animal, +thermal, +savannah', '+animal, +thermal, +savannah', '+animal, +thermal, +savannah' ,'+animal, +thermal, +savannah', '+animal, +thermal, +savannah', '+animal, +thermal, +savannah', '+animal, +thermal, +savannah' ,'+animal, +thermal, +savannah', '+animal, +thermal, +savannah', '+animal, +thermal, +savannah', '+animal, +thermal, +savannah' ,'+animal, +thermal, +savannah', '+animal, +thermal, +savannah', '+animal, +thermal, +savannah', '+animal, +thermal, +savannah' ],
			# names=['cars0', 'animals0', 'animals1', 'animals2', 'animals3', 'animals4', 'animals5', 'animals6', 'animals7', 'animals8', 'animals9', 'animalsA', 'animalsB', 'animalsC', 'animalsD', 'animalsE'],
			['+carthermal', '+animal, +thermal, +savannah', '+animal, +thermal, +savannah', '+animal, +thermal, +savannah' ,'+animal, +thermal, +savannah'],
			names=['cars0', 'animals0', 'animals1', 'animals2', 'animals3'],
			limit=50, a=5000, b=625, position=[2519, 591, 9630],
			
			collision_check=True,
			
			segmentation_class="animals",
			stick_to_ground=True
		)
		
		helpers.spawn_rectangle_generic(
			['+animal, +thermal, +savannah' ],
			names=['animalsF'],
			limit=50, a=100, b=100, position=[1685, 591, 9856],
			
			collision_check=True,
			
			segmentation_class="animals",
			stick_to_ground=True
		)
		
		common.send_data([
			'"savannah/Main Terrain" SET Thermal.ThermalTerrain ambientOffset {}'.format(terrain_ambient_offset),
			'"savannah/Main Terrain" SET Thermal.ThermalTerrain bandwidth {}'.format(terrain_ambient_bandwidth),
			'"savannah/Main Terrain" SET Thermal.ThermalTerrain median {}'.format(terrain_ambient_median),
			
			# set profiles heatiness
			'"spawner/cars0/RangeRover(Clone)" SET Thermal.ThermalObjectBehaviour profile.heatiness.value 50',
			'"spawner/animals0/Rino(Clone)" SET Thermal.ThermalObjectBehaviour profile.heatiness.value 50',
			'"spawner/animals0/giraffe(Clone)" SET Thermal.ThermalObjectBehaviour profile.heatiness.value 35',
			'"spawner/animals0/Buffalo(Clone)" SET Thermal.ThermalObjectBehaviour profile.heatiness.value 50',
			'"spawner/animals0/Pelican(Clone)" SET Thermal.ThermalObjectBehaviour profile.heatiness.value 50',
			'"spawner/animals0/Flamingo(Clone)" SET Thermal.ThermalObjectBehaviour profile.heatiness.value 50',
			'"spawner/animals0/Vulture_Red(Clone)" SET Thermal.ThermalObjectBehaviour profile.heatiness.value 50',
			'"spawner/animals0/Vulture_White(Clone)" SET Thermal.ThermalObjectBehaviour profile.heatiness.value 50',
			'"spawner/animals0/Elef(Clone)" SET Thermal.ThermalObjectBehaviour profile.heatiness.value 40',
			
			# respawn them to update profiles properly
			'spawner SET active false',
			
			'spawner/animals1 SET Transform position (2519 591 9005)',
			'spawner/animals2 SET Transform position (2519 591 8380)',
			'spawner/animals3 SET Transform position (2519 591 7755)',
			'spawner/animals4 SET Transform position (2519 591 7130)',
			'spawner/animals5 SET Transform position (2519 591 6505)',
			'spawner/animals6 SET Transform position (2519 591 5880)',
			'spawner/animals7 SET Transform position (2519 591 5255)',
			'spawner/animals8 SET Transform position (2519 591 4630)',
			'spawner/animals9 SET Transform position (2519 591 4005)',
			'spawner/animalsA SET Transform position (2519 591 3380)',
			'spawner/animalsB SET Transform position (2519 591 2755)',
			'spawner/animalsC SET Transform position (2519 591 2130)',
			'spawner/animalsD SET Transform position (2519 591 1505)',
			'spawner/animalsE SET Transform position (2519 591 880)',
			# 'spawner/animalsF SET Transform position (2519 591 255)',
			
			'cameras/segmentation SET Segmentation.Segmentation OutputType InstanceIds',
			
			'spawner SET active true'
			
		], read=False)
	
	# warm up
	helpers.do_render(mycams)
	
	while dist > 0:
		common.send_data([
			'cameras/cameraRGB SET Thermal.ThermalCamera temperatureRange ({} {})'.format(min_agc, max_agc),
			'cameras SET Orbit distance {}'.format(dist),
			'cameras SET Orbit elevation {}'.format(elevation),
			'cameras SET Orbit azimuth {}'.format(azimuth),
			'cameras SET Orbit snapOffset {}'.format(snapOffset)
		], read=False)
		
		helpers.take_snapshot(mycams, True)
		
		# random agc values
		min_agc = randint(-9, 2)
		max_agc = randint(25, 35)
		
		snapOffset = snapOffset + incr_s
		elevation = elevation + incr_e
		azimuth += incr_a
		dist += incr_d
		
		if elevation >= elevation_range[1] or elevation <= elevation_range[0]:
			incr_e = incr_e * -1
		if snapOffset >= snapOffset_range[1] or snapOffset <= snapOffset_range[0]:
			incr_s = incr_s * -1
		if azimuth >= 360:
			azimuth = 0
