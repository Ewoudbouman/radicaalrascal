package com.peters.michael.clonefinder2000.domain.model

import com.peters.michael.clonefinder2000.domain.CloneType.CloneDetails
import com.peters.michael.clonefinder2000.domain.CloneType.Project

data class ProjectDetails(

        val project: Project,
        val type1: CloneDetails,
        val type2: CloneDetails,
        val type3: CloneDetails
)