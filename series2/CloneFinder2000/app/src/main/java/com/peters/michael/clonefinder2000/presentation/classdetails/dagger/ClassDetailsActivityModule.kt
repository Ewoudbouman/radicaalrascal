package com.peters.michael.clonefinder2000.presentation.classdetails.dagger

import com.peters.michael.clonefinder2000.presentation.classdetails.ClassDetailsActivity
import com.peters.michael.clonefinder2000.presentation.classdetails.ClassDetailsContract
import com.peters.michael.clonefinder2000.presentation.classdetails.ClassDetailsPresenter
import dagger.Binds
import dagger.Module
import dagger.android.ContributesAndroidInjector

@Module
abstract class ClassDetailsActivityModule {

    @ContributesAndroidInjector(modules = [Bindings::class])
    abstract fun classDetailsActivity(): ClassDetailsActivity

    @Module
    interface Bindings {

        @Binds
        fun bindView(classDetailsActivity: ClassDetailsActivity): ClassDetailsContract.View

        @Binds
        fun bindPresenter(classDetailsPresenter: ClassDetailsPresenter): ClassDetailsContract.Presenter

        @Binds
        fun bindNavigator(classDetailsActivity: ClassDetailsActivity): ClassDetailsContract.Navigator
    }
}