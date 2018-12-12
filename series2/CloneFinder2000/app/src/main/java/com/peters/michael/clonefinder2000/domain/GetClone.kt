package com.peters.michael.clonefinder2000.domain

import com.peters.michael.clonefinder2000.domain.data.ProjectRepository
import com.peters.michael.clonefinder2000.domain.model.Clone
import io.reactivex.Single
import javax.inject.Inject

/**
 * Gets the clone for the given id
 */
class GetClone @Inject constructor(private val projectRepository: ProjectRepository) {

    operator fun invoke(projectId: String, cloneId: String): Single<Clone> {
        return projectRepository.fetchClone(projectId, cloneId)
    }
}