package com.peters.michael.clonefinder2000.presentation.graph

import android.content.Context
import android.content.Intent
import android.os.Bundle
import android.webkit.JavascriptInterface
import android.webkit.WebChromeClient
import android.webkit.WebSettings
import android.webkit.WebViewClient
import com.peters.michael.clonefinder2000.R
import com.peters.michael.clonefinder2000.domain.CloneType.CloneType
import com.peters.michael.clonefinder2000.presentation.clonedetails.CloneDetailsActivity
import dagger.android.support.DaggerAppCompatActivity
import kotlinx.android.synthetic.main.activity_graph.*
import org.jetbrains.anko.toast
import javax.inject.Inject

class GraphActivity : DaggerAppCompatActivity(), GraphContract.View, GraphContract.Navigator {

    override val projectId: String?
        get() = intent.getStringExtra(PROJECT_ID_EXTRA)

    override val cloneType: CloneType?
        get() = intent.getSerializableExtra(CLONE_TYPE_EXTRA) as? CloneType

    @Inject
    lateinit var presenter: GraphContract.Presenter

    private var rawData: String = ""

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_graph)
        presenter.startPresenting()
    }

    override fun onStop() {
        presenter.stopPresenting()
        super.onStop()
    }

    override fun showGraph(rawData: String) {
        this.rawData = rawData
        webview.run {
            settings.run {
                javaScriptEnabled = true
                pluginState = WebSettings.PluginState.ON
                allowFileAccess = true
                domStorageEnabled = true
                allowContentAccess = true
                allowFileAccessFromFileURLs = true
                allowUniversalAccessFromFileURLs = true
                builtInZoomControls = true
            }
            webViewClient = WebViewClient()
            webChromeClient = WebChromeClient()
            addJavascriptInterface(WebAppInterface(), "Android")
            loadUrl("file:///android_asset/graph/index.html")
        }
    }

    override fun showError() {
        toast("Can't show graph of project.")
    }

    override fun openCloneDetails(projectId: String, cloneId: String) {
        startActivity(CloneDetailsActivity.createIntent(this, projectId, cloneId))
    }

    inner class WebAppInterface {

        var clickedCloneId: String = ""

        @JavascriptInterface
        fun loadData(): String {
            return rawData
        }

        @JavascriptInterface
        fun onCloneClicked(cloneId: String) {
            if(clickedCloneId == cloneId) {
                presenter.onCloneClicked(cloneId)
            }
            clickedCloneId = cloneId
        }
    }

    companion object {

        private const val PROJECT_ID_EXTRA = "PROJECT_ID_EXTRA"
        private const val CLONE_TYPE_EXTRA = "CLONE_TYPE_EXTRA"

        fun createIntent(context: Context, projectId: String, cloneType: CloneType): Intent {
            return Intent(context, GraphActivity::class.java).apply {
                putExtra(PROJECT_ID_EXTRA, projectId)
                putExtra(CLONE_TYPE_EXTRA, cloneType)
            }
        }
    }
}
