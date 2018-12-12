package com.peters.michael.clonefinder2000.domain

import com.peters.michael.clonefinder2000.domain.CloneType.CloneType
import com.peters.michael.clonefinder2000.domain.data.ProjectRepository
import com.peters.michael.clonefinder2000.domain.CloneType.Project
import io.reactivex.Single
import javax.inject.Inject

/**
 * Gets the raw data of a project
 */
class GetRawProjectData @Inject constructor(private val projectRepository: ProjectRepository) {

    operator fun invoke(projectId: String, cloneType: CloneType): Single<String> {
        return projectRepository.fetchProjectData(projectId, cloneType)
    }
}