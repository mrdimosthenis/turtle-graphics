module ColorShift exposing (rotateHue, increaseAlpha, increaseBlue, increaseGreen, increaseLightness, increaseRed, increaseSaturation)

import Color


bound : Float -> Float
bound x =
    if x > 1 then
        1

    else if x < 0 then
        0

    else
        x


rotate : Float -> Float
rotate x =
    if x > 1 then
        x - 1

    else if x < 0 then
        x + 1

    else
        x


rotateHue : Float -> Color.Color -> Color.Color
rotateHue x color =
    let
        { hue, saturation, lightness, alpha } =
            Color.toHsla color

        newHue =
            rotate (hue + x)
    in
    Color.hsla newHue saturation lightness alpha


increaseSaturation : Float -> Color.Color -> Color.Color
increaseSaturation x color =
    let
        { hue, saturation, lightness, alpha } =
            Color.toHsla color

        newSaturation =
            bound (saturation + x)
    in
    Color.hsla hue newSaturation lightness alpha


increaseLightness : Float -> Color.Color -> Color.Color
increaseLightness x color =
    let
        { hue, saturation, lightness, alpha } =
            Color.toHsla color

        newLightness =
            bound (lightness + x)
    in
    Color.hsla hue saturation newLightness alpha


increaseAlpha : Float -> Color.Color -> Color.Color
increaseAlpha x color =
    let
        { hue, saturation, lightness, alpha } =
            Color.toHsla color

        newAlpha =
            bound (alpha + x)
    in
    Color.hsla hue saturation lightness newAlpha


increaseRed : Float -> Color.Color -> Color.Color
increaseRed x color =
    let
        { red, green, blue, alpha } =
            Color.toRgba color

        newRed =
            bound (red + x)
    in
    Color.rgba newRed green blue alpha


increaseGreen : Float -> Color.Color -> Color.Color
increaseGreen x color =
    let
        { red, green, blue, alpha } =
            Color.toRgba color

        newGreen =
            bound (green + x)
    in
    Color.rgba red newGreen blue alpha


increaseBlue : Float -> Color.Color -> Color.Color
increaseBlue x color =
    let
        { red, green, blue, alpha } =
            Color.toRgba color

        newBlue =
            bound (blue + x)
    in
    Color.rgba red green newBlue alpha
