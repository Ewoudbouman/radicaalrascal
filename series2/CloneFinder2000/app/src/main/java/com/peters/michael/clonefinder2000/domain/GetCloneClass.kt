package com.peters.michael.clonefinder2000.domain

import com.peters.michael.clonefinder2000.domain.data.ProjectRepository
import com.peters.michael.clonefinder2000.domain.CloneType.CloneClass
import io.reactivex.Single
import javax.inject.Inject

/**
 * Gets the clone class for the given id
 */
class GetCloneClass @Inject constructor(private val projectRepository: ProjectRepository) {

    operator fun invoke(projectId: String, classId: String): Single<CloneClass> {
        return projectRepository.fetchProjectDetails(projectId)
            .map {
                (it.type1.cloneClasses + it.type2.cloneClasses + it.type3.cloneClasses)
                    .first { cc -> cc.id == classId }
            }
    }
}