package com.peters.michael.clonefinder2000.domain.CloneType

import com.peters.michael.clonefinder2000.domain.model.Clone

data class CloneClass(

    val id: String,
    val loc: Long,
    val percentageOfProject: Float,
    val clones: List<Clone>
)