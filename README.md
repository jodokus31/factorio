# Mods for factorio
Features some mods for the game factorio.

# The Spice Rack
The Spice Rack is intended to spice up the vanilla game by changing some well chosen details. Most changes can be disabled individually.


## The Spice Rack - Lazy Assemblers
Crafting limitations for lower tier assemblers (and character) to make progression more meaningful

### Crafting Limitation
Select crafting limitation:\
"disabled" - off\
"assembler only" - Lower tiers of assemblers are not able to craft several midgame and advanced recipes\
"assembler and character" - Additionally, the character can't handcraft several midgame and advanced recipes (a subset of recipes from "assembler only"

### Classic lazy bastard
Lazy Bastard gets more challenging. First assembler 2 and oil refineries have to be crafted by hand. Oil refineries can only be crafted in assembler 3.\
Factorio 0.16 behaved that way and it challenges to not waste the free handcrafts\
(Does nothing if "Crafting Limitation" is disabled)

### Lazy bastard marathon
The first player receives some intermediate products (gears, copper wires) on map start to have a chance to achieve lazy bastard with marathon settings.


## The Spice Rack - Oil Change
Change basic oil processing to output petroleum gas and additional heavy oil. Sulfur is obtained from heavy oil.\
Chemical science is not necessary for robotic technologies and can be omitted (configurable)

### Oil change
"disabled" = off\
"basic oil only" = Basic oil processing produces extra heavy oil and sulfur is made from heavy oil. Solid fuel and cracking from heavy oil is available earlier. Solid fuel from petroleum consumes more\
"basic oil and research" = Like "basic oil only", plus no chemical science pack is required for lubricant, electric engine and other robotic technologies

### Steam cracking
Heavy and light oil cracking uses steam instead of water

### Solid fuel acceleration
Solid fuel acceleration is 140%



## The Spice Rack - Pollution
Change effectivity modules and furnaces/drills to increase difficulty due to pollution

### Effectivity modules
Change impact of efficiency modules:\
Effectivity module 1 has only 20% reduction\
Effectivity module 2 has 60% reduction\
Effectivity module 3 has 200% reduction

### Mining drill module slots
The electric mining drill has only 2 module slots

### Furnace power usage
All furnaces consume more fuel/energy:\
The stone furnace consumes more fuel and produces more pollution.\
The steel furnace consumes even more fuel, but pollution is like vanilla.\
The electric furnace is 1.5 times faster and produces more pollution accordingly. Power usage is higher, but it has 3 module slots.\
The burner mining drill is worse and produces more pollution and consumes more fuel



## The Spice Rack - Presets
Map presets for harder rail worlds

### (SR) Rail world
Rail world with higher time evolution. Resources are scarcer, but almost as large as vanilla rail world.

### (SR) Death rail world
Rail world with death world biter and pollution settings. Resources are scarcer, but almost as large as vanilla rail world.

### (SR) Rail world marathon
Rail world with higher time evolution and marathon recipes and technology setting. Resources are scarcer, but almost as large as vanilla rail world. 

### (SR) Death rail world marathon
Rail world with death world marathon biter, pollution, recipes and technology settings. Resources are scarcer, but almost as large as vanilla rail world.


### (SR) Rail world small but rich
Rail world with higher time evolution. Resources are scarcer and smaller, but richer (except oil).

### (SR) Death rail world small but rich
Rail world with death world biter and pollution settings. Resources are scarcer and smaller, but richer (except oil).

### (SR) Rail world marathon small but rich
Rail world with higher time evolution and marathon recipes and technology setting. Resources are scarcer and smaller, but richer (except oil).

### (SR) Death rail world marathon small but rich
Rail world with death world marathon biter, pollution, recipes and technology settings. Resources are scarcer and smaller, but richer (except oil).



## The Spice Rack - Science
Small, but impactful changes to science, labs and rocket silo to increase difficulty.

### Lab
The lab needs 3 times more power and a lamp to construct (20 lamps are added at the beginning, also for dark moments)

### Utility science
Utility science pack requires uranium-238

### Production Science & Furnace progression
Furnaces depend on lower tiers, so it affects production science pack and early game\
The stone furnace is built from stone bricks, which affects early game.\
The steel furnace just needs additional steel.\
The electric furnace needs additional concrete instead of bricks (less steel compared to vanilla)

### Rocket silo
The rocket silo research needs additional military science.\nThe rocket silo needs refined concrete instead of concrete and a programmable speaker



## The Spice Rack - Tweak Military
Several minor military balancing changes. (turrets, tanks, shotgun, research, damage, cost, ...)

### Long range gun turret
New long range gun turret (similar to the range of laser turret) with slower shooting speed\
It has lower DPS than a normal gun turret, but benefits more from damage upgrades

### Military 3 research
Military 3 research does not require chemical science pack. Same for new long range turret research

### Early military upgrade researches
Physical projectile damage 3 and Weapon shooting speed 3 has shorter research time (45 instead of 60).\
Weapon shooting speed is a bit less expensive for tier 1, 2 and 3 

### Shotgun
Improve shotgun (more near damage, projectiles spread wider, character moves a bit faster while shooting). It has a bit of aoe damage directly in front and a small pushback

### Follower robot count
Follower robot count researches are less expensive

### Flamethrower
The flamethrower turret consumes 5 times more oil and has less base damage. The refined flammable research adds more damage as compensation.\
Crude oil has only 50% damage, heavy oil 70% and light oil 100%.\
The flamethrower research is more expensive.\
The flamethrower ammo also has less base damage and needs light oil instead of crude oil.

### Laser turrets
The laser turret has more drain (60kW instead of 24kW)

### Spawners
Spawners are harder to kill (more health, more self healing, addtional laser and impact resistances)

### Biters
Big and behemoth biters have additional laser resistance.

### Gun turret damage research
Gun turrets (and the new long range turret) profit less from physical damage research to reduce their insane DPS in late game

### Gun turret health
Gun turret health gets increased to be less fragile

### Landmines
Landmines are twice as expensive and base damage is reduced from 250 to 150.\nArming timeout has increased from 2 to 5 sec. and the stun time is reduced from 3 to 1.5 sec.

### Tank
Improve tank (more hitpoints, weight and impact), but its more expensive

### Car
Improve car (more hitpoints and resistances)

### Repair pack
Repair pack is more expensive




## The Spice Rack - Decaying goods
Buffering gets even worse. Basic goods are decaying and emitting pollution, if they are buffered in chests. The more a chest is filled, the bigger percentage of the content is decaying. This should encourage to don't excessively buffer basic items, but create production lines, which uses the material on the fly. Some buffering is always necessary, f.e. for train stations, but it's a consideration, how small this buffer can be.

### Summary
Basic goods like ores, plates, wood, fish, plastic, batteries, uranium are decaying with invidual rate per hour. This can be configured in the settings.\
For each decayed item, it is removed from the chest and/or pollution is emitted, which is also configurable

### Commands
There are some command line commands:\
/spice_rack_item_statistics - displays a statistics about items and how much already decayed\
/spice_rack_active_containers - displays all containers (chests)\
/spice_rack_rebuild_containers - rebuild the containers structure, if necessary

### Technical background
The mods keeps track over all placed containers and investigates the content. For the amount of each decayable item, an integer decay is calculated and the items get removed from container and/or pollution is emitted. Since decay is sometimes very slow, the decayed fraction per item is carried along to the next calculation of that item.\
\
To ensure performance, the containers are handled not all at once, but they are distributed over a timespan of ~ 2 min. . When a container is added, it's assign to an alternating slot. One slot is handled each interval of 10 ticks (configurable). The amount of slots is a prime value: 719 (configurable). 7190 ticks ~ 2 min.

### Options
Emitted pollution per decayed item - How much pollution is emitted per decayed item (0 is none)\
Destroy decayed items from chest - Whether decayed items are actually destroyed\
Decay % <item>- Max. decay rate percent per hour (less than 48 stacks in chest means lower decay rate)\
\
Expert: Slot count for containers - Expert: More slots are useful for large amount of containers to increase performance. Must be a prime\
Expert: Interval in ticks - Expert: Bigger intervals enlarge the turnaround time (slots * interval). Can be increased to improve performance.
Debug mode for decaying goods - 0=off, 1=errors only, 2=errors and warning, 3=additional infos, 4=additional debug logs

## The Spice Rack - Time display
Simple Time display similar to playtime mod by thuejk. (Credits to thuejk for looking up code)


## The Spice Rack - Core
Core functions for Spice Rack
