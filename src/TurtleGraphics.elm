module TurtleGraphics exposing (Command, branch, increaseAlpha, increaseBlue, increaseGreen, increaseLightness, increaseRed, increaseSaturation, increaseWidth, move, render, rotateHue, turn)

import Color exposing (Color)
import Html exposing (Html)
import TurtleGraphics.Core as Core
import TurtleGraphics.Render as Render


{-| `Command` is the building block of the turtle graphics.
Every function, except `render` and branch, is a command that change the
location, direction, width and color of the relative cursor ("turtle").
-}
type alias Command =
    Core.Command


{-| Moves the turtle forward by `x` pixels.
-}
move : Float -> Command
move =
    Core.Move


{-| Changes the turtle's direction by `x` degrees (counterclockwise).
The initial direction is "left-to-right".
-}
turn : Float -> Command
turn =
    Core.Turn


{-| Changes the stroke width of the turtle's pen by `x` pixels.
The initial value is `1.0` pixel.
Providing a negative number will decrease the stroke width.
-}
increaseWidth : Float -> Command
increaseWidth =
    Core.IncreaseWidth


{-| Rotates the hue of the turtle's pen by `x`.
Hue values range between `0.0` and `1.0`.
The initial color of the pen is black (hue = `0.0`).
-}
rotateHue : Float -> Command
rotateHue =
    Core.RotateHue


{-| Increases the saturation of the turtle's pen by `x`.
Saturation values range between `0.0` and `1.0`.
The initial color of the pen is black (saturation = `0.0`).
Providing a negative number will decrease the saturation.
-}
increaseSaturation : Float -> Command
increaseSaturation =
    Core.IncreaseSaturation


{-| Increases the lightness of the turtle's pen by `x`.
Lightness values range between `0.0` and `1.0`.
The initial color of the pen is black (lightness = `0.0`).
Providing a negative number will decrease the saturation.
-}
increaseLightness : Float -> Command
increaseLightness =
    Core.IncreaseLightness


{-| Increases the alpha value of the turtle's pen by `x`.
Alpha ranges between `0.0` and `1.0`.
The initial alpha value of the pen is `1.0`).
Providing a negative number will increase the transparency.
-}
increaseAlpha : Float -> Command
increaseAlpha =
    Core.IncreaseAlpha


{-| Increases the percentage of red by `x`.
The percentage of red ranges between `0.0` and `1.0`.
The initial color of the pen is black (red pct = `0.0`).
Providing a negative number will decrease the percentage of red.
-}
increaseRed : Float -> Command
increaseRed =
    Core.IncreaseRed


{-| Increases the percentage of green by `x`.
The percentage of green ranges between `0.0` and `1.0`.
The initial color of the pen is black (green pct = `0.0`).
Providing a negative number will decrease the percentage of green.
-}
increaseGreen : Float -> Command
increaseGreen =
    Core.IncreaseGreen


{-| Increases the percentage of blue by `x`.
The percentage of blue ranges between `0.0` and `1.0`.
The initial color of the pen is black (blue pct = `0.0`).
Providing a negative number will decrease the percentage of blue.
-}
increaseBlue : Float -> Command
increaseBlue =
    Core.IncreaseBlue


{-| Turns a list of commands into a single `Command`.
-}
branch : List Command -> Command
branch =
    Core.Branch


{-| Takes a background color and a `Command` (usually a `branch` of commands)
and renders it to Html using Svg.
-}
render : Color -> Command -> Html msg
render =
    Render.render
