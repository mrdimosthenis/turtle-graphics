module TurtleGraphics exposing (Command, branch, increaseAlpha, increaseBlue, increaseGreen, increaseLightness, increaseRed, increaseSaturation, increaseWidth, move, render, rotateHue, turn)

import TurtleGraphics.Core as Core
import TurtleGraphics.Render as Render


type alias Command =
    Core.Command


move =
    Core.Move


turn =
    Core.Turn


increaseWidth =
    Core.IncreaseWidth


rotateHue =
    Core.RotateHue


increaseSaturation =
    Core.IncreaseSaturation


increaseLightness =
    Core.IncreaseLightness


increaseAlpha =
    Core.IncreaseAlpha


increaseRed =
    Core.IncreaseRed


increaseGreen =
    Core.IncreaseGreen


increaseBlue =
    Core.IncreaseBlue


branch =
    Core.Branch


render =
    Render.render
