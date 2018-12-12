package com.peters.michael.clonefinder2000

import com.peters.michael.clonefinder2000.presentation.classdetails.dagger.ClassDetailsActivityModule
import com.peters.michael.clonefinder2000.presentation.clonedetails.dagger.CloneDetailsActivityModule
import com.peters.michael.clonefinder2000.presentation.graph.dagger.GraphActivityModule
import com.peters.michael.clonefinder2000.presentation.projectdetails.dagger.ProjectDetailsActivityModule
import com.peters.michael.clonefinder2000.presentation.projects.dagger.ProjectsActivityModule
import dagger.Component
import dagger.android.AndroidInjector
import dagger.android.support.AndroidSupportInjectionModule
import javax.inject.Singleton

@Singleton
@Component(
        modules = [
            AndroidSupportInjectionModule::class,
            CloneFinderModule::class,
            ProjectsActivityModule::class,
            ProjectDetailsActivityModule::class,
            ClassDetailsActivityModule::class,
            CloneDetailsActivityModule::class,
            GraphActivityModule::class]
)
interface CloneFinderComponent : AndroidInjector<CloneFinderApplication> {

    @Component.Builder
    abstract class Builder : AndroidInjector.Builder<CloneFinderApplication>() {

        abstract fun cloneFinderModule(cloneFinderModule: CloneFinderModule): Builder
    }
}
