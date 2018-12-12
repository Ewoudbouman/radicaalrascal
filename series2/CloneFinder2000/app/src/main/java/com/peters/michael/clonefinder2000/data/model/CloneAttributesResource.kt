package com.peters.michael.clonefinder2000.data.model

import com.google.gson.annotations.SerializedName

class CloneAttributesResource(

    @SerializedName("LOC")
    val LOC: Long,

    @SerializedName("path")
    val path: String,

    @SerializedName("percentageOfClass")
    val percentageOfClass: Float,

    @SerializedName("percentageOfProject")
    val percentageOfProject: Float,

    @SerializedName("file")
    val file: String,

    @SerializedName("startLine")
    val startLine: Int,

    @SerializedName("endLine")
    val endLine: Int,

    @SerializedName("clone")
    val clone: String

)