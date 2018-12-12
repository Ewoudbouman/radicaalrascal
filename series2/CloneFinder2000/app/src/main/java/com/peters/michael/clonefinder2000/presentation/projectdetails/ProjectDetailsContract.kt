package com.peters.michael.clonefinder2000.presentation.projectdetails

import com.peters.michael.clonefinder2000.domain.model.CloneClass
import com.peters.michael.clonefinder2000.domain.model.ProjectDetails

interface ProjectDetailsContract {

    interface View {

        val projectId: String?

        fun showError()
        fun showProjectDetails(projectDetails: ProjectDetails)
    }

    interface Navigator {

        fun openCloneClass(projectId:String, classId: String)
    }

    interface Presenter {

        fun startPresenting()
        fun stopPresenting()
        fun onCloneClassClicked(cloneClass: CloneClass)
    }
}