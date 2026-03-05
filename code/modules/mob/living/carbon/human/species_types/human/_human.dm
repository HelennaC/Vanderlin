/datum/species/human
	name = "Humanb"
<<<<<<< HEAD:code/modules/mob/living/carbon/human/species_types/roguetown/human/_human.dm
	id = "human"
	changesource_flags = MIRROR_BADMIN | WABBAJACK | MIRROR_MAGIC | MIRROR_PRIDE | RACE_SWAP | SLIME_EXTRACT
=======
	id = SPEC_ID_HUMEN
	changesource_flags = WABBAJACK
	bodypart_features = list(
		/datum/bodypart_feature/hair/head,
		/datum/bodypart_feature/hair/facial,
	)
>>>>>>> upstream/main:code/modules/mob/living/carbon/human/species_types/human/_human.dm

/datum/species/human/check_roundstart_eligible()
	return FALSE

/datum/species/human/on_species_gain(mob/living/carbon/C, datum/species/old_species)
	. = ..()
	RegisterSignal(C, COMSIG_MOB_SAY, PROC_REF(handle_speech))
	C.grant_language(/datum/language/common)

/datum/species/human/on_species_loss(mob/living/carbon/C)
	. = ..()
	UnregisterSignal(C, COMSIG_MOB_SAY)
	C.remove_language(/datum/language/common)

/datum/species/human/qualifies_for_rank(rank, list/features)
	return TRUE	//Pure humans are always allowed in all roles.
