package com.peters.michael.clonefinder2000.data.model

import com.google.gson.annotations.SerializedName

class FullSourceResource(

    @SerializedName("path")
    val path: String,

    @SerializedName("source")
    val source: String
)