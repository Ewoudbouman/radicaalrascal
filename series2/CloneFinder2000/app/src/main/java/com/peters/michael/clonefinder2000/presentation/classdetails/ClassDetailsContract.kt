package com.peters.michael.clonefinder2000.presentation.classdetails

import com.peters.michael.clonefinder2000.domain.model.Clone
import com.peters.michael.clonefinder2000.domain.CloneType.CloneClass

interface ClassDetailsContract {

    interface View {

        val classId: String?
        val projectId: String?

        fun showClass(cloneClass: CloneClass)
        fun showError()
        fun showLoading()
        fun hideLoading()
    }

    interface Presenter {

        fun startPresenting()
        fun stopPresenting()
        fun onCloneClicked(clone: Clone)
    }

    interface Navigator {

        fun openClone(projectId:String, cloneId: String)
    }
}