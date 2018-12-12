package com.peters.michael.clonefinder2000.presentation.clonedetails

import android.content.Context
import android.content.Intent
import android.os.Bundle
import br.tiagohm.codeview.CodeView
import br.tiagohm.codeview.Language
import br.tiagohm.codeview.Theme
import com.peters.michael.clonefinder2000.R
import com.peters.michael.clonefinder2000.domain.model.Clone
import dagger.android.support.DaggerAppCompatActivity
import kotlinx.android.synthetic.main.activity_clone.*
import org.jetbrains.anko.toast
import javax.inject.Inject

class CloneDetailsActivity : DaggerAppCompatActivity(), CodeView.OnHighlightListener, CloneDetailsContract.View {

    @Inject
    lateinit var presenter: CloneDetailsContract.Presenter

    override val cloneId: String?
        get() = intent.getStringExtra(CLONE_ID_EXTRA)

    override val projectId: String?
        get() = intent.getStringExtra(PROJECT_ID_EXTRA)

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_clone)
        presenter.startPresenting()
    }

    override fun showClone(clone: Clone) {
        supportActionBar?.title = "${clone.fileName} (${clone.startLine},${clone.endLine})"
        clone.source.replace("\r", "").let {
            cloneCodeView.setOnHighlightListener(this)
                .setTheme(Theme.GITHUB)
                .setCode("$it\n")
                .setLanguage(Language.JAVA)
                .apply()
        }

        cloneCodeView.highlightLineNumber((clone.startLine..clone.endLine).toList().toIntArray())
    }

    override fun showError() {
        toast("Failed to load clone")
    }

    override fun onStartCodeHighlight() {
        //Do nothing
    }

    override fun onFinishCodeHighlight() {
        //Do nothing
    }

    override fun onLanguageDetected(language: Language, relevance: Int) {
        //Do nothing
    }

    override fun onFontSizeChanged(sizeInPx: Int) {
        //Do nothing
    }

    override fun onLineClicked(lineNumber: Int, content: String) {
        //Do nothing
    }

    companion object {

        private const val CLONE_ID_EXTRA = "CLONE_ID_EXTRA"
        private const val PROJECT_ID_EXTRA = "PROJECT_ID_EXTRA"

        fun createIntent(context: Context, projectId: String, cloneId: String): Intent {
            return Intent(context, CloneDetailsActivity::class.java).apply {
                putExtra(CLONE_ID_EXTRA, cloneId)
                putExtra(PROJECT_ID_EXTRA, projectId)
            }
        }
    }
}
