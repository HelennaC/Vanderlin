/mob/living/simple_animal/pet
	icon = 'icons/roguetown/mob/monster/pets.dmi'
	mob_size = MOB_SIZE_SMALL
	mob_biotypes = MOB_ORGANIC|MOB_BEAST
	blood_volume = BLOOD_VOLUME_NORMAL
	var/unique_pet = FALSE // if the mob can be renamed
	density = FALSE
	//pass_flags = PASSTABLE
	response_help_continuous = "pets"
	response_help_simple = "pet"
	response_disarm_continuous = "gently pushes aside"
	response_disarm_simple = "gently push aside"
	response_harm_continuous = "kicks"
	response_harm_simple = "kick"

<<<<<<< HEAD
/mob/living/simple_animal/pet/handle_atom_del(atom/A)
	if(A == pcollar)
		pcollar = null
	return ..()

/mob/living/simple_animal/pet/proc/add_collar(obj/item/clothing/neck/petcollar/P, mob/user)
	if(QDELETED(P) || pcollar)
		return
	if(!user.transferItemToLoc(P, src))
		return
	pcollar = P
	regenerate_icons()
	to_chat(user, "<span class='notice'>I put the [P] around [src]'s neck.</span>")
	if(P.tagname && !unique_pet)
		fully_replace_character_name(null, "\proper [P.tagname]")

/mob/living/simple_animal/pet/attackby(obj/item/O, mob/user, params)
	if(istype(O, /obj/item/clothing/neck/petcollar) && !pcollar)
		add_collar(O, user)
		return
	else
		..()

/mob/living/simple_animal/pet/Initialize()
	. = ..()
	if(pcollar)
		pcollar = new(src)
		regenerate_icons()

/mob/living/simple_animal/pet/Destroy()
	QDEL_NULL(pcollar)
	return ..()

/mob/living/simple_animal/pet/revive(full_heal = FALSE, admin_revive = FALSE)
	. = ..()
	if(.)
		if(collar_type)
			collar_type = "[initial(collar_type)]"
		regenerate_icons()

/mob/living/simple_animal/pet/death(gibbed)
	..(gibbed)
	if(collar_type)
		collar_type = "[initial(collar_type)]_dead"
	regenerate_icons()

/mob/living/simple_animal/pet/gib()
	if(pcollar)
		pcollar.forceMove(drop_location())
		pcollar = null
	..()

/mob/living/simple_animal/pet/regenerate_icons()
	cut_overlays()
	if(pcollar && collar_type)
		add_overlay("[collar_type]collar")
		add_overlay("[collar_type]tag")
=======
/mob/living/simple_animal/pet/giraffe
	name = "Giraffe Automaton"
	desc = "An experimental automaton imported from Heartfelt, the pinnacle of creation. She's simply adorable. Everybody loves her."
	icon_state = "gg"
	icon_living = "gg"
	icon_dead = "gg_dead"
	gender = FEMALE
	base_strength = 3
	base_endurance = 4
	base_speed = 3
	base_constitution = 3
	mob_biotypes = MOB_ROBOTIC
	footstep_type = FOOTSTEP_MOB_CLAW
	unique_pet = TRUE
	speak = list("Psschh", "A-a-a-a")
	speak_emote = list("lets out a hiss of steam", "coos")
	emote_hear = list("hums a peculiar tune.", "clinks.")
	emote_see = list("shakes its head.", "does a little happy dance.")
	speak_chance = 1
	botched_butcher_results = list(/obj/item/ore/iron = 1)
	butcher_results = list(/obj/item/ore/iron = 1, /obj/item/ingot/tin = 1)
	perfect_butcher_results = list(/obj/item/ingot/tin = 1, /obj/item/ingot/iron = 1)
>>>>>>> upstream/main
