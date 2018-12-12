package com.peters.michael.clonefinder2000.presentation.clonedetails.dagger

import com.peters.michael.clonefinder2000.presentation.clonedetails.CloneDetailsActivity
import com.peters.michael.clonefinder2000.presentation.clonedetails.CloneDetailsContract
import com.peters.michael.clonefinder2000.presentation.clonedetails.CloneDetailsPresenter
import dagger.Binds
import dagger.Module
import dagger.android.ContributesAndroidInjector

@Module
abstract class CloneDetailsActivityModule {

    @ContributesAndroidInjector(modules = [Bindings::class])
    abstract fun cloneDetailsActivity(): CloneDetailsActivity

    @Module
    interface Bindings {

        @Binds
        fun bindView(cloneDetailsActivity: CloneDetailsActivity): CloneDetailsContract.View

        @Binds
        fun bindPresenter(cloneDetailsPresenter: CloneDetailsPresenter): CloneDetailsContract.Presenter

        @Binds
        fun bindNavigator(cloneDetailsActivity: CloneDetailsActivity) :CloneDetailsContract.Navigator
    }
}