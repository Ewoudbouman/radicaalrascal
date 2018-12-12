package com.peters.michael.clonefinder2000.domain.model

data class CloneDetails(

        val duplicatePercentage: Float,
        val duplicateSloc: Long,
        val cloneClasses: List<CloneClass>
) {

    val cloneClassCount = cloneClasses.count()
    val cloneCount = cloneClasses.flatMap { it.clones }.count()
}