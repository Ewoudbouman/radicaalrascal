package com.peters.michael.clonefinder2000.presentation.projects

import com.peters.michael.clonefinder2000.domain.CloneType.Project
import com.peters.michael.clonefinder2000.domain.GetProjects
import io.reactivex.android.schedulers.AndroidSchedulers
import io.reactivex.disposables.Disposable
import io.reactivex.schedulers.Schedulers
import timber.log.Timber
import javax.inject.Inject

class ProjectsPresenter @Inject constructor(
        private val view: ProjectsContract.View,
        private val navigator: ProjectsContract.Navigator,
        private val getProjects: GetProjects
) : ProjectsContract.Presenter {

    private var disposable: Disposable? = null

    override fun startPresenting() {
        disposable = getProjects()
                .subscribeOn(Schedulers.io())
                .observeOn(AndroidSchedulers.mainThread())
                .doOnSubscribe { view.showLoading() }
                .doOnEvent { _, _ -> view.hideLoading() }
                .subscribe(view::showProjects) {
                    Timber.e(it)
                    view.showProjectsError()
                }
    }

    override fun stopPresenting() {
        disposable?.dispose()
    }

    override fun onProjectClicked(project: Project) {
        navigator.openProject(project.id)
    }
}