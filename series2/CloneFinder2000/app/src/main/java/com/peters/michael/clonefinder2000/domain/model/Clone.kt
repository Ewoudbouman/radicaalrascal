package com.peters.michael.clonefinder2000.domain.model

data class Clone(

    val id: String,
    val sloc: Long,
    val path: String,
    val fileName: String,
    val percentageOfProject: Float,
    val percentageOfClass: Float,
    val source: String,
    val startLine: Int,
    val endLine: Int,
    val clonedCode: String,
    val parentClassId: String
)