package com.peters.michael.clonefinder2000.domain

import com.peters.michael.clonefinder2000.domain.data.ProjectRepository
import com.peters.michael.clonefinder2000.domain.CloneType.CloneDetails
import com.peters.michael.clonefinder2000.domain.CloneType.ProjectDetails
import io.reactivex.Single
import javax.inject.Inject

class GetProjectDetails @Inject constructor(private val projectRepository: ProjectRepository) {

    operator fun invoke(id: String): Single<ProjectDetails> {
        return projectRepository.fetchProjectDetails(id)
                .map {
                    it.copy(
                            type1 = sortCloneDetails(it.type1),
                            type2 = sortCloneDetails(it.type2),
                            type3 = sortCloneDetails(it.type3)
                    )
                }
    }

    private fun sortCloneDetails(cloneDetails: CloneDetails): CloneDetails {
        return cloneDetails.copy(cloneClasses = cloneDetails.cloneClasses.sortedByDescending { it.percentageOfProject })
    }
}