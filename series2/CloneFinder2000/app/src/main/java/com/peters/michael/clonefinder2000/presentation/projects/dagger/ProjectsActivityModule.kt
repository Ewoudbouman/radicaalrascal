package com.peters.michael.clonefinder2000.presentation.projects.dagger

import com.peters.michael.clonefinder2000.presentation.projects.ProjectsActivity
import com.peters.michael.clonefinder2000.presentation.projects.ProjectsContract
import com.peters.michael.clonefinder2000.presentation.projects.ProjectsPresenter
import dagger.Binds
import dagger.Module
import dagger.android.ContributesAndroidInjector

@Module
abstract class ProjectsActivityModule {

    @ContributesAndroidInjector(modules = [Bindings::class])
    abstract fun projectsActivity(): ProjectsActivity

    @Module
    interface Bindings {

        @Binds
        fun bindView(projectsActivity: ProjectsActivity): ProjectsContract.View

        @Binds
        fun bindNavigator(projectsActivity: ProjectsActivity): ProjectsContract.Navigator

        @Binds
        fun bindPresenter(projectsPresenter: ProjectsPresenter): ProjectsContract.Presenter
    }
}