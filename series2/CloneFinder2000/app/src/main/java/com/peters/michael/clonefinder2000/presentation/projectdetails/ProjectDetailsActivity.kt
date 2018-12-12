package com.peters.michael.clonefinder2000.presentation.projectdetails

import android.content.Context
import android.content.Intent
import android.os.Bundle
import com.peters.michael.clonefinder2000.R
import com.peters.michael.clonefinder2000.domain.model.ProjectDetails
import com.peters.michael.clonefinder2000.presentation.classdetails.ClassDetailsActivity
import dagger.android.support.DaggerAppCompatActivity
import kotlinx.android.synthetic.main.activity_project_details.*
import org.jetbrains.anko.toast
import javax.inject.Inject

class ProjectDetailsActivity : DaggerAppCompatActivity(), ProjectDetailsContract.View, ProjectDetailsContract.Navigator {

    @Inject
    lateinit var presenter: ProjectDetailsContract.Presenter

    private val viewPagerAdapter by lazy {
        DetailsViewPagerAdapter(this, projectDetailsViewPager).apply {
            onCloneClassClicked = { presenter.onCloneClassClicked(it) }
        }
    }

    override val projectId: String?
        get() = intent.getStringExtra(PROJECT_ID_EXTRA)


    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_project_details)
        projectDetailsViewPager.adapter = viewPagerAdapter
        presenter.startPresenting()
    }

    override fun showError() {
        toast("Could not load project")
    }

    override fun showProjectDetails(projectDetails: ProjectDetails) {
        supportActionBar?.title = projectDetails.project.name
        viewPagerAdapter.projectDetails = projectDetails
        projectDetailsTabLayout.setupWithViewPager(projectDetailsViewPager)
    }

    override fun openCloneClass(projectId: String, classId: String) {
        startActivity(ClassDetailsActivity.createIntent(this, projectId, classId))
    }

    companion object {

        private const val PROJECT_ID_EXTRA = "PROJECT_ID_EXTRA"

        fun createIntent(context: Context, projectId: String): Intent {
            return Intent(context, ProjectDetailsActivity::class.java).apply {
                putExtra(PROJECT_ID_EXTRA, projectId)
            }
        }
    }
}