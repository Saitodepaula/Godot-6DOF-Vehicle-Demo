# Godot-6DOF-Vehicle-Demo
Demo using [Godot Engine](https://godotengine.org/) [Generic 6DOF joints](https://docs.godotengine.org/en/stable/classes/class_generic6dofjoint.html) to make a fully working, physics based vehicle.

The physics and joints setup is exactly the same I use on my racing game [TrackMaster: Free-For-All Motorsport](https://store.steampowered.com/app/1536740/TrackMaster_FreeForAll_Motorsport/).

[Video here](https://www.youtube.com/watch?v=ZigUEiS5n2w)

![Image01](https://user-images.githubusercontent.com/22160489/126226334-b6faa219-2bda-4ddc-a1d0-f487e53b51aa.JPG)

After 1.5 year of development of TrackMaster, I decided to make a free and open source demo of the basics of how the game vehicles works. 

Every time I've posted videos of TrackMaster's updates, I always received questions about how I made the physics, and how I use joints. 

Seeing how there is little to no educational resources (tutorials) on 6DOF joints in Godot, I decided it was time to make a small contribution to the Godot community, and this is also a way to say "thank you" to this ever growing and awesome community.

## This demo contains:

1. A main scene, with obstacles and ramps, as static bodies.
2. A working, physics based, monster truck like vehicle, based on 6DOF joints, with the script that make it works.
3. The blend file used for the vehicle visual instance (mesh).
4. Two additional scenes, with no scripts, showing the very basics of 6DOF joints.

## Main Features

1. Works with Godot 3.x.
2. Use this demo the way you like it, it's completely free.
3. Just press F5 and have fun!
4. Completely physics and joints based, no raycast suspension or other methods (not that it's better, it's just a different approach). This means torque is added to the wheels and the spinning of the wheel makes the vehicle move.
5. Body and wheels are regular rigid bodies. This has the advantage of the vehicle behaving in a completely free way, with no physical constrains: it can roll, topple and react to any other static or rigid body.
6. Eventual moving parts you may want to add, like doors and bumpers, can be added in the same way, with rigid bodies and 6DOF joints.
7. The physics behaviour (suspension travel, acceleration, top speed) needs no code. They are all 6DOF joints parameters set in the editor. In the demo, I set acceleration and top speed inside the code for convenience, but it doesn't need to be this way.
8. Script is only needed for input, to control the vehicle.
9. Inputs are custom actions, defined in the INPUT MAP (PROJECT SETTINGS).
10. Physics run on 240 FPS, for stability reasons. Sincerely, in this demo there would be no difference to run with 60 or other physics FPS, but if you want to try bigger tracks/maps/environments, it can be an issue. More on this topic on DISADVANTAGES, below.

## Disadvantages

**WARNING: As of July 2021, this demo only works with Bullet physics.**

1. The advantage of being completely physics based can also be a disadvantage, depending on what you want to achieve. This setup is subject to suffer from the following bugs/issues: 

https://github.com/godotengine/godot/issues/54761

https://github.com/godotengine/godot/issues/46596

https://github.com/godotengine/godot/issues/50463

https://github.com/godotengine/godot/issues/36729

2. Since Bullet will be an official plugin in Godot 4, and the default physics engine will be Godot Physics, you may also think if you want to use a setup like this.
3. As of July 2021, I've tried to make a 6DOF setup in Godot 4, and couldn't even assign two bodies to the joint in the editor.

## Future Updates

I can't guarantee future updates. That said, I may update this demo in the future. Please, share your opinion, feedback and request for more features.

I also may make a video tutorial in the future, explaining every detail.

## Other Approaches

Since the idea is to share and spread knowledge, there is no reason for me not to mention other vehicle physics approaches in Godot. Here is just a brief list of things I've found interesting around the internet.

### GDSIM by Wolfe

https://www.gtplanet.net/forum/threads/gdsim-v0-3a-launch-sim-workshop-devlog.396400/

https://www.youtube.com/watch?v=aqUTh39nGSM&list=LL&index=10

### Godot Engine - Advanced Vehicle Physics by Thales Kruger Games

https://www.youtube.com/watch?v=PZjpnn9Jmow&list=LL&index=9&t=391s

https://sabudum.gumroad.com/l/PsTbK

### Tobalation/GDCustomRaycastVehicle

https://github.com/Tobalation/GDCustomRaycastVehicle

### Voxel based game by soloCodeNet 

https://www.reddit.com/r/godot/comments/oz2358/all_voxel_based_game/

### Sphere base physics by KenNL

https://www.reddit.com/r/godot/comments/oyh3vb/ive_been_learning_godot_for_a_week_or_two_now_and/

### Simple 3D Car Physics using RigidBody and Raycasts by MikeLumos

https://www.reddit.com/r/godot/comments/la2jxa/simple_3d_car_physics_using_rigidbody_and/

https://godotacademy.gumroad.com/l/godot-racing/free%E2%80%8B

### Physics based hoverboard in Godot by MrEliptik

https://github.com/MrEliptik/godot_experiments/tree/master/3D/hoverboard

https://www.youtube.com/watch?v=6wUo0WWM4fg


