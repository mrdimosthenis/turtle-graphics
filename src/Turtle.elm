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
    | Branch (List Command)


type alias Line =
    { start : Point
    , end : Point
    , lineWidth : Float
    , lineColor : Color.Color
    }


initState : State
initState =
    State ( 0, 0 ) 0 1 Color.black


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
                        | orientation = orientation + degrees a
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

                Branch branchCommands ->
                    let
                        ( _, branchedLines ) =
                            iterate ( currentState, branchCommands )

                        newLines =
                            List.concat [ branchedLines, lines ]
                    in
                    ( currentState
                    , newLines
                    )
        )
        ( state, [] )
        commands


toLines : List Command -> List Line
toLines commands =
    let
        ( _, lines ) =
            iterate ( initState, commands )
    in
    List.reverse lines
