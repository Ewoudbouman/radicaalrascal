package com.peters.michael.clonefinder2000.presentation.projectdetails

import android.content.Context
import android.support.v4.view.PagerAdapter
import android.support.v4.view.ViewPager
import android.support.v7.widget.DividerItemDecoration
import android.support.v7.widget.LinearLayoutManager
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import com.peters.michael.clonefinder2000.R
import com.peters.michael.clonefinder2000.domain.model.CloneClass
import com.peters.michael.clonefinder2000.domain.model.CloneDetails
import com.peters.michael.clonefinder2000.domain.model.ProjectDetails
import com.peters.michael.clonefinder2000.extension.toThreeDecimalString
import kotlinx.android.synthetic.main.layout_project_clone_classes.view.*
import kotlinx.android.synthetic.main.layout_project_summary_view.view.*

class DetailsViewPagerAdapter(private val context: Context,
                              private val viewPager: ViewPager) : PagerAdapter() {

    var projectDetails: ProjectDetails? = null
        set(value) {
            field = value
            notifyDataSetChanged()
        }

    var onCloneClassClicked: ((CloneClass) -> Unit)? = null

    override fun instantiateItem(container: ViewGroup, position: Int): Any {
        when (position) {
            0 -> createSummaryView(container)
            1 -> createClonesListView(container, projectDetails?.type1)
            2 -> createClonesListView(container, projectDetails?.type2)
            3 -> createClonesListView(container, projectDetails?.type3)
            else -> null
        }?.let {
            container.addView(it)
            return it
        } ?: return container
    }

    override fun getPageTitle(position: Int): CharSequence? {
        return when (position) {
            0 -> context.getString(R.string.project_details_summary_title)
            1 -> context.getString(R.string.project_details_summary_type_1_title)
            2 -> context.getString(R.string.project_details_summary_type_2_title)
            3 -> context.getString(R.string.project_details_summary_type_3_title)
            else -> null
        }
    }

    private fun createSummaryView(container: ViewGroup): View {
        return LayoutInflater.from(context).inflate(R.layout.layout_project_summary_view, container, false).apply {
            projectDetails?.let {
                projectSummarySlocText.text = it.project.sloc.toString()
                projectSummaryType1DuplicatePercentage.text = context.getString(R.string.project_details_clone_class_percentage, it.type1.duplicatePercentage.toThreeDecimalString())
                projectSummaryType1CloneClasses.text = context.getString(R.string.project_details_clone_classes, it.type1.cloneClassCount.toString())
                projectSummaryType1Clones.text = context.getString(R.string.project_details_clones, it.type1.cloneCount.toString())
                projectSummaryType1.setOnClickListener { viewPager.currentItem = 1 }

                projectSummaryType2DuplicatePercentage.text = context.getString(R.string.project_details_clone_class_percentage, it.type2.duplicatePercentage.toThreeDecimalString())
                projectSummaryType2CloneClasses.text = context.getString(R.string.project_details_clone_classes, it.type2.cloneClassCount.toString())
                projectSummaryType2Clones.text = context.getString(R.string.project_details_clones, it.type2.cloneCount.toString())
                projectSummaryType2.setOnClickListener { viewPager.currentItem = 2 }

                projectSummaryType3DuplicatePercentage.text = context.getString(R.string.project_details_clone_class_percentage, it.type3.duplicatePercentage.toThreeDecimalString())
                projectSummaryType3CloneClasses.text = context.getString(R.string.project_details_clone_classes, it.type3.cloneClassCount.toString())
                projectSummaryType3Clones.text = context.getString(R.string.project_details_clones, it.type3.cloneCount.toString())
                projectSummaryType3.setOnClickListener { viewPager.currentItem = 3 }
            }
        }
    }

    private fun createClonesListView(container: ViewGroup, cloneDetails: CloneDetails?): View {
        return LayoutInflater.from(context).inflate(R.layout.layout_project_clone_classes, container, false).apply {
            cloneClassesRecyclerView.addItemDecoration(DividerItemDecoration(context, LinearLayoutManager.VERTICAL))
            cloneClassesRecyclerView.adapter = CloneClassAdapter(context).apply {
                cloneClasses = cloneDetails?.cloneClasses ?: emptyList()
                onCloneClassClicked = { this@DetailsViewPagerAdapter.onCloneClassClicked?.invoke(it) }
            }
            cloneClassFastScroll.setRecyclerView(cloneClassesRecyclerView)
        }
    }

    override fun isViewFromObject(view: View, any: Any): Boolean {
        return view == any
    }

    override fun destroyItem(container: ViewGroup, position: Int, any: Any) {
        container.removeView(any as View)
    }

    override fun getCount(): Int = 4

    override fun getItemPosition(`object`: Any): Int = POSITION_NONE
}
