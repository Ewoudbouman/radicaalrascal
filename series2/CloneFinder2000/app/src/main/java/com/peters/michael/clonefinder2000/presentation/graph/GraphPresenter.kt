package com.peters.michael.clonefinder2000.presentation.graph

import com.peters.michael.clonefinder2000.domain.GetRawProjectData
import io.reactivex.android.schedulers.AndroidSchedulers
import io.reactivex.disposables.Disposable
import io.reactivex.schedulers.Schedulers
import timber.log.Timber
import javax.inject.Inject

class GraphPresenter @Inject constructor(
        private val view: GraphContract.View,
        private val getRawProjectData: GetRawProjectData
) : GraphContract.Presenter {

    private var disposable: Disposable? = null

    override fun startPresenting() {
        view.cloneType?.let { cloneType ->
            view.projectId?.let { projectId ->
                disposable = getRawProjectData(projectId, cloneType)
                        .subscribeOn(Schedulers.io())
                        .observeOn(AndroidSchedulers.mainThread())
                        .subscribe({
                            view.showGraph(it)
                        }, {
                            Timber.e(it)
                            view.showError()
                        })
            }
        }
    }

    override fun stopPresenting() {
        disposable?.dispose()
    }
}