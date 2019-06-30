module TurtleGraphics exposing (Command, branch, increaseAlpha, increaseBlue, increaseGreen, increaseLightness, increaseRed, increaseSaturation, increaseWidth, move, render, rotateHue, turn)

import Color exposing (Color)
import Html exposing (Html)
import TurtleGraphics.Core as Core
import TurtleGraphics.Render as Render


type alias Command =
    Core.Command


move : Float -> Command
move =
    Core.Move


turn : Float -> Command
turn =
    Core.Turn


increaseWidth : Float -> Command
increaseWidth =
    Core.IncreaseWidth


rotateHue : Float -> Command
rotateHue =
    Core.RotateHue


increaseSaturation : Float -> Command
increaseSaturation =
    Core.IncreaseSaturation


increaseLightness : Float -> Command
increaseLightness =
    Core.IncreaseLightness


increaseAlpha : Float -> Command
increaseAlpha =
    Core.IncreaseAlpha


increaseRed : Float -> Command
increaseRed =
    Core.IncreaseRed


increaseGreen : Float -> Command
increaseGreen =
    Core.IncreaseGreen


increaseBlue : Float -> Command
increaseBlue =
    Core.IncreaseBlue


branch : List Command -> Command
branch =
    Core.Branch


render : Color -> Command -> Html msg
render =
    Render.render
