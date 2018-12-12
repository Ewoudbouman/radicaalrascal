package com.peters.michael.clonefinder2000.presentation.projectdetails

import com.peters.michael.clonefinder2000.domain.GetProjectDetails
import com.peters.michael.clonefinder2000.domain.CloneType.CloneClass
import com.peters.michael.clonefinder2000.domain.CloneType.CloneType
import io.reactivex.android.schedulers.AndroidSchedulers
import io.reactivex.disposables.Disposable
import io.reactivex.schedulers.Schedulers
import timber.log.Timber
import javax.inject.Inject

class ProjectDetailsPresenter @Inject constructor(
    private val view: ProjectDetailsContract.View,
    private val navigator: ProjectDetailsContract.Navigator,
    private val getProjectDetails: GetProjectDetails
) :
    ProjectDetailsContract.Presenter {

    private var disposable: Disposable? = null

    override fun startPresenting() {
        view.projectId?.let {
            disposable = getProjectDetails(it)
                .subscribeOn(Schedulers.io())
                .observeOn(AndroidSchedulers.mainThread())
                .subscribe(view::showProjectDetails) { error ->
                    view.showError()
                    Timber.e(error)
                }
        } ?: view.showError()
    }

    override fun stopPresenting() {
        disposable?.dispose()
    }

    override fun onCloneClassClicked(cloneClass: CloneClass) {
        view.projectId?.let {
            navigator.openCloneClass(it, cloneClass.id)
        }
    }

    override fun onCloneTypeClicked(cloneType: CloneType) {
        view.projectId?.let {
            navigator.openProjectGraph(it, cloneType)
        }
    }
}
