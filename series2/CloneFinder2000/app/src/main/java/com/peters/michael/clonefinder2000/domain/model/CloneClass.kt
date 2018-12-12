package com.peters.michael.clonefinder2000.domain.model

data class CloneClass(

    val id: String,
    val loc: Long,
    val percentageOfProject: Float,
    val clones: List<Clone>
)