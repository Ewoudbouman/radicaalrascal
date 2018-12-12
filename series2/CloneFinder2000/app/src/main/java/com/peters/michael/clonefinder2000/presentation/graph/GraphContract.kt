package com.peters.michael.clonefinder2000.presentation.graph

import com.peters.michael.clonefinder2000.domain.CloneType.CloneType

interface GraphContract {

    interface View {

        val projectId: String?
        val cloneType: CloneType?

        fun showGraph(rawData: String)
        fun showError()
    }

    interface Presenter {

        fun startPresenting()
        fun stopPresenting()
    }
}