/mob/living/brain/death(gibbed)
	if(stat == DEAD)
		return
<<<<<<< HEAD
	stat = DEAD
=======
	set_stat(DEAD)
>>>>>>> upstream/main

	return ..()

/mob/living/brain/gib()
	if(loc)
		if(istype(loc, /obj/item/organ/brain))
			qdel(loc)//Gets rid of the brain item
	..()
