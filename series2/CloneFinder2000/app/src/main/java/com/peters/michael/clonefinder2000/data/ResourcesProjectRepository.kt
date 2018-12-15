package com.peters.michael.clonefinder2000.data

import android.content.Context
import com.google.gson.Gson
import com.peters.michael.clonefinder2000.data.model.ProjectDetailsResource
import com.peters.michael.clonefinder2000.domain.CloneType.*
import com.peters.michael.clonefinder2000.domain.data.ProjectRepository
import com.peters.michael.clonefinder2000.domain.model.Clone
import io.reactivex.Observable
import io.reactivex.Single
import io.reactivex.rxkotlin.Singles
import javax.inject.Inject
import javax.inject.Singleton

/**
 * Implementation of the [ProjectRepository] that uses local resources to fetch data
 */
@Singleton
class ResourcesProjectRepository @Inject constructor(private val context: Context,
                                                     private val projectService: ProjectService) : ProjectRepository {

    private val projectMap: HashMap<String, ProjectDetails> = hashMapOf()

    override fun fetchProjects(): Single<List<Project>> {
        projectMap.clear()
        return projectService.getProjects()
                .flatMap { Observable.fromIterable(it) }
                .flatMapSingle { fetchProjectDetails(it) }
                .toList()
                .doOnEvent { list, _ ->
                    list.forEach {
                        projectMap.put(it.project.id, it)
                    }
                }
                .map { it.map { Project(it.project.id, it.project.name, it.project.sloc) } }
    }

    override fun fetchProjectDetails(id: String): Single<ProjectDetails> {
        return projectMap[id]?.let {
            Single.just(it)
        } ?: Singles.zip(
                projectService.getProject(id, 1),
                projectService.getProject(id, 2),
                projectService.getProject(id, 3))
        { t1, t2, t3 ->
            ProjectDetails(
                    project = Project(id, id, t1.totalLOC),
                    type1 = mapToCloneDetails(t1),
                    type2 = mapToCloneDetails(t2),
                    type3 = mapToCloneDetails(t3)
            )
        }
    }

    private fun mapToCloneDetails(projectDetailsResource: ProjectDetailsResource): CloneDetails {
        return CloneDetails(
                duplicatePercentage = projectDetailsResource.duplicatesPercentage,
                duplicateSloc = projectDetailsResource.duplicatesLOC,
                cloneClasses = projectDetailsResource.cloneClasses.map { cloneClass ->
                    CloneClass(
                            id = cloneClass.prefixedId,
                            loc = cloneClass.LOC,
                            percentageOfProject = cloneClass.percentageOfProject,
                            clones = cloneClass.clones.map {
                                Clone(
                                        id = it.prefixedId,
                                        percentageOfProject = it.attributes.percentageOfProject,
                                        fileName = it.attributes.file,
                                        path = it.attributes.path,
                                        percentageOfClass = it.attributes.percentageOfClass,
                                        sloc = it.attributes.LOC,
                                        startLine = it.attributes.startLine,
                                        endLine = it.attributes.endLine,
                                        clonedCode = it.attributes.clone,
                                        source = projectDetailsResource.fullSources
                                                .first { source -> source.path == it.attributes.path }.source,
                                        parentClassId = cloneClass.prefixedId
                                )
                            })
                }
        )
    }

    override fun fetchProjectData(projectId: String, cloneType: CloneType): Single<String> {
        return when (cloneType) {
            CloneType.TYPE_1 -> projectService.getProjectData(projectId, 1)
            CloneType.TYPE_2 -> projectService.getProjectData(projectId, 2)
            CloneType.TYPE_3 -> projectService.getProjectData(projectId, 3)
        }.map { it.string() }
    }

    override fun fetchClone(projectId: String, cloneId: String): Single<Clone> {
        return fetchProjectDetails(projectId)
                .map {
                    (it.type1.cloneClasses + it.type2.cloneClasses + it.type3.cloneClasses)
                            .flatMap { it.clones }
                            .first { it.id == cloneId }
                }
    }
}