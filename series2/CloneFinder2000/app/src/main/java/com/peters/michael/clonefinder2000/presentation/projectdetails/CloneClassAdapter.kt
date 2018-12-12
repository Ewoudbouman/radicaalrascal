package com.peters.michael.clonefinder2000.presentation.projectdetails

import android.content.Context
import android.support.v7.widget.RecyclerView
import android.text.Html
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import com.futuremind.recyclerviewfastscroll.SectionTitleProvider
import com.peters.michael.clonefinder2000.R
import com.peters.michael.clonefinder2000.domain.model.CloneClass
import com.peters.michael.clonefinder2000.extension.toThreeDecimalString
import kotlinx.android.synthetic.main.list_item_clone_class.view.*

class CloneClassAdapter(private val context: Context) : RecyclerView.Adapter<CloneClassAdapter.CloneClassViewHolder>(),
    SectionTitleProvider {

    var onCloneClassClicked: ((CloneClass) -> Unit)? = null

    var cloneClasses: List<CloneClass> = emptyList()
        set(value) {
            field = value
            notifyDataSetChanged()
        }

    override fun onCreateViewHolder(parent: ViewGroup, position: Int): CloneClassViewHolder =
        CloneClassViewHolder(LayoutInflater.from(parent.context).inflate(R.layout.list_item_clone_class, parent, false))

    override fun getItemCount(): Int = cloneClasses.size

    override fun onBindViewHolder(cloneClassViewHolder: CloneClassViewHolder, position: Int) =
        cloneClassViewHolder.bind(cloneClasses[position])

    override fun getSectionTitle(position: Int): String {
        return context.getString(R.string.percentage, cloneClasses[position].percentageOfProject.toThreeDecimalString())
    }

    inner class CloneClassViewHolder(itemView: View) : RecyclerView.ViewHolder(itemView) {

        fun bind(cloneClass: CloneClass) {
            itemView.apply {
                itemCloneClassCode.text = Html.fromHtml(cloneClass.clones.firstOrNull()?.clonedCode.orEmpty())
                itemCloneClassId.text = context.getString(R.string.identifier, cloneClass.id)
                itemCloneClassSlocText.text = context.getString(R.string.project_details_clone_class_sloc, cloneClass.loc)
                itemCloneClassPercentageText.text = context.getString(
                    R.string.project_details_clone_class_percentage,
                    cloneClass.percentageOfProject.toThreeDecimalString()
                )
                setOnClickListener { onCloneClassClicked?.invoke(cloneClass) }
            }
        }
    }
}