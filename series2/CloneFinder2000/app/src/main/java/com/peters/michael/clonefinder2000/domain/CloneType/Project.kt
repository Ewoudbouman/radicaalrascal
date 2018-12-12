package com.peters.michael.clonefinder2000.domain.CloneType

/**
 * A project which could have been analysed by the clone finder 2000
 */
data class Project(

    val id: String,
    val name: String,
    val sloc: Long
)