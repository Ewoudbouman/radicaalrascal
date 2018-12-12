package com.peters.michael.clonefinder2000.presentation.projects

import android.os.Bundle
import android.support.v7.widget.DividerItemDecoration
import android.support.v7.widget.LinearLayoutManager
import com.peters.michael.clonefinder2000.R
import com.peters.michael.clonefinder2000.domain.CloneType.Project
import com.peters.michael.clonefinder2000.presentation.projectdetails.ProjectDetailsActivity
import dagger.android.support.DaggerAppCompatActivity
import kotlinx.android.synthetic.main.activity_projects.*
import org.jetbrains.anko.toast
import javax.inject.Inject

class ProjectsActivity : DaggerAppCompatActivity(), ProjectsContract.View, ProjectsContract.Navigator {

    @Inject
    lateinit var presenter: ProjectsPresenter

    private val adapter by lazy {
        ProjectsAdapter().apply {
            onProjectClicked = { presenter.onProjectClicked(it) }
        }
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_projects)
        projectsRecyclerView.adapter = adapter
        projectsRecyclerView.addItemDecoration(DividerItemDecoration(this, LinearLayoutManager.VERTICAL))
        initToolbar()
    }

    private fun initToolbar() {
        supportActionBar?.setTitle(R.string.projects_screen_name)
    }

    override fun onStart() {
        super.onStart()
        presenter.startPresenting()
    }

    override fun onStop() {
        presenter.stopPresenting()
        super.onStop()
    }

    override fun showProjects(projects: List<Project>) {
        adapter.projects = projects
    }

    override fun showProjectsError() {
        toast("Could not load projects..")
    }

    override fun openProject(projectId: String) {
        startActivity(ProjectDetailsActivity.createIntent(this, projectId))
    }
}