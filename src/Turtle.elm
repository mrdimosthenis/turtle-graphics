module Turtle exposing (Command(..), Line, Point, State, initState, iterate, toLines)

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


type Command
    = Move Float
    | Turn Float
    | IncreaseWidth Float
    | HueShift Float
    | IncreaseSaturation Float
    | IncreaseLightness Float
    | IncreaseAlpha Float
    | IncreaseRed Float
    | IncreaseGreen Float
    | IncreaseBlue Float
    | Branch (List Command)


type alias Line =
    { start : Point
    , end : Point
    , lineWidth : Float
    , lineColor : Color.Color
    }


initState : State
initState =
    State ( 0, 0 ) 0 1 Color.gray


iterate : ( State, List Command ) -> ( State, List Line )
iterate ( state, commands ) =
    List.foldl
        (\command ( { location, orientation, width, color } as currentState, lines ) ->
            case command of
                Move x ->
                    let
                        newState =
                            { currentState
                                | location =
                                    Vector2d.fromPolarComponents ( x, orientation )
                                        |> Vector2d.sum (Vector2d.fromComponents location)
                                        |> Vector2d.components
                            }
                    in
                    ( newState
                    , Line location newState.location width color :: lines
                    )

                Turn a ->
                    ( { currentState
                        | orientation = orientation - degrees a
                      }
                    , lines
                    )

                IncreaseWidth x ->
                    ( { currentState
                        | width = max 0 (width + x)
                      }
                    , lines
                    )

                HueShift a ->
                    ( { currentState
                        | color = ColorShift.hueShift a color
                      }
                    , lines
                    )

                IncreaseSaturation x ->
                    ( { currentState
                        | color = ColorShift.increaseSaturation x color
                      }
                    , lines
                    )

                IncreaseLightness x ->
                    ( { currentState
                        | color = ColorShift.increaseLightness x color
                      }
                    , lines
                    )

                IncreaseAlpha x ->
                    ( { currentState
                        | color = ColorShift.increaseAlpha x color
                      }
                    , lines
                    )

                IncreaseRed x ->
                    ( { currentState
                        | color = ColorShift.increaseRed x color
                      }
                    , lines
                    )

                IncreaseGreen x ->
                    ( { currentState
                        | color = ColorShift.increaseGreen x color
                      }
                    , lines
                    )

                IncreaseBlue x ->
                    ( { currentState
                        | color = ColorShift.increaseBlue x color
                      }
                    , lines
                    )

                Branch branchCommands ->
                    let
                        branchedLines =
                            ( currentState, branchCommands )
                                |> iterate
                                |> Tuple.second
                    in
                    ( currentState
                    , List.concat [ branchedLines, lines ]
                    )
        )
        ( state, [] )
        commands


toLines : Command -> List Line
toLines command =
    ( initState, [ command ] )
        |> iterate
        |> Tuple.second
        |> List.reverse
