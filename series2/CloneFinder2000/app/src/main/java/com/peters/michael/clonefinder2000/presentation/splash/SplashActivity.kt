package com.peters.michael.clonefinder2000.presentation.splash

import android.content.Intent
import android.os.Bundle
import android.support.v7.app.AppCompatActivity
import com.peters.michael.clonefinder2000.presentation.projects.ProjectsActivity

class SplashActivity : AppCompatActivity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        startActivity(Intent(this, ProjectsActivity::class.java))
    }
}