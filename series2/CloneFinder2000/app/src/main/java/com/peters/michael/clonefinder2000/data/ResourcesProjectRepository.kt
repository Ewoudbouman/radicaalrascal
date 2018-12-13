package com.peters.michael.clonefinder2000.data

import android.content.Context
import com.google.gson.Gson
import com.peters.michael.clonefinder2000.data.model.ProjectDetailsResource
import com.peters.michael.clonefinder2000.domain.CloneType.*
import com.peters.michael.clonefinder2000.domain.data.ProjectRepository
import com.peters.michael.clonefinder2000.domain.model.Clone
import io.reactivex.Single
import javax.inject.Inject
import javax.inject.Singleton

/**
 * Implementation of the [ProjectRepository] that uses local resources to fetch data
 */
@Singleton
class ResourcesProjectRepository @Inject constructor(private val context: Context) : ProjectRepository {

    private val gson: Gson by lazy { Gson() }

    private val projectMap: HashMap<String, ProjectDetailsResource> = hashMapOf()

    override fun fetchProjects(): Single<List<Project>> {
        return Single.fromCallable {
            listOf(
                Project(
                    TEST_DUP_PROJECT_ID,
                    TEST_DUP_PROJECT_ID,
                    readProjectDetails(TEST_DUP_PROJECT_ID + TYPE_1_POSTFIX).totalLOC
                ),
                Project(
                    SMALL_SQL_PROJECT_ID,
                    SMALL_SQL_PROJECT_ID,
                    readProjectDetails(SMALL_SQL_PROJECT_ID + TYPE_1_POSTFIX).totalLOC
                )
            )
        }
    }

    override fun fetchProjectDetails(id: String): Single<ProjectDetails> {
        return Single.fromCallable {
            val type1 = readProjectDetails(id + TYPE_1_POSTFIX)
            val type2 = readProjectDetails(id + TYPE_2_POSTFIX)
            val type3 = readProjectDetails(id + TYPE_3_POSTFIX)

            ProjectDetails(
                project = Project(id, id, type1.totalLOC),
                type1 = mapToCloneDetails(type1),
                type2 = mapToCloneDetails(type2),
                type3 = mapToCloneDetails(type3)
            )
        }
    }

    private fun readProjectDetails(path: String): ProjectDetailsResource {
        return projectMap.getOrElse(path) {
            val json: String = context.assets.open(path).let {
                val buffer = ByteArray(it.available())
                it.read(buffer)
                it.close()
                String(buffer)
            }
            gson.fromJson(json, ProjectDetailsResource::class.java).also {
                projectMap[path] = it
            }
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
        return Single.fromCallable {
            context.assets.open(projectId + cloneTypeToTypePostfix(cloneType)).let {
                val buffer = ByteArray(it.available())
                it.read(buffer)
                it.close()
                String(buffer)
            }
        }
    }

    override fun fetchClone(projectId: String, cloneId: String): Single<Clone> {
        return fetchProjectDetails(projectId)
            .map {
                (it.type1.cloneClasses + it.type2.cloneClasses + it.type3.cloneClasses)
                    .flatMap { it.clones }
                    .first { it.id == cloneId }
            }
    }

    private fun cloneTypeToTypePostfix(cloneType: CloneType): String {
        return when (cloneType) {
            CloneType.TYPE_1 -> TYPE_1_POSTFIX
            CloneType.TYPE_2 -> TYPE_2_POSTFIX
            CloneType.TYPE_3 -> TYPE_3_POSTFIX
        }
    }

    companion object {

        private const val TEST_DUP_PROJECT_ID = "testDUP"
        private const val SMALL_SQL_PROJECT_ID = "smallSQL"
        private const val H_SQL_PROJECT_ID = "HSQLDB"
        private const val TYPE_1_POSTFIX = "_type1.json"
        private const val TYPE_2_POSTFIX = "_type2.json"
        private const val TYPE_3_POSTFIX = "_type3.json"
    }
}