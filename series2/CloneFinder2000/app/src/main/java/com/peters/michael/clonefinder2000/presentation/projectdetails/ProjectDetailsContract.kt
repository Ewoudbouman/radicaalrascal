package com.peters.michael.clonefinder2000.presentation.projectdetails

import com.peters.michael.clonefinder2000.domain.CloneType.CloneClass
import com.peters.michael.clonefinder2000.domain.CloneType.CloneType
import com.peters.michael.clonefinder2000.domain.CloneType.ProjectDetails

interface ProjectDetailsContract {

    interface View {

        val projectId: String?

        fun showError()
        fun showProjectDetails(projectDetails: ProjectDetails)
        fun showLoading()
        fun hideLoading()
    }

    interface Navigator {

        fun openCloneClass(projectId: String, classId: String)
        fun openProjectGraph(projectId: String, cloneType: CloneType)
    }

    interface Presenter {

        fun startPresenting()
        fun stopPresenting()
        fun onCloneClassClicked(cloneClass: CloneClass)
        fun onCloneTypeClicked(cloneType: CloneType)
    }
}