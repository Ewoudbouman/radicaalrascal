package com.peters.michael.clonefinder2000.domain.model

import com.peters.michael.clonefinder2000.domain.CloneType.CloneClass

data class CloneDetails(

        val duplicatePercentage: Float,
        val duplicateSloc: Long,
        val cloneClasses: List<CloneClass>
) {

    val cloneClassCount = cloneClasses.count()
    val cloneCount = cloneClasses.flatMap { it.clones }.count()
}