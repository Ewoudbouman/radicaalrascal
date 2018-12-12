package com.peters.michael.clonefinder2000

import android.content.Context
import com.peters.michael.clonefinder2000.data.ResourcesProjectRepository
import com.peters.michael.clonefinder2000.domain.data.ProjectRepository
import dagger.Module
import dagger.Provides

@Module
class CloneFinderModule {

    @Provides
    fun provideApplicationContext(application: CloneFinderApplication): Context = application

    @Provides
    fun provideProjectRepository(resourcesProjectRepository: ResourcesProjectRepository): ProjectRepository =
        resourcesProjectRepository
}
