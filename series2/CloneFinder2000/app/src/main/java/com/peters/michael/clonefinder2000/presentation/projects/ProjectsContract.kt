package com.peters.michael.clonefinder2000.presentation.projects

import com.peters.michael.clonefinder2000.domain.model.Project

interface ProjectsContract {

    interface View {

        fun showProjects(projects: List<Project>)
        fun showProjectsError()
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