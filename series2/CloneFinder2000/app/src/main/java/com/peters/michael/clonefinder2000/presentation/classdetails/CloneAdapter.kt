package com.peters.michael.clonefinder2000.presentation.classdetails

import android.support.v7.widget.RecyclerView
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import com.peters.michael.clonefinder2000.R
import com.peters.michael.clonefinder2000.domain.model.Clone
import kotlinx.android.synthetic.main.list_item_clone.view.*

class CloneAdapter : RecyclerView.Adapter<CloneAdapter.CloneViewHolder>() {

    var onCloneClicked: ((Clone) -> Unit)? = null

    var clones: List<Clone> = emptyList()
        set(value) {
            field = value
            notifyDataSetChanged()
        }

    override fun onCreateViewHolder(parent: ViewGroup, position: Int): CloneViewHolder =
        CloneViewHolder(LayoutInflater.from(parent.context).inflate(R.layout.list_item_clone, parent, false))

    override fun getItemCount(): Int {
        return clones.size
    }

    override fun onBindViewHolder(cloneClassViewHolder: CloneViewHolder, position: Int) =
        cloneClassViewHolder.bind(clones[position])

    inner class CloneViewHolder(itemView: View) : RecyclerView.ViewHolder(itemView) {

        fun bind(clone: Clone) {
            itemView.apply {
                itemCloneFileName.text = clone.path
                itemCloneLocation.text = "(${clone.startLine},${clone.endLine})"
                setOnClickListener { onCloneClicked?.invoke(clone) }
            }
        }
    }
}