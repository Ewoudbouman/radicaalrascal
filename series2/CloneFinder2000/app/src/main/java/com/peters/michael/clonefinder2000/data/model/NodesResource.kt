package com.peters.michael.clonefinder2000.data.model

import com.google.gson.annotations.SerializedName

class NodesResource(

    @SerializedName("children")
    val children: List<CloneClassResource>
)