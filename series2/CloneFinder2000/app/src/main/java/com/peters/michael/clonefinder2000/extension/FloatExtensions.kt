package com.peters.michael.clonefinder2000.extension

import java.math.RoundingMode
import java.text.DecimalFormat

fun Float.toThreeDecimalString(): String {
    return DecimalFormat("#.###").let {
        it.roundingMode = RoundingMode.HALF_UP
        it.format(this)
    }
}