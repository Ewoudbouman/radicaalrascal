package com.peters.michael.clonefinder2000.presentation

import android.annotation.TargetApi
import android.content.Context
import android.os.Build
import android.util.AttributeSet
import android.view.LayoutInflater
import android.view.View
import android.widget.FrameLayout
import com.peters.michael.clonefinder2000.R

class LoadingView : FrameLayout {

    @JvmOverloads
    constructor(context: Context, attributeSet: AttributeSet? = null, defStyleAttr: Int = 0)
            : super(context, attributeSet, defStyleAttr)

    @TargetApi(Build.VERSION_CODES.LOLLIPOP)
    constructor(context: Context, attributeSet: AttributeSet? = null, defaultStyleAttr: Int = 0, defaultStyleResource: Int)
            : super(context, attributeSet, defaultStyleAttr, defaultStyleResource)

    init {
        LayoutInflater.from(context).inflate(R.layout.view_loading, this, true)
    }

    fun show() {
        visibility = View.VISIBLE
    }

    fun hide() {
        visibility = View.GONE
    }
}