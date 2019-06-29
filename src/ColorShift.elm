module ColorShift exposing (increaseAlpha, increaseBlue, increaseGreen, increaseRed)

import Color


bound : Float -> Float -> Float
bound b x =
    if x > b then
        b

    else if x < 0 then
        0

    else
        x


bound_1 : Float -> Float
bound_1 =
    bound 1


bound_256 : Float -> Float
bound_256 =
    bound 256


increaseAlpha : Float -> Color.Color -> Color.Color
increaseAlpha x color =
    let
        { hue, saturation, lightness, alpha } =
            Color.toHsla color

        newAlpha =
            bound_1 (alpha + x)
    in
    Color.hsla hue saturation lightness newAlpha


increaseRed : Float -> Color.Color -> Color.Color
increaseRed x color =
    let
        { red, green, blue, alpha } =
            Color.toRgba color

        newRed =
            bound_256 (red + x)
    in
    Color.rgba newRed green blue alpha


increaseGreen : Float -> Color.Color -> Color.Color
increaseGreen x color =
    let
        { red, green, blue, alpha } =
            Color.toRgba color

        newGreen =
            bound_256 (green + x)
    in
    Color.rgba red newGreen blue alpha


increaseBlue : Float -> Color.Color -> Color.Color
increaseBlue x color =
    let
        { red, green, blue, alpha } =
            Color.toRgba color

        newBlue =
            bound_256 (blue + x)
    in
    Color.rgba red green newBlue alpha
