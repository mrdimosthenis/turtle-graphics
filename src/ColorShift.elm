module ColorShift exposing (hueShift, increaseAlpha, increaseLightness, increaseSaturation)

import Color


bound : Float -> Float
bound x =
    if x > 1 then
        1

    else if x < 0 then
        0

    else
        x


hueShift : Float -> Color.Color -> Color.Color
hueShift a color =
    let
        { hue, saturation, lightness, alpha } =
            Color.toHsla color
    in
    Color.hsla (hue + degrees a) saturation lightness alpha


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
