package com.peters.michael.clonefinder2000.data.model

import com.google.gson.annotations.SerializedName

class CloneResource(

    @SerializedName("id")
    val id: String,

    @SerializedName("prefix_id")
    val prefixedId: String,

    @SerializedName("attributes")
    val attributes: CloneAttributesResource
)