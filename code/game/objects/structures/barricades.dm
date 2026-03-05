<<<<<<< HEAD
#define SINGLE "single"
#define VERTICAL "vertical"
#define HORIZONTAL "horizontal"

#define METAL 1
#define WOOD 2
#define SAND 3

=======
>>>>>>> upstream/main
//Barricades/cover

/obj/structure/barricade
	name = "chest high wall"
<<<<<<< HEAD
	desc = ""
=======
>>>>>>> upstream/main
	anchored = TRUE
	density = TRUE
	max_integrity = 100
	var/proj_pass_rate = 50 //How many projectiles will pass the cover. Lower means stronger cover
<<<<<<< HEAD
	var/bar_material = METAL
=======
>>>>>>> upstream/main

/obj/structure/barricade/deconstruct(disassembled = TRUE)
	if(!(flags_1 & NODECONSTRUCT_1))
		make_debris()
	qdel(src)

/obj/structure/barricade/proc/make_debris()
	return

<<<<<<< HEAD
/obj/structure/barricade/attackby(obj/item/I, mob/user, params)
	if(I.tool_behaviour == TOOL_WELDER && user.used_intent.type != INTENT_HARM && bar_material == METAL)
		if(obj_integrity < max_integrity)
			if(!I.tool_start_check(user, amount=0))
				return

			to_chat(user, "<span class='notice'>I begin repairing [src]...</span>")
			if(I.use_tool(src, user, 40, volume=40))
				obj_integrity = CLAMP(obj_integrity + 20, 0, max_integrity)
	else
		return ..()

/obj/structure/barricade/CanPass(atom/movable/mover, turf/target)//So bullets will fly over and stuff.
	if(locate(/obj/structure/barricade) in get_turf(mover))
		return 1
	else if(istype(mover, /obj/projectile))
		if(!anchored)
			return 1
		var/obj/projectile/proj = mover
		if(proj.firer && Adjacent(proj.firer))
			return 1
		if(prob(proj_pass_rate))
			return 1
		return 0
	else
		return !density


=======
/obj/structure/barricade/CanAllowThrough(atom/movable/mover, turf/target)//So bullets will fly over and stuff.
	. = ..()
	if(locate(/obj/structure/barricade) in get_turf(mover))
		return TRUE
	else if(istype(mover, /obj/projectile))
		if(!anchored)
			return TRUE
		var/obj/projectile/proj = mover
		if(proj.firer && Adjacent(proj.firer))
			return TRUE
		if(prob(proj_pass_rate))
			return TRUE
		return FALSE
>>>>>>> upstream/main

/////BARRICADE TYPES///////

/obj/structure/barricade/wooden
	name = "wooden barricade"
<<<<<<< HEAD
	desc = ""
	icon = 'icons/obj/structures.dmi'
	icon_state = "woodenbarricade"
	bar_material = WOOD
	var/drop_amount = 3

/obj/structure/barricade/wooden/rogue
	name = "wooden barricade"
	desc = ""
	icon = 'icons/roguetown/misc/structure.dmi'
	icon_state = "woodenbarricade_r"
	max_integrity = 60
	bar_material = WOOD
	drop_amount = 0

/obj/structure/barricade/wooden/rogue/crude
	name = "crude plank barricade"
	icon = 'icons/roguetown/misc/structure.dmi'
	icon_state = "woodenbarricade_r2"
	max_integrity = 40

/obj/structure/barricade/wooden/attackby(obj/item/I, mob/user)
	if(istype(I,/obj/item/stack/sheet/mineral/wood))
		var/obj/item/stack/sheet/mineral/wood/W = I
		if(W.amount < 5)
			to_chat(user, "<span class='warning'>I need at least five wooden planks to make a wall!</span>")
			return
		else
			to_chat(user, "<span class='notice'>I start adding [I] to [src]...</span>")
			if(do_after(user, 50, target=src))
				W.use(5)
				var/turf/T = get_turf(src)
				T.PlaceOnTop(/turf/closed/wall/mineral/wood/nonmetal)
				qdel(src)
				return
	return ..()


/obj/structure/barricade/wooden/crude
	name = "crude plank barricade"
	desc = ""
	icon_state = "woodenbarricade-old"
	drop_amount = 1
	max_integrity = 50
	proj_pass_rate = 65

/obj/structure/barricade/wooden/crude/snow
	desc = ""
	icon_state = "woodenbarricade-snow-old"
	max_integrity = 75

/obj/structure/barricade/wooden/make_debris()
	new /obj/item/stack/sheet/mineral/wood(get_turf(src), drop_amount)

#undef SINGLE
#undef VERTICAL
#undef HORIZONTAL

#undef METAL
#undef WOOD
#undef SAND
=======
	icon = 'icons/obj/structures/barricade.dmi'
	icon_state = "barricade_wood"
	/// Amount of wood planks to drop
	var/drop_amount = 2

/obj/structure/barricade/wooden/make_debris()
	new /obj/effect/decal/cleanable/debris/wood(get_turf(src))
	for(var/i in 1 to drop_amount)
		new /obj/item/natural/wood/plank(get_turf(src))

/obj/structure/barricade/wooden/crude
	name = "plank barricade"
	icon_state = "barricade_wood_plank"
	max_integrity = 60
	drop_amount = 1
>>>>>>> upstream/main
