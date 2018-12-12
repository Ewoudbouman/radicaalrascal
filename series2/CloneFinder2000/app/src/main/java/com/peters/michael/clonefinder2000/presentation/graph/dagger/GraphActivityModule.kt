package com.peters.michael.clonefinder2000.presentation.graph.dagger

import com.peters.michael.clonefinder2000.presentation.graph.GraphActivity
import com.peters.michael.clonefinder2000.presentation.graph.GraphContract
import com.peters.michael.clonefinder2000.presentation.graph.GraphPresenter
import dagger.Binds
import dagger.Module
import dagger.android.ContributesAndroidInjector

@Module
abstract class GraphActivityModule {

    @ContributesAndroidInjector(modules = [Bindings::class])
    abstract fun graphActivity(): GraphActivity

    @Module
    interface Bindings {

        @Binds
        fun bindView(graphActivity: GraphActivity): GraphContract.View

        @Binds
        fun bindPresenter(graphPresenter: GraphPresenter): GraphContract.Presenter

        @Binds
        fun bindNavigator(graphActivity: GraphActivity) : GraphContract.Navigator
    }
}