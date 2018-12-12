package com.peters.michael.clonefinder2000.domain.CloneType

data class ProjectDetails(

        val project: Project,
        val type1: CloneDetails,
        val type2: CloneDetails,
        val type3: CloneDetails
)