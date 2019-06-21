module Turtle exposing (Command(..), Point, State, applyCommand, initState)

import Color
import ColorShift
import Vector2d


type alias Point =
    ( Float, Float )


type alias State =
    { location : Point
    , orientation : Float
    , width : Float
    , color : Color.Color
    }


initState : State
initState =
    State ( 0, 0 ) 0 1 Color.black


type Command
    = Forward Float
    | Turn Float
    | IncreaseWidth Float
    | HueShift Float
    | IncreaseSaturation Float
    | IncreaseLightness Float
    | IncreaseAlpha Float


applyCommand : Command -> State -> State
applyCommand command ({ location, orientation, width, color } as state) =
    case command of
        Forward x ->
            { state
                | location =
                    Vector2d.fromPolarComponents ( x, orientation )
                        |> Vector2d.sum (Vector2d.fromComponents location)
                        |> Vector2d.components
            }

        Turn a ->
            { state
                | orientation = orientation + degrees a
            }

        IncreaseWidth x ->
            { state
                | width = max 0 (width + x)
            }

        HueShift a ->
            { state
                | color = ColorShift.hueShift a color
            }

        IncreaseSaturation x ->
            { state
                | color = ColorShift.increaseSaturation x color
            }

        IncreaseLightness x ->
            { state
                | color = ColorShift.increaseLightness x color
            }

        IncreaseAlpha x ->
            { state
                | color = ColorShift.increaseAlpha x color
            }
