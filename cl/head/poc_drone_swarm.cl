CREATE "cameras"
"cameras" SET active false
"cameras" SET Transform position (-6 1 -50)
"cameras" SET Transform eulerAngles (0 0 0)
"cameras" ADD Orbit
"Canvas/Cameras/Viewport/Content" SET UI.GridLayoutGroup cellSize (1024 768)
"Canvas" SET active true
CREATE "cameras/cameraRGB"
"cameras/cameraRGB" SET active false
"cameras/cameraRGB" ADD Camera
"cameras/cameraRGB" SET Camera near 0.3 far 1000 fieldOfView 60
"cameras/cameraRGB" ADD Sensors.RenderCamera
"cameras/cameraRGB" SET Sensors.RenderCamera format "ARGB32" resolution (2048 1536)
"cameras/cameraRGB" SET Camera renderingPath "UsePlayerSettings"
"cameras/cameraRGB" ADD AudioListener
CREATE "EnviroSky" AS "EnviroSky"
"EnviroSky" SET EnviroSky Player "cameras" PlayerCamera "cameras/cameraRGB" GameTime.ProgressTime "None" weatherSettings.cloudTransitionSpeed 100 weatherSettings.effectTransitionSpeed 100 weatherSettings.fogTransitionSpeed 100 
"EnviroSky" EXECUTE EnviroSky AssignAndStart "cameras/cameraRGB" "cameras/cameraRGB"
"EnviroSky" SET active true
"cameras/cameraRGB" SET active true
"cameras" SET active true
"cameras/cameraRGB" ADD UnityEngine.PostProcessing.PostProcessingBehaviour
"cameras/cameraRGB" SET UnityEngine.PostProcessing.PostProcessingBehaviour profile "EnviroFX"
"cameras/cameraRGB" SET UnityEngine.PostProcessing.PostProcessingBehaviour profile.motionBlur.enabled false
CREATE "cameras/segmentation"
"cameras/segmentation" SET active false
"cameras/segmentation" ADD Camera
"cameras/segmentation" SET Camera near 0.3 far 1000 fieldOfView 60
"cameras/segmentation" ADD Sensors.RenderCamera
"cameras/segmentation" SET Sensors.RenderCamera format "ARGB32" resolution (1024 768)
"cameras/segmentation" SET Camera renderingPath "UsePlayerSettings" targetTexture.filterMode "Point"
"cameras/segmentation" ADD Segmentation.Segmentation
"cameras/segmentation" SET Segmentation.Segmentation minimumObjectVisibility 0 outputType "Auto" boundingBoxesExtensionAmount 0 transparencyCutout 0 
"cameras/segmentation" EXECUTE Segmentation.Segmentation DefineClass "Void"
"cameras/segmentation" PUSH Segmentation.Segmentation boundingBoxesFilter "Car"
"cameras/segmentation" ADD Segmentation.LookUpTable
"cameras/segmentation" PUSH Segmentation.LookUpTable classes "Void"
"cameras/segmentation" PUSH Segmentation.LookUpTable colors "black"
"cameras/segmentation" EXECUTE Segmentation.Segmentation DefineClass "Car"
"cameras/segmentation" PUSH Segmentation.LookUpTable classes "Car"
"cameras/segmentation" PUSH Segmentation.LookUpTable colors "blue"
"cameras/segmentation" EXECUTE Segmentation.LookUpTable MarkTextureDirty
"cameras/segmentation" SET active true
CREATE "disk1"
"disk1" SET active false
"disk1" ADD Sensors.Disk
"disk1" SET Sensors.Disk path "/tmp/"
"disk1" SET active true
"disk1" SET active false
CREATE "disk1/Cameras/camerargb"
"disk1/Cameras/camerargb" ADD Sensors.RenderCameraLink
"disk1/Cameras/camerargb" SET Sensors.RenderCameraLink target "cameras/cameraRGB"
"disk1/Cameras/camerargb" SET active true
CREATE "disk1/Cameras/segmentation"
"disk1/Cameras/segmentation" ADD Sensors.RenderCameraLink
"disk1/Cameras/segmentation" SET Sensors.RenderCameraLink target "cameras/segmentation"
"disk1/Cameras/segmentation" SET active true
"disk1" SET active true
CREATE "spawner/city/ground/container"
"spawner/city/ground/container" SET active false
"spawner/city/ground/container" ADD RandomProps.Torus
"spawner/city/ground/container" ADD RandomProps.PropArea
"spawner/city/ground/container" SET RandomProps.PropArea tags "ground"
"spawner/city/ground/container" SET RandomProps.PropArea async false numberOfProps 300 collisionCheck false stickToGround false 
"spawner/city/ground/container" SET RandomProps.Torus radius 150
"spawner/city/ground/container" SET RandomProps.Torus innerRadius 0
"spawner/city/ground/container" SET Transform position (0 0 0) eulerAngles (0 0 0) localScale (3 3 3)
"spawner/city/ground/container" SET active true
"spawner/city/ground" SET active true
CREATE "spawner/humans_0/container"
"spawner/humans_0/container" SET active false
"spawner/humans_0/container" ADD RandomProps.Torus
"spawner/humans_0/container" ADD RandomProps.PropArea
"spawner/humans_0/container" SET RandomProps.PropArea tags "human, +random"
"spawner/humans_0/container" SET RandomProps.PropArea async false numberOfProps 40 collisionCheck false stickToGround false 
"spawner/humans_0/container" SET RandomProps.Torus radius 30
"spawner/humans_0/container" SET RandomProps.Torus innerRadius 2
"spawner/humans_0/container" SET Transform position (0 0 0) eulerAngles (0 0 0) localScale (1 1 1)
"spawner/humans_0/container" SET active true
"spawner/humans_0" SET active true
CREATE "spawner/city/nature/trees/container"
"spawner/city/nature/trees/container" SET active false
"spawner/city/nature/trees/container" ADD RandomProps.Torus
"spawner/city/nature/trees/container" ADD RandomProps.PropArea
"spawner/city/nature/trees/container" SET RandomProps.PropArea tags "tree"
"spawner/city/nature/trees/container" SET RandomProps.PropArea async false numberOfProps 189 collisionCheck false stickToGround false 
"spawner/city/nature/trees/container" SET RandomProps.Torus radius 80
"spawner/city/nature/trees/container" SET RandomProps.Torus innerRadius 10
"spawner/city/nature/trees/container" SET Transform position (0 0 0) eulerAngles (0 0 0) localScale (1 1 1)
"spawner/city/nature/trees/container" SET active true
"spawner/city/nature/trees" SET active true
CREATE "spawner/city/buildings/container"
"spawner/city/buildings/container" SET active false
"spawner/city/buildings/container" ADD RandomProps.Torus
"spawner/city/buildings/container" ADD RandomProps.PropArea
"spawner/city/buildings/container" SET RandomProps.PropArea tags "building"
"spawner/city/buildings/container" SET RandomProps.PropArea async false numberOfProps 150 collisionCheck false stickToGround false 
"spawner/city/buildings/container" SET RandomProps.Torus radius 120
"spawner/city/buildings/container" SET RandomProps.Torus innerRadius 60
"spawner/city/buildings/container" SET Transform position (0 0 0) eulerAngles (0 0 0) localScale (1 1 1)
"spawner/city/buildings/container" SET active true
"spawner/city/buildings" SET active true
CREATE "spawner/animals/birds/container"
"spawner/animals/birds/container" SET active false
"spawner/animals/birds/container" ADD RandomProps.Torus
"spawner/animals/birds/container" ADD RandomProps.PropArea
"spawner/animals/birds/container" SET RandomProps.PropArea tags "bird"
"spawner/animals/birds/container" SET RandomProps.PropArea async false numberOfProps 54 collisionCheck true stickToGround false 
"spawner/animals/birds/container" SET RandomProps.Torus radius 120
"spawner/animals/birds/container" SET RandomProps.Torus innerRadius 0
"spawner/animals/birds/container" SET Transform position (0 75 0) eulerAngles (0 0 0) localScale (1 1 1)
"spawner/animals/birds/container" SET active true
"spawner/animals/birds" SET active true
CREATE "spawner/cars/container"
"spawner/cars/container" SET active false
"spawner/cars/container" ADD RandomProps.Torus
"spawner/cars/container" ADD RandomProps.PropArea
"spawner/cars/container" SET RandomProps.PropArea tags "car"
"spawner/cars/container" SET RandomProps.PropArea async false numberOfProps 75 collisionCheck false stickToGround false 
"spawner/cars/container" SET RandomProps.Torus radius 50
"spawner/cars/container" SET RandomProps.Torus innerRadius 5
"spawner/cars/container" SET Transform position (0 0 0) eulerAngles (0 0 0) localScale (1 1 1)
"spawner/cars/container" SET active true
"spawner/cars" SET active true
CREATE "spawner/roadsigns/container"
"spawner/roadsigns/container" SET active false
"spawner/roadsigns/container" ADD RandomProps.Torus
"spawner/roadsigns/container" ADD RandomProps.PropArea
"spawner/roadsigns/container" SET RandomProps.PropArea tags "roadsign"
"spawner/roadsigns/container" SET RandomProps.PropArea async false numberOfProps 250 collisionCheck false stickToGround false 
"spawner/roadsigns/container" SET RandomProps.Torus radius 80
"spawner/roadsigns/container" SET RandomProps.Torus innerRadius 15
"spawner/roadsigns/container" SET Transform position (0 0 0) eulerAngles (0 0 0) localScale (1 1 1)
"spawner/roadsigns/container" SET active true
"spawner/roadsigns" SET active true
CREATE "drone/dr_0" "Drones/splinter/splinter"
"drone/dr_0" ADD Segmentation.ClassGroup
"drone/dr_0" SET Segmentation.ClassGroup itemsClassName "Car"
"drone/dr_0" SET Transform position (0 1 0)
CREATE "drone/dr_1" "Drones/DJI_Inspire-2/DJI_Inspire_2"
"drone/dr_1" ADD Segmentation.ClassGroup
"drone/dr_1" SET Segmentation.ClassGroup itemsClassName "Car"
"drone/dr_1" SET Transform position (1 1 0)
CREATE "drone/dr_2" "Drones/DJI_Mavic_Pro/DJI_Mavic_Pro"
"drone/dr_2" ADD Segmentation.ClassGroup
"drone/dr_2" SET Segmentation.ClassGroup itemsClassName "Car"
"drone/dr_2" SET Transform position (2 1 0)
CREATE "drone/dr_3" "Drones/red/red"
"drone/dr_3" ADD Segmentation.ClassGroup
"drone/dr_3" SET Segmentation.ClassGroup itemsClassName "Car"
"drone/dr_3" SET Transform position (3 1 0)
CREATE "drone/dr_4" "Drones/DJI Spreading Wings S1000 Professional Octocopter/Spreading_Wings_S1000"
"drone/dr_4" ADD Segmentation.ClassGroup
"drone/dr_4" SET Segmentation.ClassGroup itemsClassName "Car"
"drone/dr_4" SET Transform position (4 1 0)
CREATE "drone/dr_5" "Drones/white/white"
"drone/dr_5" ADD Segmentation.ClassGroup
"drone/dr_5" SET Segmentation.ClassGroup itemsClassName "Car"
"drone/dr_5" SET Transform position (5 1 0)
CREATE "drone/dr_6" "Drones/DJI_Phantom_4_Pro/DJI_Phantom_4_Pron"
"drone/dr_6" ADD Segmentation.ClassGroup
"drone/dr_6" SET Segmentation.ClassGroup itemsClassName "Car"
"drone/dr_6" SET Transform position (6 1 0)
CREATE "drone/dr_7" "Drones/Parrot Disco Drone/Parrot_Disco"
"drone/dr_7" ADD Segmentation.ClassGroup
"drone/dr_7" SET Segmentation.ClassGroup itemsClassName "Car"
"drone/dr_7" SET Transform position (7 1 0)
CREATE "drone/dr_8" "Drones/DJI_Phantom_3_Pro/DJI_Phantom_3_Pro"
"drone/dr_8" ADD Segmentation.ClassGroup
"drone/dr_8" SET Segmentation.ClassGroup itemsClassName "Car"
"drone/dr_8" SET Transform position (8 1 0)
CREATE "drone/dr_9" "Drones/DJI_Phantom_4_Pro_obsidian/DJI_Phantom_4_Pro_obsidian"
"drone/dr_9" ADD Segmentation.ClassGroup
"drone/dr_9" SET Segmentation.ClassGroup itemsClassName "Car"
"drone/dr_9" SET Transform position (9 1 0)
"cameras/cameraRGB" SET Camera enabled true
"cameras" SET Transform position (0 1 0)
"cameras" SET Transform eulerAngles (-20 0 0)
"EnviroSky" EXECUTE EnviroSky ChangeWeather "Cloudy 1"
"EnviroSky" SET EnviroSky cloudsMode "Volume"
"EnviroSky" SET EnviroSky cloudsSettings.globalCloudCoverage -0.04
"drone" SET Transform position (-17 0.5 24)
"drone" SET Transform eulerAngles (0 0 0)
