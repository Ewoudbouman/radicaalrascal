package com.peters.michael.clonefinder2000.presentation.projectdetails.dagger

import com.peters.michael.clonefinder2000.presentation.projectdetails.ProjectDetailsActivity
import com.peters.michael.clonefinder2000.presentation.projectdetails.ProjectDetailsContract
import com.peters.michael.clonefinder2000.presentation.projectdetails.ProjectDetailsPresenter
import dagger.Binds
import dagger.Module
import dagger.android.ContributesAndroidInjector

@Module
abstract class ProjectDetailsActivityModule {

    @ContributesAndroidInjector(modules = [Bindings::class])
    abstract fun projectDetailsActivity(): ProjectDetailsActivity

    @Module
    interface Bindings {

        @Binds
        fun bindView(projectDetailsActivity: ProjectDetailsActivity): ProjectDetailsContract.View

        @Binds
        fun bindPresenter(projectDetailsPresenter: ProjectDetailsPresenter): ProjectDetailsContract.Presenter

        @Binds
        fun bindNavigator(projectDetailsActivity: ProjectDetailsActivity): ProjectDetailsContract.Navigator
    }
}