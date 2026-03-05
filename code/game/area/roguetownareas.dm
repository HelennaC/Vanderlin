/area
	name = "roguetown"
	icon_state = "rogue"

/area/indoors
	name = "indoors rt"
	icon_state = "indoors"
	droning_index = DRONING_INDOORS
	ambient_index = AMBIENCE_GENERIC
	background_track = 'sound/music/area/indoor.ogg'
	background_track_dusk = 'sound/music/area/septimus.ogg'
	background_track_night = 'sound/music/area/sleeping.ogg'
	plane = INDOOR_PLANE
	converted_type = /area/outdoors

/area/indoors/cave
	name = "latejoin cave"
	icon_state = "cave"
	droning_index = DRONING_CAVE_GENERIC
	soundenv = 8

/area/indoors/cave/late/can_craft_here()
	return FALSE

///// OUTDOORS AREAS //////

/area/outdoors
	name = "outdoors roguetown"
	icon_state = "outdoors"
	outdoors = TRUE
<<<<<<< HEAD
	ambientrain = RAIN_OUT
//	ambientsounds = list('sound/ambience/wamb.ogg')
	ambientsounds = AMB_TOWNDAY
	ambientnight = AMB_TOWNNIGHT
	spookysounds = SPOOKY_CROWS
	spookynight = SPOOKY_GEN
	droning_sound = 'sound/music/area/townstreets.ogg'
	droning_sound_dusk = 'sound/ambience/kaizoku/Diaspora.ogg'
	droning_sound_night = 'sound/music/area/sleeping.ogg'
	converted_type = /area/rogue/indoors/shelter
=======
	droning_index = DRONING_TOWN_DAY
	droning_index_night = DRONING_TOWN_NIGHT
	ambient_index = AMBIENCE_BIRDS
	ambient_index_night = AMBIENCE_GENERIC
	background_track = 'sound/music/area/townstreets.ogg'
	background_track_dusk = 'sound/music/area/septimus.ogg'
	background_track_night = 'sound/music/area/sleeping.ogg'
	converted_type = /area/indoors/shelter
>>>>>>> upstream/main

/area/indoors/shelter
	icon_state = "shelter"
<<<<<<< HEAD
	droning_sound = 'sound/ambience/kaizoku/Zephyr.ogg'
	droning_sound_dusk = 'sound/music/area/septimus.ogg'
	droning_sound_night = 'sound/ambience/kaizoku/Sanctumocean.ogg'
=======
	background_track = 'sound/music/area/townstreets.ogg'
	background_track_dusk = 'sound/music/area/septimus.ogg'
	background_track_night = 'sound/music/area/sleeping.ogg'
>>>>>>> upstream/main

/area/outdoors/mountains
	name = "mountains"
	icon_state = "mountains"
<<<<<<< HEAD
	ambientsounds = AMB_MOUNTAIN
	ambientnight = AMB_MOUNTAIN
	spookysounds = SPOOKY_GEN
	spookynight = SPOOKY_GEN
	droning_sound = 'sound/ambience/kaizoku/Zephyr.ogg'
	droning_sound_dusk = 'sound/music/area/septimus.ogg'
	droning_sound_night = 'sound/ambience/kaizoku/Sanctumocean.ogg'
=======
	droning_index = DRONING_MOUNTAIN
	ambient_index = AMBIENCE_GENERIC
	background_track = 'sound/music/area/townstreets.ogg'
	background_track_dusk = 'sound/music/area/septimus.ogg'
	background_track_night = 'sound/music/area/sleeping.ogg'
>>>>>>> upstream/main
	soundenv = 17
	converted_type = /area/indoors/shelter/mountains

/area/indoors/shelter/mountains
	icon_state = "mountains"
<<<<<<< HEAD
	droning_sound = 'sound/ambience/kaizoku/Zephyr.ogg'
	droning_sound_dusk = 'sound/music/area/septimus.ogg'
	droning_sound_night = 'sound/ambience/kaizoku/Sanctumocean.ogg'
=======
	background_track = 'sound/music/area/townstreets.ogg'
	background_track_dusk = 'sound/music/area/septimus.ogg'
	background_track_night = 'sound/music/area/sleeping.ogg'
>>>>>>> upstream/main

/area/outdoors/mountains/deception
	name = "deception"
	icon_state = "deception"
	first_time_text = "THE CANYON OF DECEPTION"
	ambush_types = list(
<<<<<<< HEAD
				/turf/open/floor/rogue/dirt)
	ambush_mobs = list(
				/mob/living/simple_animal/hostile/retaliate/rogue/troll = 20,
				/mob/living/carbon/human/species/skeleton/skilled/fighter = 15,
				/mob/living/carbon/human/species/goblin/skilled/ambush/hell = 50)
=======
				/turf/open/floor/dirt)
	ambush_mobs = list(
				new /datum/ambush_config/pair_of_direbear = 10,
				new /datum/ambush_config/trio_of_highwaymen = 10,
				new /datum/ambush_config/singular_minotaur = 10,
				new /datum/ambush_config/duo_minotaur = 5,
				new /datum/ambush_config/solo_treasure_hunter = 15,
				new /datum/ambush_config/duo_treasure_hunter = 2,
				new /datum/ambush_config/medium_skeleton_party = 10,
				new /datum/ambush_config/heavy_skeleton_party = 5,
				)
	threat_region = THREAT_REGION_MOUNT_DECAP
>>>>>>> upstream/main

/area/outdoors/mountains/decap
	name = "mt decapitation"
	icon_state = "decap"
	ambush_types = list(
				/turf/open/floor/dirt)
	ambush_mobs = list(
<<<<<<< HEAD
				/mob/living/simple_animal/hostile/retaliate/rogue/troll = 15,
				/mob/living/carbon/human/species/skeleton/skilled/unarmed = 25,
				/mob/living/carbon/human/species/skeleton/skilled/fighter = 25)
	droning_sound = 'sound/music/area/decap.ogg'
	droning_sound_dusk = null
	droning_sound_night = null
	first_time_text = "MOUNT DECAPITATION"
=======
				new /datum/ambush_config/pair_of_direbear = 10,
				new /datum/ambush_config/trio_of_highwaymen = 10,
				new /datum/ambush_config/singular_minotaur = 10,
				new /datum/ambush_config/duo_minotaur = 5,
				new /datum/ambush_config/solo_treasure_hunter = 15,
				new /datum/ambush_config/duo_treasure_hunter = 2,
				new /datum/ambush_config/medium_skeleton_party = 10,
				new /datum/ambush_config/heavy_skeleton_party = 5,
				)
	background_track = 'sound/music/area/decap.ogg'
	background_track_dusk = null
	background_track_night = null
	first_time_text = "MALUMS ANVIL"
	custom_area_sound = 'sound/misc/stings/MalumSting.ogg'
>>>>>>> upstream/main
	ambush_times = list("night","dawn","dusk","day")

	converted_type = /area/indoors/shelter/mountains/decap
	threat_region = THREAT_REGION_MOUNT_DECAP

/area/indoors/shelter/mountains/decap
	icon_state = "decap"
	background_track = 'sound/music/area/decap.ogg'
	background_track_dusk = null
	background_track_night = null
	threat_region = THREAT_REGION_MOUNT_DECAP

/area/outdoors/basin
	name = "town basin"
	icon_state = "basin"
	soundenv = 19
	ambush_times = list("night","dawn","dusk","day")
	ambush_types = list(
				/turf/open/floor/grass)
	ambush_mobs = list(
<<<<<<< HEAD
				/mob/living/simple_animal/hostile/retaliate/rogue/wolf = 60,
				/mob/living/carbon/human/species/goblin/skilled/ambush = 10)
	first_time_text = "ROCKHILL BASIN"
	droning_sound = 'sound/music/area/field.ogg'
	droning_sound_dusk = 'sound/music/area/septimus.ogg'
	droning_sound_night = 'sound/music/area/sleeping.ogg'
	converted_type = /area/rogue/indoors/shelter/rtfield

/area/rogue/outdoors/rtfield/hamlet
	name = "hamlet surroundings"
	ambush_times = list("night","dusk")
	ambush_types = list(
				/turf/open/floor/rogue/grass/peril)
	ambush_mobs = list(
				/mob/living/simple_animal/hostile/retaliate/rogue/wolf = 60,
				/mob/living/carbon/human/species/goblin/skilled/ambush = 5,
				/mob/living/simple_animal/pet/cat/rogue/cabbit = 10)
	first_time_text = "STONEHILL VALLEY"

/area/rogue/outdoors/rtfield/hamlet/unsafe	// just so there isnt unusable ambush spots placed in safe areas causing annoying screenshake but no effect

/area/rogue/outdoors/rtfield/plague_district
	ambush_mobs = list(/mob/living/carbon/human/species/human/northern/bum/skilled/madman = 50, /mob/living/simple_animal/hostile/rogue/skeleton = 50)
	first_time_text = "PLAGUE DISTRICT"
	color = "#d4da75"
	name = "plague district"
	ambush_types = list(
				/turf/open/floor/rogue/cobblerock)

/area/rogue/outdoors/rtfield/outlaw
	ambush_mobs = list(/mob/living/carbon/human/species/human/northern/bum/skilled/outlaw = 50)
	name = "outlaw hideout"
	color = "#e9baa3"
	first_time_text = null

/area/rogue/outdoors/rtfield/boggish
	ambush_mobs = list(/mob/living/carbon/human/species/goblin/skilled/ambush/sea = 50)
	name = "bog approaches"
	color = "#7db36e"
	first_time_text = null

/area/rogue/outdoors/rtfield/woodish
	ambush_mobs = list(/mob/living/simple_animal/hostile/retaliate/rogue/wolf = 50)
	name = "woods approaches"
	color = "#7db36e"
	first_time_text = null

/area/rogue/outdoors/rtfield/spooky		// haunts ambush and dug down hidden treasure
	ambush_mobs = list(/mob/living/simple_animal/hostile/rogue/haunt = 50)
	name = "spooky place"
	color = "#9294d3"
	first_time_text = null

/area/rogue/indoors/shelter/rtfield
	icon_state = "rtfield"
	droning_sound = 'sound/music/area/field.ogg'
	droning_sound_dusk = 'sound/music/area/septimus.ogg'
	droning_sound_night = 'sound/music/area/sleeping.ogg'
=======
				/mob/living/simple_animal/hostile/retaliate/wolf = 60,
				/mob/living/carbon/human/species/goblin/npc/ambush/hell = 50,
				/mob/living/carbon/human/species/goblin/npc/ambush/sea = 50,
				/mob/living/carbon/human/species/goblin/npc/ambush = 50)
	background_track = 'sound/music/area/field.ogg'
	background_track_dusk = 'sound/music/area/septimus.ogg'
	background_track_night = 'sound/music/area/sleeping.ogg'
	converted_type = /area/indoors/shelter/basin
	threat_region = THREAT_REGION_MOUNT_DECAP

/area/outdoors/basin/Initialize()
	. = ..()
	first_time_text = "[uppertext(SSmapping.config.map_name)] BASIN"
>>>>>>> upstream/main

/area/outdoors/basin/safe
	icon_state = "basin_safe"
	ambush_mobs = null

/area/indoors/shelter/basin
	icon_state = "basin"
	background_track = 'sound/music/area/field.ogg'
	background_track_dusk = 'sound/music/area/septimus.ogg'
	background_track_night = 'sound/music/area/sleeping.ogg'
	threat_region = THREAT_REGION_MOUNT_DECAP

/area/indoors/shelter/woods
	icon_state = "woods"
<<<<<<< HEAD
	ambientsounds = AMB_FORESTDAY
	ambientnight = AMB_FORESTNIGHT
	spookysounds = SPOOKY_CROWS
	spookynight = SPOOKY_FOREST
	droning_sound = 'sound/ambience/kaizoku/Sibilant.ogg'
	droning_sound_dusk = 'sound/ambience/kaizoku/Penumbra.ogg'
	droning_sound_night = 'sound/ambience/kaizoku/Sibilant_night.ogg'
	soundenv = 15
	ambush_times = list("night","dawn","dusk","day")
	ambush_types = list(
				/turf/open/floor/rogue/grass)
	ambush_mobs = list(
				/mob/living/simple_animal/hostile/retaliate/rogue/wolf = 60,
				/mob/living/simple_animal/hostile/retaliate/rogue/troll = 5,
				/mob/living/carbon/human/species/goblin/skilled/ambush = 20,
				/mob/living/simple_animal/hostile/retaliate/rogue/mole = 10)
	first_time_text = "THE MURDERWOOD"
	converted_type = /area/rogue/indoors/shelter/woods

/area/rogue/indoors/shelter/woods
	icon_state = "woods"
	droning_sound = 'sound/ambience/kaizoku/Sussurus.ogg'
	droning_sound_dusk = 'sound/ambience/kaizoku/Diaspora.ogg'
	droning_sound_night = 'sound/ambience/kaizoku/Sibilant_night.ogg'

/area/rogue/outdoors/woods_safe
=======
	background_track = 'sound/music/area/forest.ogg'
	background_track_dusk = 'sound/music/area/septimus.ogg'
	background_track_night = 'sound/music/area/forestnight.ogg'

/area/outdoors/woods_safe
>>>>>>> upstream/main
	name = "woods"
	icon_state = "woods"
	droning_index = DRONING_FOREST_DAY
	droning_index_night = DRONING_FOREST_NIGHT
	ambient_index = AMBIENCE_BIRDS
	ambient_index_night = AMBIENCE_FOREST
	background_track = 'sound/music/area/forest.ogg'
	background_track_dusk = 'sound/music/area/septimus.ogg'
	background_track_night = 'sound/music/area/forestnight.ogg'
	soundenv = 15
	converted_type = /area/indoors/shelter/woods

<<<<<<< HEAD
/area/rogue/outdoors/woods/haunted
	ambush_types = list(
				/turf/open/floor/rogue/grass)
	ambush_mobs = list(
				/mob/living/simple_animal/hostile/retaliate/rogue/wolf = 20,
				/mob/living/simple_animal/hostile/retaliate/rogue/spider/colony = 10,
				/mob/living/simple_animal/hostile/rogue/haunt = 5,
				/mob/living/simple_animal/hostile/rogue/skeleton/axe = 10,
				/mob/living/simple_animal/hostile/rogue/skeleton/bow = 5,
				/mob/living/simple_animal/hostile/rogue/skeleton/spear = 5,
				/mob/living/simple_animal/hostile/retaliate/rogue/mole = 5)
	first_time_text = "THE HAUNTED FOREST"
	converted_type = /area/rogue/indoors/shelter/woods

/area/rogue/outdoors/river
	name = "river"
	icon_state = "river"
	ambientsounds = AMB_RIVERDAY
	ambientnight = AMB_RIVERNIGHT
	spookysounds = SPOOKY_FROG
	spookynight = SPOOKY_FOREST
	droning_sound = 'sound/ambience/kaizoku/Abyssanctum.ogg'
	droning_sound_dusk = 'sound/ambience/kaizoku/kaizoku.ogg'
	droning_sound_night = 'sound/ambience/kaizoku/Abyssariad.ogg'
	converted_type = /area/rogue/indoors/shelter/woods
=======
/area/outdoors/river
	name = "river"
	icon_state = "river"
	droning_index = DRONING_RIVER_DAY
	droning_index_night = DRONING_RIVER_NIGHT
	ambient_index = AMBIENCE_FROG
	ambient_index_night = AMBIENCE_FOREST
	background_track = 'sound/music/area/forest.ogg'
	background_track_dusk = 'sound/music/area/septimus.ogg'
	background_track_night = 'sound/music/area/forestnight.ogg'
	converted_type = /area/indoors/shelter/woods
>>>>>>> upstream/main

/area/outdoors/bog
	name = "the bog"
	icon_state = "bog"
	droning_index = DRONING_BOG_DAY
	droning_index_night = DRONING_BOG_NIGHT
	ambient_index = AMBIENCE_FROG
	ambient_index_night = AMBIENCE_GENERIC
	background_track = 'sound/music/area/bog.ogg'
	background_track_dusk = null
	background_track_night = null
	ambush_times = list("night","dawn","dusk","day")
	ambush_types = list(
				/turf/open/floor/dirt,
				/turf/open/water)
	ambush_mobs = list(
<<<<<<< HEAD
				/mob/living/simple_animal/hostile/retaliate/rogue/bigrat = 20,
				/mob/living/simple_animal/hostile/retaliate/rogue/spider = 80,
				/mob/living/carbon/human/species/goblin/skilled/ambush/sea = 20,
				/mob/living/simple_animal/hostile/retaliate/rogue/trollbog = 30)
=======
				/mob/living/simple_animal/hostile/retaliate/bigrat = 20,
				/mob/living/simple_animal/hostile/retaliate/spider = 80,
				/mob/living/carbon/human/species/goblin/npc/ambush/sea = 50,
				/mob/living/simple_animal/hostile/retaliate/troll/bog = 35,
				new /datum/ambush_config/bog_guard_deserters = 50,
				new /datum/ambush_config/bog_guard_deserters/hard = 25,
				new /datum/ambush_config/mirespiders_ambush = 110,
				new /datum/ambush_config/mirespiders_crawlers = 25,
				new /datum/ambush_config/mirespiders_aragn = 10,
				new /datum/ambush_config/mirespiders_unfair = 5)
>>>>>>> upstream/main

	first_time_text = "THE TERRORBOG"
	custom_area_sound = 'sound/misc/stings/BogSting.ogg'
	converted_type = /area/indoors/shelter/bog
	threat_region = THREAT_REGION_TERRORBOG

/area/indoors/shelter/bog
	icon_state = "bog"
	background_track = 'sound/music/area/bog.ogg'
	background_track_dusk = null
	background_track_night = null

/area/outdoors/beach
	name = "sophia's cry"
	icon_state = "beach"
<<<<<<< HEAD
	ambientsounds = AMB_BEACH
	ambientnight = AMB_BEACH
	droning_sound = 'sound/ambience/kaizoku/Oceansanct.ogg'
	droning_sound_dusk = 'sound/ambience/kaizoku/Town_in_Rogue.ogg'
	droning_sound_night = 'sound/ambience/kaizoku/Defenestration.ogg'
=======
	droning_index = DRONING_LAKE
	background_track = 'sound/music/area/townstreets.ogg'
	background_track_dusk = 'sound/music/area/septimus.ogg'
	background_track_night = 'sound/music/area/sleeping.ogg'
>>>>>>> upstream/main

	ambush_mobs = list(
		/mob/living/carbon/human/species/goblin/npc/ambush/sea = 20,
		new /datum/ambush_config/triple_deepone = 30,
		new /datum/ambush_config/deepone_party = 20,
	)

	threat_region = THREAT_REGION_COAST

/area/outdoors/eora
	name = "eoran grove"
	icon_state = "eora"
	droning_index = DRONING_FOREST_DAY
	background_track = 'sound/music/area/eora.ogg'
	background_track_dusk =  'sound/music/area/eora.ogg'
	background_track_night = 'sound/music/area/eora.ogg'

//// UNDER AREAS (no indoor rain sound usually)

// these don't get a rain sound because they're underground
/area/under
	name = "basement"
	icon_state = "under"
<<<<<<< HEAD
	droning_sound = 'sound/ambience/kaizoku/Oceansanct.ogg'
	droning_sound_dusk = 'sound/ambience/kaizoku/Town_in_Rogue.ogg'
	droning_sound_night = 'sound/ambience/kaizoku/Defenestration.ogg'
=======
	background_track = 'sound/music/area/towngen.ogg'
	background_track_dusk = 'sound/music/area/septimus.ogg'
	background_track_night = 'sound/music/area/sleeping.ogg'
>>>>>>> upstream/main
	soundenv = 8
	plane = INDOOR_PLANE
	converted_type = /area/outdoors/exposed

/area/outdoors/exposed
	icon_state = "exposed"
<<<<<<< HEAD
	droning_sound = 'sound/ambience/kaizoku/Oceansanct.ogg'
	droning_sound_dusk = 'sound/ambience/kaizoku/Town_in_Rogue.ogg'
	droning_sound_night = 'sound/ambience/kaizoku/Defenestration.ogg'
=======
	background_track = 'sound/music/area/towngen.ogg'
	background_track_dusk = 'sound/music/area/septimus.ogg'
	background_track_night = 'sound/music/area/sleeping.ogg'
>>>>>>> upstream/main

/area/under/cave
	name = "cave"
	icon_state = "cave"
<<<<<<< HEAD
	ambientsounds = AMB_GENCAVE
	ambientnight = AMB_GENCAVE
	spookysounds = SPOOKY_CAVE
	spookynight = SPOOKY_CAVE
	droning_sound = 'sound/ambience/kaizoku/Torment.ogg'
	droning_sound_dusk = 'sound/ambience/kaizoku/Bucolic.ogg'
	droning_sound_night = 'sound/ambience/kaizoku/Nebula.ogg'
=======
	droning_index = DRONING_CAVE_GENERIC
	ambient_index = AMBIENCE_CAVE
	background_track = 'sound/music/area/caves.ogg'
	background_track_dusk = null
	background_track_night = null
>>>>>>> upstream/main
	ambush_times = list("night","dawn","dusk","day")
	ambush_types = list(
				/turf/open/floor/dirt)
	ambush_mobs = list(
<<<<<<< HEAD
				/mob/living/simple_animal/hostile/retaliate/rogue/bigrat = 30,
				/mob/living/carbon/human/species/goblin/skilled/ambush/cave = 20,
				/mob/living/carbon/human/species/skeleton/skilled/unarmed = 5,
				/mob/living/carbon/human/species/skeleton/skilled/fighter = 5)
	converted_type = /area/rogue/outdoors/caves
=======
				/mob/living/simple_animal/hostile/retaliate/bigrat = 30,
				/mob/living/carbon/human/species/goblin/npc/ambush/cave = 20,
				/mob/living/carbon/human/species/skeleton/npc/ambush = 10)
	converted_type = /area/outdoors/caves
>>>>>>> upstream/main

/area/outdoors/caves
	icon_state = "caves"
<<<<<<< HEAD
	droning_sound = 'sound/ambience/kaizoku/Torment.ogg'
	droning_sound_dusk = 'sound/ambience/kaizoku/Bucolic.ogg'
	droning_sound_night = 'sound/ambience/kaizoku/Nebula.ogg'

/area/rogue/under/town/caverogue/saltmine
	name = "salt mine"
	first_time_text = "Salt Mine"
=======
	background_track = 'sound/music/area/caves.ogg'
	background_track_dusk = null
	background_track_night = null
>>>>>>> upstream/main

/area/under/cavewet
	name = "cavewet"
	icon_state = "cavewet"
<<<<<<< HEAD
	first_time_text = "The Undersea"
	ambientsounds = AMB_CAVEWATER
	ambientnight = AMB_CAVEWATER
	spookysounds = SPOOKY_CAVE
	spookynight = SPOOKY_CAVE
	droning_sound = 'sound/music/area/caves.ogg'
	droning_sound_dusk = 'sound/ambience/kaizoku/Bucolic.ogg'
	droning_sound_night = 'sound/ambience/kaizoku/Nebula.ogg'
=======
	droning_index = DRONING_CAVE_WET
	ambient_index = AMBIENCE_CAVE
	background_track = 'sound/music/area/caves.ogg'
	background_track_dusk = null
	background_track_night = null
>>>>>>> upstream/main
	ambush_times = list("night","dawn","dusk","day")
	ambush_types = list(
				/turf/open/floor/dirt)
	ambush_mobs = list(
<<<<<<< HEAD
				/mob/living/carbon/human/species/skeleton/skilled/unarmed = 5,
				/mob/living/carbon/human/species/skeleton/skilled/fighter = 5,
				/mob/living/simple_animal/hostile/retaliate/rogue/bigrat = 30,
				/mob/living/carbon/human/species/goblin/skilled/ambush/sea = 20)
	converted_type = /area/rogue/outdoors/caves

/area/rogue/under/cave/abandoned_mine
	name = "abandoned mine"
	first_time_text = "Abandoned Mine"
	ambush_types = list(
				/turf/open/floor/rogue/dirt)
	ambush_mobs = list(
				/mob/living/simple_animal/hostile/retaliate/rogue/bigrat = 30,
				/mob/living/carbon/human/species/goblin/skilled/ambush/cave = 20)

/area/rogue/under/cave/spider
=======
				/mob/living/carbon/human/species/skeleton/npc/ambush = 10,
				/mob/living/simple_animal/hostile/retaliate/bigrat = 30,
				/mob/living/carbon/human/species/goblin/npc/sea = 20)
	converted_type = /area/outdoors/caves

/area/under/cave/spider
>>>>>>> upstream/main
	icon_state = "spider"
	first_time_text = "ARAIGNÉE"
	ambush_mobs = list(
				/mob/living/simple_animal/hostile/retaliate/spider = 100)
	background_track = 'sound/music/area/spidercave.ogg'
	background_track_dusk = null
	background_track_night = null
	converted_type = /area/outdoors/spidercave

<<<<<<< HEAD
/area/rogue/under/catacombs
	name = "catacombs"
	icon_state = "cavewet"
	first_time_text = "The Catacombs"
	ambientsounds = AMB_CAVEWATER
	ambientnight = AMB_CAVEWATER
	spookysounds = SPOOKY_CAVE
	spookynight = SPOOKY_CAVE
	droning_sound = 'sound/music/area/caves.ogg'
	droning_sound_dusk = 'sound/ambience/kaizoku/Bucolic.ogg'
	droning_sound_night = 'sound/ambience/kaizoku/Nebula.ogg'
	ambush_times = list("night","dawn","dusk","day")
	ambush_types = list(
				/turf/open/water/swamp)
	ambush_mobs = list(
				/mob/living/carbon/human/species/skeleton/skilled/unarmed = 30,
				/mob/living/simple_animal/hostile/retaliate/rogue/bigrat = 10)
	converted_type = /area/rogue/outdoors/caves

/area/rogue/under/catacombs/dwarfoutpost
	name = "underrock outpost"
	first_time_text = "Underrock Outpost"
	ambush_types = list(
				/turf/open/water/swamp)
	ambush_mobs = list(
				/mob/living/simple_animal/hostile/retaliate/rogue/lamia = 30,
				/mob/living/simple_animal/hostile/retaliate/rogue/headless = 20)

/area/rogue/under/catacombs/dwarfoutpost/orcy
	ambush_types = list(
				/turf/open/floor/rogue/blocks/newstone/alt)
	ambush_mobs = list(
				/mob/living/carbon/human/species/orc/skilled/savage = 50)

/area/rogue/outdoors/spidercave
=======
/area/outdoors/spidercave
>>>>>>> upstream/main
	icon_state = "spidercave"
	background_track = 'sound/music/area/spidercave.ogg'
	background_track_dusk = null
	background_track_night = null

/area/under/spiderbase
	name = "spiderbase"
	droning_index = DRONING_BASEMENT
	droning_index_night = DRONING_BASEMENT
	icon_state = "spiderbase"
	background_track = 'sound/music/area/spidercave.ogg'
	background_track_dusk = null
	background_track_night = null
	converted_type = /area/outdoors/spidercave

/area/outdoors/spidercave
	icon_state = "spidercave"
	background_track = 'sound/music/area/spidercave.ogg'
	background_track_dusk = null
	background_track_night = null

/area/under/cavelava
	name = "cavelava"
	icon_state = "cavelava"
	first_time_text = "MALUM'S ARTERY"
	droning_index = DRONING_CAVE_LAVA
	ambient_index = AMBIENCE_CAVE
	ambush_times = list("night","dawn","dusk","day")
	ambush_types = list(
				/turf/open/floor/dirt)
	ambush_mobs = list(
				/mob/living/simple_animal/hostile/retaliate/bigrat = 30,
				/mob/living/carbon/human/species/skeleton/npc/ambush = 10,
<<<<<<< HEAD
				/mob/living/carbon/human/species/goblin/skilled/ambush/cave = 20)
	droning_sound = 'sound/music/area/decap.ogg'
	droning_sound_dusk = null
	droning_sound_night = null
	converted_type = /area/rogue/outdoors/exposed/decap
=======
				/mob/living/carbon/human/species/goblin/npc/hell = 20)
	background_track = 'sound/music/area/decap.ogg'
	background_track_dusk = null
	background_track_night = null
	converted_type = /area/outdoors/exposed/decap
>>>>>>> upstream/main

/area/under/cavelava/acid
	name = "cavelava"
	icon_state = "cavelava"
	first_time_text = null
	ambush_types = null
	converted_type = null

/area/outdoors/exposed/decap
	icon_state = "decap"
	background_track = 'sound/music/area/decap.ogg'
	background_track_dusk = null
	background_track_night = null

/area/under/lake
	name = "underground lake"
	icon_state = "lake"
	droning_index = DRONING_LAKE
	ambient_index = AMBIENCE_CAVE
	ambient_index_night = AMBIENCE_GENERIC

<<<<<<< HEAD


///// TOWN AREAS //////

/area/rogue/indoors/town
	name = "indoors"
	icon_state = "blueold"
	droning_sound = 'sound/ambience/kaizoku/Zephyr.ogg'
	droning_sound_dusk = 'sound/music/area/septimus.ogg'
	droning_sound_night = 'sound/ambience/kaizoku/Sanctumocean.ogg'
	converted_type = /area/rogue/outdoors/exposed/town

/area/rogue/outdoors/exposed/town
	icon_state = "town"
	droning_sound = 'sound/music/area/towngen.ogg'
	droning_sound_dusk = null
//	droning_sound_night = 'sound/music/area/night.ogg'

/area/rogue/outdoors/exposed/town/hamlet
	icon_state = "town"
	droning_sound = 'sound/ambience/kaizoku/Oceansanct.ogg'
	droning_sound_dusk = null
	first_time_text = "STONEHILL HAMLET"

/area/rogue/indoors/town/manor
	name = "Manor"
	icon_state = "manor"
	droning_sound = 'sound/music/area/manor.ogg'
	droning_sound_dusk = 'sound/music/area/manor2.ogg'
	droning_sound_night = 'sound/music/area/manor2.ogg'
	converted_type = /area/rogue/outdoors/exposed/manorgarri
	first_time_text = "THE KEEP OF ROCKHILL"

/area/rogue/indoors/town/manor/hamlet
	first_time_text = "STONEHILL CASTLE"

/area/rogue/outdoors/exposed/manorgarri
	icon_state = "manorgarri"
	droning_sound = 'sound/music/area/manor.ogg'
	droning_sound_dusk = null
	droning_sound_night = null

/area/rogue/indoors/town/magician
	name = "Wizard's Tower"
	icon_state = "magician"
	spookysounds = SPOOKY_MYSTICAL
	spookynight = SPOOKY_MYSTICAL
	droning_sound = 'sound/music/area/magiciantower.ogg'
	droning_sound_dusk = null
	droning_sound_night = null
	converted_type = /area/rogue/outdoors/exposed/magiciantower

/area/rogue/outdoors/exposed/magiciantower
	icon_state = "magiciantower"
	droning_sound = 'sound/music/area/magiciantower.ogg'
	droning_sound_dusk = null
	droning_sound_night = null

/area/rogue/indoors/town/shop
	name = "Shop"
	icon_state = "shop"
	droning_sound = 'sound/music/area/shop.ogg'
	droning_sound_dusk = null
	droning_sound_night = null
	converted_type = /area/rogue/outdoors/exposed/shop

/area/rogue/outdoors/exposed/shop
	icon_state = "shop"
	droning_sound = 'sound/music/area/shop.ogg'

/area/rogue/indoors/town/bath
	name = "Baths"
	icon_state = "bath"
	droning_sound = 'sound/music/area/bath.ogg'
	droning_sound_dusk = null
	droning_sound_night = null
	converted_type = /area/rogue/outdoors/exposed/bath
/area/rogue/indoors/town/bath/redhouse
	droning_sound = 'modular/Mapping/sound/Fulminate.ogg'
	converted_type = /area/rogue/outdoors/exposed/bath/redhouse

/area/rogue/outdoors/exposed/bath
	icon_state = "bath"
	droning_sound = 'sound/music/area/bath.ogg'
/area/rogue/outdoors/exposed/bath/redhouse
	droning_sound = 'modular/Mapping/sound/Fulminate.ogg'


/area/rogue/indoors/town/garrison
	name = "Garrison"
	icon_state = "garrison"
	droning_sound = 'sound/music/area/manorgarri.ogg'
	droning_sound_dusk = null
	droning_sound_night = null
	droning_sound_dusk = null
	droning_sound_night = null
	converted_type = /area/rogue/outdoors/exposed/manorgarri

/area/rogue/indoors/town/cell
	name = "dungeon cell"
	icon_state = "cell"
	spookysounds = SPOOKY_DUNGEON
	spookynight = SPOOKY_DUNGEON
	droning_sound = 'sound/music/area/manorgarri.ogg'
	droning_sound_dusk = null
	droning_sound_night = null
	converted_type = /area/rogue/outdoors/exposed/manorgarri

/area/rogue/indoors/town/tavern
	name = "tavern"
	icon_state = "tavern"
	ambientsounds = AMB_INGEN
	ambientnight = AMB_INGEN
	droning_sound = 'sound/music/jukeboxes/tavern1.ogg'
	droning_sound_dusk = null
	droning_sound_night = 'sound/music/jukeboxes/tavern2.ogg'
	converted_type = /area/rogue/outdoors/exposed/tavern
/area/rogue/indoors/town/tavern/saiga
	droning_sound = 'modular/Mapping/sound/Folia1490.ogg'
	droning_sound_night = 'modular/Mapping/sound/LeTourdion.ogg'
	converted_type = /area/rogue/outdoors/exposed/tavern/saiga

/area/rogue/outdoors/exposed/tavern
	icon_state = "tavern"
	droning_sound = 'sound/music/jukeboxes/tavern1.ogg'
	droning_sound_dusk = null
	droning_sound_night = 'sound/music/jukeboxes/tavern2.ogg'
/area/rogue/outdoors/exposed/tavern/saiga
	droning_sound = 'modular/Mapping/sound/Folia1490.ogg'
	droning_sound_night = 'modular/Mapping/sound/LeTourdion.ogg'

/area/rogue/indoors/town/church
	name = "church"
	icon_state = "church"
	droning_sound = 'sound/music/area/church.ogg'
	droning_sound_dusk = 'sound/ambience/kaizoku/Syzygy.ogg'
	droning_sound_night = 'sound/ambience/kaizoku/Resplendent.ogg'
	converted_type = /area/rogue/outdoors/exposed/church

/area/rogue/outdoors/exposed/church
	icon_state = "church"
	droning_sound = 'sound/music/area/church.ogg'
	droning_sound_dusk = 'sound/ambience/kaizoku/Syzygy.ogg'
	droning_sound_night = 'sound/ambience/kaizoku/Resplendent.ogg'

/area/rogue/indoors/town/church/chapel
	icon_state = "chapel"
	first_time_text = "THE HOUSE OF THE TEN"

/area/rogue/indoors/town/fire_chamber
	name = "incinerator"
	icon_state = "fire_chamber"

/area/rogue/indoors/town/fire_chamber/can_craft_here()
	return FALSE

/area/rogue/indoors/town/warehouse
	name = "dock warehouse import"
	icon_state = "warehouse"

/area/rogue/indoors/town/warehouse/can_craft_here()
	return FALSE

/area/rogue/indoors/town/vault
	name = "vault"
	icon_state = "vault"

/area/rogue/indoors/town/vault/can_craft_here()
	return FALSE

/area/rogue/indoors/town/entrance
	first_time_text = "Roguetown"
	icon_state = "entrance"

/area/rogue/indoors/town/dwarfin
	name = "makers quarter"
	icon_state = "dwarfin"
	droning_sound = 'sound/music/area/dwarf.ogg'
	droning_sound_dusk = null
	droning_sound_night = null
	first_time_text = "The Makers' Quarter"
	converted_type = /area/rogue/outdoors/exposed/dwarf

/area/rogue/outdoors/exposed/dwarf
	icon_state = "dwarf"
	droning_sound = 'sound/music/area/dwarf.ogg'
	droning_sound_dusk = null
	droning_sound_night = null

/area/rogue/indoors/town/tailor
	name = "tailorshop"
	icon_state = "tavern"

// so you can teleport to the farm
/area/rogue/indoors/soilsons
	name = "soilsons"

/area/rogue/indoors/ship
	name = "the ship"
	ambientsounds = AMB_BEACH
	ambientnight = AMB_BEACH
	droning_sound = 'sound/music/area/townstreets.ogg'
	droning_sound_dusk = 'sound/ambience/kaizoku/Diaspora.ogg'
	droning_sound_night = 'sound/music/area/sleeping.ogg'
=======
/area/indoors/ship
	name = "the ship"
	droning_index = DRONING_LAKE
	droning_index_night = DRONING_LAKE
	background_track = 'sound/music/area/townstreets.ogg'
	background_track_dusk = 'sound/music/area/septimus.ogg'
	background_track_night = 'sound/music/area/night.ogg'
>>>>>>> upstream/main

/area/outdoors/coast
	name = "the coast"
<<<<<<< HEAD
	ambientsounds = AMB_BEACH
	ambientnight = AMB_BEACH
	droning_sound = 'sound/music/area/sargoth.ogg'
	droning_sound_dusk = 'sound/ambience/kaizoku/Diaspora.ogg'
	droning_sound_night = 'sound/ambience/kaizoku/Defenestration.ogg'

///// OUTDOORS AREAS (again, for some reason)

/area/rogue/outdoors/town
	name = "outdoors"
	icon_state = "town"
	droning_sound = 'sound/ambience/kaizoku/Rogue_in_town.ogg'
	droning_sound_dusk = 'sound/ambience/kaizoku/Diaspora.ogg'
	droning_sound_night = 'sound/ambience/kaizoku/Town_in_Rogue.ogg'
	converted_type = /area/rogue/indoors/shelter/town
	first_time_text = "THE TOWN OF ROCKHILL"

/area/rogue/indoors/shelter/town
	icon_state = "town"
	droning_sound = 'sound/ambience/kaizoku/Oceansanct.ogg'
	droning_sound_dusk = 'sound/music/area/septimus.ogg'
	droning_sound_night = 'sound/ambience/kaizoku/Defenestration.ogg'

/area/rogue/outdoors/town/sargoth
	name = "outdoors"
	icon_state = "sargoth"
	droning_sound = 'sound/music/area/sargoth.ogg'
	droning_sound_dusk = null
	converted_type = /area/rogue/indoors/shelter/town/sargoth

/area/rogue/indoors/shelter/town/sargoth
	icon_state = "sargoth"
	droning_sound = 'sound/music/area/sargoth.ogg'
	droning_sound_dusk = null
	droning_sound_night = null

/area/rogue/outdoors/town/roofs
	name = "roofs"
	icon_state = "roofs"
	ambientsounds = AMB_MOUNTAIN
	ambientnight = AMB_MOUNTAIN
	spookysounds = SPOOKY_GEN
	spookynight = SPOOKY_GEN
	droning_sound = 'sound/music/area/field.ogg'
	converted_type = /area/rogue/indoors/shelter/town/roofs

/area/rogue/indoors/shelter/town/roofs
	icon_state = "roofs"
	droning_sound = 'sound/music/area/field.ogg'
	droning_sound_dusk = 'sound/music/area/septimus.ogg'
	droning_sound_night = 'sound/music/area/sleeping.ogg'

/area/rogue/outdoors/town/dwarf
	name = "makers quarter"
	icon_state = "dwarf"
	droning_sound = 'sound/music/area/dwarf.ogg'
	droning_sound_dusk = null
	droning_sound_night = null
	first_time_text = "The Makers' Quarter"
	converted_type = /area/rogue/indoors/shelter/town/dwarf

/area/rogue/indoors/shelter/town/dwarf
	icon_state = "dwarf"
	droning_sound = 'sound/music/area/dwarf.ogg'
	droning_sound_dusk = null
	droning_sound_night = null

///// UNDERGROUND AREAS //////

/area/rogue/under/town
	name = "basement"
	icon_state = "town"
	droning_sound = 'sound/music/area/catacombs.ogg'
	droning_sound_dusk = null
	droning_sound_night = null
	converted_type = /area/rogue/outdoors/exposed/under/town

/area/rogue/outdoors/exposed/under/town
	icon_state = "town"
	droning_sound = 'sound/music/area/catacombs.ogg'
	droning_sound_dusk = null
	droning_sound_night = null

/area/rogue/under/town/sewer
	name = "sewer"
	icon_state = "sewer"
	ambientsounds = AMB_CAVEWATER
	ambientnight = AMB_CAVEWATER
	spookysounds = SPOOKY_RATS
	spookynight = SPOOKY_RATS
	droning_sound = 'sound/music/area/sewers.ogg'
	droning_sound_dusk = null
	droning_sound_night = null
	ambientrain = RAIN_SEWER
	converted_type = /area/rogue/outdoors/exposed/under/sewer

/area/rogue/outdoors/exposed/under/sewer
	icon_state = "sewer"
	droning_sound = 'sound/music/area/sewers.ogg'
	droning_sound_dusk = null
	droning_sound_night = null

/area/rogue/under/town/caverogue
	name = "miningcave (roguetown)"
	icon_state = "caverogue"
	ambientsounds = AMB_GENCAVE
	ambientnight = AMB_GENCAVE
	spookysounds = SPOOKY_CAVE
	spookynight = SPOOKY_CAVE
	droning_sound = 'sound/ambience/kaizoku/Bucolic.ogg'
	droning_sound_dusk = null
	droning_sound_night = null
	converted_type = /area/rogue/outdoors/exposed/under/caves

/area/rogue/outdoors/exposed/under/caves
	icon_state = "caves"
	droning_sound = 'sound/ambience/kaizoku/Nebula.ogg'
	droning_sound_dusk = null
	droning_sound_night = null

/area/rogue/under/town/basement
	name = "basement"
	icon_state = "basement"
	ambientsounds = AMB_BASEMENT
	ambientnight = AMB_BASEMENT
	spookysounds = SPOOKY_DUNGEON
	spookynight = SPOOKY_DUNGEON
	droning_sound = 'sound/music/area/catacombs.ogg'
	droning_sound_dusk = null
	droning_sound_night = null
	soundenv = 5
	converted_type = /area/rogue/outdoors/exposed/under/basement

/area/rogue/outdoors/exposed/under/basement
	icon_state = "basement"
	droning_sound = 'sound/music/area/catacombs.ogg'
	droning_sound_dusk = null
	droning_sound_night = null
=======
	droning_index = DRONING_LAKE
	droning_index_night = DRONING_LAKE
	background_track = 'sound/music/area/sargoth.ogg'
	background_track_dusk = 'sound/music/area/septimus.ogg'
	background_track_night = 'sound/music/area/sleeping.ogg'
>>>>>>> upstream/main


///// UNDERWORLD AREAS //////

/area/underworld
	name = "underworld"
	icon_state = "underworld"
<<<<<<< HEAD
	droning_sound = ('sound/ambience/kaizoku/Petrichor.ogg')
	droning_sound_dusk = null
	droning_sound_night = ('sound/ambience/kaizoku/Petrichor_night.ogg')
=======
	background_track = 'sound/music/area/underworlddrone.ogg'
	background_track_dusk = null
	background_track_night = null
>>>>>>> upstream/main
	first_time_text = "The Forest of Repentence"

/area/underworld/Entered(atom/movable/movable, oldloc)
	. = ..()
	if(!iscarbon(movable))
		return
	RegisterSignal(movable, COMSIG_CARBON_PRAY, PROC_REF(on_underworld_prayer))

/area/underworld/Exited(atom/movable/movable)
	. = ..()
	if(!iscarbon(movable))
		return
	UnregisterSignal(movable, COMSIG_CARBON_PRAY)

/area/underworld/proc/on_underworld_prayer(mob/living/carbon/damned, message)
	// Who do the underworld spirits pray to? Good question
	. |= CARBON_PRAY_CANCEL

	if(!damned || !message)
		return

	var/static/list/profane_words = list("zizo","cock","dick","fuck","shit","pussy","cuck","cunt","asshole")
	var/prayer = SANITIZE_HEAR_MESSAGE(message)

	for(var/profanity in profane_words)
		if(findtext(prayer, profanity))
			//put this idiot SOMEWHERE
			var/static/list/unsafe_turfs = list(
				/turf/open/floor/underworld/space,
				/turf/open/openspace,
			)

			var/static/list/turfs = list()
			if(!length(turfs)) //there are a lot of turfs, let's only do this once
				for(var/turf/turf in src)
					if(turf.density)
						continue
					if(is_type_in_list(turf, unsafe_turfs))
						continue
					turfs.Add(turf)

			var/turf/safe_turf = safepick(turfs)
			if(!safe_turf) //fuck
				return

			damned.forceMove(safe_turf)
			to_chat(damned, "<font color='yellow'>INSOLENT WRETCH, YOUR STRUGGLE CONTINUES</font>")
			return

	if(length(prayer) <= 15)
		to_chat(damned, span_danger("My prayer was kinda short..."))
		return

	if(findtext(prayer, damned.patron.name))
		damned.playsound_local(damned, 'sound/misc/notice (2).ogg', 100, FALSE)
		to_chat(damned, "<font color='yellow'>I, [damned.patron], have heard your prayer and yet cannot aid you.</font>")

///// DAKKATOWN AREAS //////

// Players should be fined for any damage they do to the Guild's property
/area/outdoors/beach/boat
	name = "sophia's cry"
<<<<<<< HEAD
	ambientsounds = AMB_BEACH
	ambientnight = AMB_BEACH
	droning_sound = 'sound/ambience/kaizoku/Zephyr.ogg'
	droning_sound_dusk = 'sound/music/area/septimus.ogg'
	droning_sound_night = 'sound/ambience/kaizoku/Sanctumocean.ogg'

// Players are penalized for entering the Guild Gaptain's quarters (FAFO)
/area/rogue/outdoors/beach/boat/captain
	name = "guild captain"
	ambientsounds = AMB_BEACH
	ambientnight = AMB_BEACH
	droning_sound = 'sound/ambience/kaizoku/Zephyr.ogg'
	droning_sound_dusk = 'sound/ambience/kaizoku/Diaspora.ogg'
	droning_sound_night = 'sound/ambience/kaizoku/Sanctumocean.ogg'

/area/rogue/indoors/town/theatre
	name = "theatre"
	icon_state = "manor"
	droning_sound = null
	droning_sound_dusk = null
	droning_sound_night = null
	converted_type = /area/rogue/outdoors/exposed/theatre

/area/rogue/outdoors/exposed/theatre
	name = "theatre"
	icon_state = "manor"
	droning_sound = null
	droning_sound_dusk = null
	droning_sound_night = null

/area/rogue/indoors/town/apothecary
	name = "apothecary"
	icon_state = "manor"
	droning_sound = null
	droning_sound_dusk = null
	droning_sound_night = null

/area/rogue/under/town/ruin
	name = "townruin"
	icon_state = "town"
	droning_sound = 'sound/music/area/catacombs.ogg'
	droning_sound_dusk = null
	droning_sound_night = null
=======
	droning_index = DRONING_LAKE
	droning_index_night = DRONING_LAKE
	background_track = 'sound/music/area/townstreets.ogg'
	background_track_dusk = 'sound/music/area/septimus.ogg'
	background_track_night = 'sound/music/area/sleeping.ogg'
>>>>>>> upstream/main


///// ANTAGONIST AREAS //////  - used on centcom so you can teleport there easily. Each antag area just gets one unique type, if its outdoor use generic indoors, vice versa, to avoid clutter in area list

/area/indoors/bandit_lair
	name = "lair (Bandits)"

/area/indoors/vampire_manor
	name = "lair (Vampire Lord)"

/area/outdoors/bog/inhumen_camp
	name = "lair (Inhumen)"
	background_track = 'sound/music/area/decap.ogg'
	first_time_text = "THE DEEP BOG"

<<<<<<< HEAD
/area/rogue/under/town/kaizoku
	name = "kaizoku isle"
	icon_state = "town"
	droning_sound = 'sound/ambience/kaizoku/Abyssanctum.ogg'
	droning_sound_dusk = 'sound/ambience/kaizoku/kaizoku.ogg'
	droning_sound_night = 'sound/ambience/kaizoku/Abyssariad.ogg'

=======
/area/indoors/lich
	name = "lair (Lich)"
	background_track = 'sound/music/area/churchnight.ogg'

/area/delver
	delver_restrictions = TRUE
	converted_type = /area/delver

/area/ship/topdeck
	name = "upperdeck"
	icon_state = "roofs"
	droning_index = DRONING_BOAT
	background_track = 'sound/music/area/topdeckdrone.ogg'
	background_track_dusk = null
	background_track_night = null
	first_time_text = "The Voyager"
	outdoors = TRUE

/area/ship/middeck
	name = "middeck"
	icon_state = "indoors"
	droning_index = DRONING_BOAT
	background_track = 'sound/music/area/topdeckdrone.ogg'
	background_track_dusk = null
	background_track_night = null
	first_time_text = "Waist Deck"

/area/ship/nobledeck
	name = "nobledeck"
	icon_state = "manor"
	droning_index = DRONING_BOAT
	background_track = 'sound/music/area/nobledeckdrone.ogg'
	background_track_dusk = null
	background_track_night = null

/area/ship/shipbrig
	name = "shipbrig"
	icon_state = "cell"
	droning_index = DRONING_BOAT
	background_track = 'sound/music/area/shipbrig.ogg'
	background_track_dusk = null
	background_track_night = null
	first_time_text = "The Brig"
>>>>>>> upstream/main
