package com.peters.michael.clonefinder2000.domain.data

import com.peters.michael.clonefinder2000.domain.CloneType.CloneType
import com.peters.michael.clonefinder2000.domain.CloneType.Project
import com.peters.michael.clonefinder2000.domain.CloneType.ProjectDetails
import com.peters.michael.clonefinder2000.domain.model.Clone
import io.reactivex.Single

interface ProjectRepository {

    fun fetchProjects(): Single<List<Project>>
    fun fetchProjectDetails(id: String): Single<ProjectDetails>
    fun fetchProjectData(projectId: String, cloneType: CloneType): Single<String>
    fun fetchClone(projectId: String, cloneId: String): Single<Clone>
}