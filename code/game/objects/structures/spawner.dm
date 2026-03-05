/obj/structure/spawner
	name = "monster nest"
	icon = 'icons/roguetown/misc/structure.dmi'
	icon_state = "shitportal"
	max_integrity = 500

	move_resist = MOVE_FORCE_EXTREMELY_STRONG
	anchored = TRUE
	density = FALSE

	var/max_mobs = 5
	var/spawn_time = 300 //30 seconds default
	var/mob_types = list(/mob/living/simple_animal/hostile/retaliate/bigrat)
	var/spawn_text = "emerges from"
	var/faction = list("hostile")
	var/spawner_type = /datum/component/spawner
	var/wait = FALSE

/obj/structure/spawner/wait
	wait = TRUE

/obj/structure/spawner/wait/goblin
	mob_types = list(/mob/living/carbon/human/species/goblin/npc/cave, /mob/living/carbon/human/species/goblin/npc/sea, /mob/living/carbon/human/species/goblin/npc/moon, /mob/living/carbon/human/species/goblin/npc/hell)
	max_mobs = 3

/obj/structure/spawner/wait/skeleton
	mob_types = list(/mob/living/carbon/human/species/skeleton/npc/peasant, /mob/living/carbon/human/species/skeleton/npc/warrior)
	max_mobs = 3

/obj/structure/spawner/Initialize()
	. = ..()
	if(!wait)
		AddComponent(spawner_type, mob_types, spawn_time, faction, spawn_text, max_mobs)

/obj/structure/spawner/proc/set_spawner()
	AddComponent(spawner_type, mob_types, spawn_time, faction, spawn_text, max_mobs)

/obj/structure/spawner/attack_animal(mob/living/simple_animal/M)
	if(faction_check(faction, M.faction, FALSE)&&!M.client)
		return
	..()
<<<<<<< HEAD


/obj/structure/spawner/syndicate // TO DO obsolete
	name = "warp beacon"
	icon = 'icons/obj/device.dmi'
	icon_state = "syndbeacon"
	faction = list(ROLE_SYNDICATE)

/obj/structure/spawner/skeleton // TO DO obsolete
	name = "bone pit"
	desc = ""
	icon_state = "hole"
	icon = 'icons/mob/nest.dmi'
	max_integrity = 150
	max_mobs = 15
	spawn_time = 150
//	mob_types =
	spawn_text = "climbs out of"
	faction = list("skeleton")

/obj/structure/spawner/clown
	name = "Laughing Larry"
	desc = ""
	icon_state = "clownbeacon"
	icon = 'icons/obj/device.dmi'
	max_integrity = 200
	max_mobs = 15
	spawn_time = 150
	mob_types = list(/mob/living/simple_animal/hostile/retaliate/clown, /mob/living/simple_animal/hostile/retaliate/clown/fleshclown, /mob/living/simple_animal/hostile/retaliate/clown/clownhulk, /mob/living/simple_animal/hostile/retaliate/clown/longface, /mob/living/simple_animal/hostile/retaliate/clown/clownhulk/chlown, /mob/living/simple_animal/hostile/retaliate/clown/clownhulk/honcmunculus, /mob/living/simple_animal/hostile/retaliate/clown/mutant/blob, /mob/living/simple_animal/hostile/retaliate/clown/banana, /mob/living/simple_animal/hostile/retaliate/clown/honkling, /mob/living/simple_animal/hostile/retaliate/clown/lube)
	spawn_text = "climbs out of"
	faction = list("clown")

/obj/structure/spawner/mining
	name = "monster den"
	desc = ""
	icon_state = "hole"
	max_integrity = 200
	max_mobs = 3
	icon = 'icons/mob/nest.dmi'
	spawn_text = "crawls out of"
	mob_types = list(/mob/living/simple_animal/hostile/asteroid/goldgrub, /mob/living/simple_animal/hostile/asteroid/goliath, /mob/living/simple_animal/hostile/asteroid/hivelord, /mob/living/simple_animal/hostile/asteroid/basilisk, /mob/living/simple_animal/hostile/asteroid/fugu)
	faction = list("mining")

/obj/structure/spawner/mining/goldgrub
	name = "goldgrub den"
	desc = ""
	mob_types = list(/mob/living/simple_animal/hostile/asteroid/goldgrub)

/obj/structure/spawner/mining/goliath
	name = "goliath den"
	desc = ""
	mob_types = list(/mob/living/simple_animal/hostile/asteroid/goliath)

/obj/structure/spawner/mining/hivelord
	name = "hivelord den"
	desc = ""
	mob_types = list(/mob/living/simple_animal/hostile/asteroid/hivelord)

/obj/structure/spawner/mining/basilisk
	name = "basilisk den"
	desc = ""
	mob_types = list(/mob/living/simple_animal/hostile/asteroid/basilisk)

/obj/structure/spawner/mining/wumborian
	name = "wumborian fugu den"
	desc = ""
	mob_types = list(/mob/living/simple_animal/hostile/asteroid/fugu)
=======
>>>>>>> upstream/main
