package com.peters.michael.clonefinder2000.data.model

import com.google.gson.annotations.SerializedName

class CloneClassResource(

    @SerializedName("id")
    val id: Int,

    @SerializedName("prefix_id")
    val prefixedId: String,

    @SerializedName("LOC")
    val LOC: Long,

    @SerializedName("percentageOfProject")
    val percentageOfProject: Float,

    @SerializedName("children")
    val clones: List<CloneResource>
)