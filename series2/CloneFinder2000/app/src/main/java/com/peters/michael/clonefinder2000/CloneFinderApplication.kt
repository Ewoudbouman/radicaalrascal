package com.peters.michael.clonefinder2000

import dagger.android.AndroidInjector
import dagger.android.support.DaggerApplication
import timber.log.Timber

class CloneFinderApplication : DaggerApplication() {

    override fun applicationInjector(): AndroidInjector<out DaggerApplication> {
        return DaggerCloneFinderComponent.builder()
            .cloneFinderModule(CloneFinderModule())
            .create(this)
    }

    override fun onCreate() {
        super.onCreate()
        setupTimber()
    }

    private fun setupTimber() {
        if (BuildConfig.DEBUG) {
            Timber.plant(Timber.DebugTree())
        }
    }
}