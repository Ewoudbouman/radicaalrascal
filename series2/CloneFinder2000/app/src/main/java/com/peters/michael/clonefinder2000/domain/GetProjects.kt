package com.peters.michael.clonefinder2000.domain

import com.peters.michael.clonefinder2000.domain.data.ProjectRepository
import com.peters.michael.clonefinder2000.domain.CloneType.Project
import io.reactivex.Single
import javax.inject.Inject

/**
 * Gets all of the projects that are available for visualisation
 */
class GetProjects @Inject constructor(private val projectRepository: ProjectRepository) {

    operator fun invoke(): Single<List<Project>> {
        return projectRepository.fetchProjects()
                .map { it.sortedBy { project -> project.name } }
    }
}