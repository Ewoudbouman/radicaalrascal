package com.peters.michael.clonefinder2000.presentation.projects

import android.support.v7.widget.RecyclerView
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import com.peters.michael.clonefinder2000.R
import com.peters.michael.clonefinder2000.domain.CloneType.Project
import kotlinx.android.synthetic.main.list_item_project.view.*

class ProjectsAdapter : RecyclerView.Adapter<ProjectsAdapter.ProjectViewHolder>() {

    var onProjectClicked: ((Project) -> Unit)? = null

    var projects: List<Project> = emptyList()
        set(value) {
            field = value
            notifyDataSetChanged()
        }

    override fun onCreateViewHolder(parent: ViewGroup, position: Int): ProjectViewHolder =
            ProjectViewHolder(LayoutInflater.from(parent.context).inflate(R.layout.list_item_project, parent, false))

    override fun getItemCount(): Int = projects.size

    override fun onBindViewHolder(projectViewHolder: ProjectViewHolder, position: Int) =
            projectViewHolder.bind(projects[position])

    inner class ProjectViewHolder(itemView: View) : RecyclerView.ViewHolder(itemView) {

        fun bind(project: Project) {
            itemView.apply {
                itemProjectName.text = project.name
                itemProjectSloc.text = context.getString(R.string.projects_sloc, project.sloc)
                setOnClickListener { onProjectClicked?.invoke(project) }
            }
        }
    }
}