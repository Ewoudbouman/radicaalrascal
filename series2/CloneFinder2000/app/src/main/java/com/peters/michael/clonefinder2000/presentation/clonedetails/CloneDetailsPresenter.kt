package com.peters.michael.clonefinder2000.presentation.clonedetails

import com.peters.michael.clonefinder2000.domain.GetClone
import io.reactivex.android.schedulers.AndroidSchedulers
import io.reactivex.disposables.Disposable
import io.reactivex.schedulers.Schedulers
import timber.log.Timber
import javax.inject.Inject

class CloneDetailsPresenter @Inject constructor(private val view: CloneDetailsContract.View,
                                                private val getClone: GetClone) : CloneDetailsContract.Presenter {

    private var disposable: Disposable? = null

    override fun startPresenting() {
        view.cloneId?.let { cloneId ->
            view.projectId?.let { projectId ->
                disposable = getClone(projectId, cloneId)
                        .subscribeOn(Schedulers.io())
                        .observeOn(AndroidSchedulers.mainThread())
                        .subscribe(view::showClone) {
                            Timber.e(it)
                            view.showError()
                        }
            }
        } ?: view.showError()
    }

    override fun stopPresenting() {
        disposable?.dispose()
    }
}