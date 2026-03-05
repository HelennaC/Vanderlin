/mob/living/carbon/human/species/elf
	race = /datum/species/elf

/datum/species/elf
	name = "Elfb"
<<<<<<< HEAD:code/modules/mob/living/carbon/human/species_types/roguetown/elf/_elf.dm
	id = "elf"
	max_age = 850
	changesource_flags = MIRROR_BADMIN | WABBAJACK | MIRROR_MAGIC | MIRROR_PRIDE | RACE_SWAP | SLIME_EXTRACT
=======
	id = SPEC_ID_ELF
	changesource_flags = WABBAJACK
	native_language = "Elfish"
	exotic_bloodtype = /datum/blood_type/human/elf
	bodypart_features = list(
		/datum/bodypart_feature/hair/head,
		/datum/bodypart_feature/hair/facial,
	)
>>>>>>> upstream/main:code/modules/mob/living/carbon/human/species_types/elf/_elf.dm

/datum/species/elf/on_species_gain(mob/living/carbon/C, datum/species/old_species)
	..()
	RegisterSignal(C, COMSIG_MOB_SAY, PROC_REF(handle_speech))
	C.grant_language(/datum/language/common)
	C.grant_language(/datum/language/elvish)

/datum/species/elf/check_roundstart_eligible()
	return FALSE

/datum/species/elf/after_creation(mob/living/carbon/C)
	..()
	C.dna.species.accent_language = C.dna.species.get_accent(native_language, 1)
	C.grant_language(/datum/language/elvish)
	to_chat(C, "<span class='info'>I can speak Elfish with ,e before my speech.</span>")

/datum/species/elf/on_species_loss(mob/living/carbon/C)
	. = ..()
	UnregisterSignal(C, COMSIG_MOB_SAY)
	C.remove_language(/datum/language/elvish)

/datum/species/elf/qualifies_for_rank(rank, list/features)
	return TRUE
