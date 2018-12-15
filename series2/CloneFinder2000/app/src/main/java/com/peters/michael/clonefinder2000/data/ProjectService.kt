package com.peters.michael.clonefinder2000.data

import com.peters.michael.clonefinder2000.data.model.ProjectDetailsResource
import io.reactivex.Observable
import io.reactivex.Single
import okhttp3.ResponseBody
import retrofit2.http.GET
import retrofit2.http.Path

interface ProjectService {

    @GET("projects/")
    fun getProjects(): Observable<List<String>>

    @GET("{projectId}/{type}/")
    fun getProject(
            @Path("projectId") projectId: String,
            @Path("type") type: Int): Single<ProjectDetailsResource>

    @GET("{projectId}/{type}/")
    fun getProjectData(
            @Path("projectId") projectId: String,
            @Path("type") type: Int): Single<ResponseBody>
}