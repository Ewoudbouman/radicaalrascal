package com.peters.michael.clonefinder2000.presentation.projects

import com.peters.michael.clonefinder2000.domain.CloneType.Project

interface ProjectsContract {

    interface View {

        fun showProjects(projects: List<Project>)
        fun showProjectsError()
        fun showLoading()
        fun hideLoading()
    }

    interface Navigator {

        fun openProject(projectId: String)
    }

    interface Presenter {

        fun startPresenting()
        fun stopPresenting()
        fun onProjectClicked(project: Project)
    }
}