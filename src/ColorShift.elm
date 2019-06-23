module ColorShift exposing (bound, bound_0_1, bound_0_256, hueShift, increaseAlpha, increaseBlue, increaseGreen, increaseLightness, increaseRed, increaseSaturation)

import Color


bound : Float -> Float -> Float -> Float
bound a b x =
    if x > b then
        b

    else if x < a then
        a

    else
        x


bound_0_1 : Float -> Float
bound_0_1 =
    bound 0 1


bound_0_256 : Float -> Float
bound_0_256 =
    bound 0 256


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
            bound_0_1 (saturation + x)
    in
    Color.hsla hue newSaturation lightness alpha


increaseLightness : Float -> Color.Color -> Color.Color
increaseLightness x color =
    let
        { hue, saturation, lightness, alpha } =
            Color.toHsla color

        newLightness =
            bound_0_1 (lightness + x)
    in
    Color.hsla hue saturation newLightness alpha


increaseAlpha : Float -> Color.Color -> Color.Color
increaseAlpha x color =
    let
        { hue, saturation, lightness, alpha } =
            Color.toHsla color

        newAlpha =
            bound_0_1 (alpha + x)
    in
    Color.hsla hue saturation lightness newAlpha


increaseRed : Float -> Color.Color -> Color.Color
increaseRed x color =
    let
        { red, green, blue, alpha } =
            Color.toRgba color

        newRed =
            bound_0_256 (red + x)
    in
    Color.rgba newRed green blue alpha


increaseGreen : Float -> Color.Color -> Color.Color
increaseGreen x color =
    let
        { red, green, blue, alpha } =
            Color.toRgba color

        newGreen =
            bound_0_256 (green + x)
    in
    Color.rgba red newGreen blue alpha


increaseBlue : Float -> Color.Color -> Color.Color
increaseBlue x color =
    let
        { red, green, blue, alpha } =
            Color.toRgba color

        newBlue =
            bound_0_256 (blue + x)
    in
    Color.rgba red green newBlue alpha
