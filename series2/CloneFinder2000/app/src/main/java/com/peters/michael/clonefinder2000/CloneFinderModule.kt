package com.peters.michael.clonefinder2000

import android.content.Context
import com.peters.michael.clonefinder2000.data.ProjectService
import com.peters.michael.clonefinder2000.data.ResourcesProjectRepository
import com.peters.michael.clonefinder2000.domain.data.ProjectRepository
import dagger.Module
import dagger.Provides
import okhttp3.OkHttpClient
import retrofit2.Retrofit
import retrofit2.adapter.rxjava2.RxJava2CallAdapterFactory
import retrofit2.converter.gson.GsonConverterFactory

@Module
class CloneFinderModule {

    @Provides
    fun provideApplicationContext(application: CloneFinderApplication): Context = application

    @Provides
    fun provideProjectRepository(resourcesProjectRepository: ResourcesProjectRepository): ProjectRepository =
        resourcesProjectRepository

    @Provides
    fun provideProjectService() : ProjectService {
        return Retrofit.Builder()
            .baseUrl("https://ewoudbouman.github.io/radicaalrascal/series2/series2clonefinder/output/")
            .addCallAdapterFactory(RxJava2CallAdapterFactory.create())
            .addConverterFactory(GsonConverterFactory.create())
            .client(OkHttpClient.Builder().build())
            .build()
            .create(ProjectService::class.java)
    }
}
