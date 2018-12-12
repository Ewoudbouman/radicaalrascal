package com.peters.michael.clonefinder2000.presentation.clonedetails

import com.peters.michael.clonefinder2000.domain.model.Clone

interface CloneDetailsContract {

    interface View {

        val cloneId: String?
        val projectId: String?

        fun showClone(clone: Clone)
        fun showError()
    }

    interface Presenter {

        fun startPresenting()
        fun stopPresenting()
        fun onCloneClassClicked(classId: String)
    }

    interface Navigator {

        fun openCloneClass(projectId: String, cloneClassId: String)
    }
}