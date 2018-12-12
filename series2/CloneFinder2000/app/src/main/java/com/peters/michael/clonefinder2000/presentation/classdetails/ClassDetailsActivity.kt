package com.peters.michael.clonefinder2000.presentation.classdetails

import android.content.Context
import android.content.Intent
import android.os.Bundle
import android.support.v7.widget.DividerItemDecoration
import android.support.v7.widget.LinearLayoutManager
import com.peters.michael.clonefinder2000.R
import com.peters.michael.clonefinder2000.domain.model.CloneClass
import com.peters.michael.clonefinder2000.presentation.clonedetails.CloneDetailsActivity
import com.peters.michael.clonefinder2000.extension.toThreeDecimalString
import dagger.android.support.DaggerAppCompatActivity
import kotlinx.android.synthetic.main.activity_clone_class.*
import org.jetbrains.anko.toast
import javax.inject.Inject

class ClassDetailsActivity : DaggerAppCompatActivity(), ClassDetailsContract.View, ClassDetailsContract.Navigator {

    @Inject
    lateinit var presenter: ClassDetailsContract.Presenter

    private val adapter by lazy {
        CloneAdapter().apply {
            onCloneClicked = { presenter.onCloneClicked(it) }
        }
    }

    override val classId: String?
        get() = intent.getStringExtra(CLASS_ID_EXTRA)

    override val projectId: String?
        get() = intent.getStringExtra(PROJECT_ID_EXTRA)

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_clone_class)
        cloneClassRecyclerView.adapter = adapter
        cloneClassRecyclerView.addItemDecoration(DividerItemDecoration(this, LinearLayoutManager.VERTICAL))
        presenter.startPresenting()
    }

    override fun showClass(cloneClass: CloneClass) {
        supportActionBar?.title =
                "${getString(R.string.identifier, cloneClass.id)} " +
                "(${getString(R.string.percentage, cloneClass.percentageOfProject.toThreeDecimalString())})"
        adapter.clones = cloneClass.clones
    }

    override fun showError() {
        toast("Failed to show clone class")
    }

    override fun openClone(projectId: String, classId: String) {
        startActivity(CloneDetailsActivity.createIntent(this, projectId, classId))
    }

    companion object {

        private const val CLASS_ID_EXTRA = "CLASS_ID_EXTRA"
        private const val PROJECT_ID_EXTRA = "PROJECT_ID_EXTRA"

        fun createIntent(context: Context, projectId: String, classId: String): Intent {
            return Intent(context, ClassDetailsActivity::class.java).apply {
                putExtra(CLASS_ID_EXTRA, classId)
                putExtra(PROJECT_ID_EXTRA, projectId)
            }
        }
    }
}