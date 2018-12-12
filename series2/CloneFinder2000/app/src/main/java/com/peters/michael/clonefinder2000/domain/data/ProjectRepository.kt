package com.peters.michael.clonefinder2000.domain.data

import com.peters.michael.clonefinder2000.domain.model.Clone
import com.peters.michael.clonefinder2000.domain.model.Project
import com.peters.michael.clonefinder2000.domain.model.ProjectDetails
import io.reactivex.Single

interface ProjectRepository {

    fun fetchProjects(): Single<List<Project>>
    fun fetchProjectDetails(id: String): Single<ProjectDetails>
    fun fetchClone(projectId: String, cloneId: String) : Single<Clone>
}