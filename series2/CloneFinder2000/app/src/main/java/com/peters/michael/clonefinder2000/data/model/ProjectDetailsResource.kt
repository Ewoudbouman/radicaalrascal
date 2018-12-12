package com.peters.michael.clonefinder2000.data.model

import com.google.gson.annotations.SerializedName

class ProjectDetailsResource(

    @SerializedName("duplicatesPercentage")
    val duplicatesPercentage: Float,

    @SerializedName("duplicatesLOC")
    val duplicatesLOC: Long,

    @SerializedName("totalLOC")
    val totalLOC: Long,

    @SerializedName("nodes")
    val nodes: NodesResource,

    @SerializedName("fullSources")
    val fullSources: List<FullSourceResource>
)
