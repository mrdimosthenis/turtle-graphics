module ColorShift exposing (hueShift, increaseAlpha, increaseLightness, increaseSaturation)

import Color


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
    in
    Color.hsla hue (saturation + x) lightness alpha


increaseLightness : Float -> Color.Color -> Color.Color
increaseLightness x color =
    let
        { hue, saturation, lightness, alpha } =
            Color.toHsla color
    in
    Color.hsla hue saturation (lightness + x) alpha


increaseAlpha : Float -> Color.Color -> Color.Color
increaseAlpha x color =
    let
        { hue, saturation, lightness, alpha } =
            Color.toHsla color
    in
    Color.hsla hue saturation lightness (alpha + x)
