package com.peters.michael.clonefinder2000.presentation.classdetails

import com.peters.michael.clonefinder2000.domain.GetCloneClass
import com.peters.michael.clonefinder2000.domain.model.Clone
import io.reactivex.android.schedulers.AndroidSchedulers
import io.reactivex.disposables.Disposable
import io.reactivex.schedulers.Schedulers
import timber.log.Timber
import javax.inject.Inject

class ClassDetailsPresenter @Inject constructor(private val view: ClassDetailsContract.View,
                                                private val navigator: ClassDetailsContract.Navigator,
                                                private val getCloneClass: GetCloneClass) : ClassDetailsContract.Presenter {

    private var disposable: Disposable? = null

    override fun startPresenting() {
        view.classId?.let { classId ->
            view.projectId?.let { projectId ->
                disposable = getCloneClass(projectId, classId)
                        .doOnSubscribe { view.showLoading() }
                        .subscribeOn(Schedulers.io())
                        .observeOn(AndroidSchedulers.mainThread())
                        .doOnEvent { _, _ -> view.hideLoading() }
                        .subscribe(view::showClass) {
                            Timber.e(it)
                            view.showError()
                        }
            }
        } ?: view.showError()
    }

    override fun stopPresenting() {
        disposable?.dispose()
    }

    override fun onCloneClicked(clone: Clone) {
        view.projectId?.let { navigator.openClone(it, clone.id) }
    }
}