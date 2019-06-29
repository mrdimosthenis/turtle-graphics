module TurtleGraphics.Core exposing (..)



import Color
import TurtleGraphics.ColorShift as ColorShift
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
    | RotateHue Float
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


type alias Edges =
    { minX : Float
    , maxX : Float
    , minY : Float
    , maxY : Float
    }


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

                RotateHue x ->
                    ( { currentState
                        | color = ColorShift.rotateHue x color
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
    ( State ( 0, 0 ) 0 1 Color.black
    , [ command ]
    )
        |> iterate
        |> Tuple.second
        |> List.reverse


lineEdges : Line -> Edges
lineEdges { start, end } =
    let
        ( startX, startY ) =
            start

        ( endX, endY ) =
            end

        minX =
            min startX endX

        maxX =
            max startX endX

        minY =
            min startY endY

        maxY =
            max startY endY
    in
    Edges minX maxX minY maxY


mergeEdges : Edges -> Edges -> Edges
mergeEdges a b =
    { minX = min a.minX b.minX
    , maxX = max a.maxX b.maxX
    , minY = min a.minY b.minY
    , maxY = max a.maxY b.maxY
    }


linesToEdges : List Line -> Edges
linesToEdges lines =
    List.foldl
        (\line currentEdges ->
            line
                |> lineEdges
                |> mergeEdges currentEdges
        )
        (Edges 0 0 0 0)
        lines


adjustLinesToEdges : Edges -> List Line -> List Line
adjustLinesToEdges edges lines =
    let
        { minX, minY } =
            edges
    in
    List.map
        (\({ start, end } as line) ->
            let
                ( startX, startY ) =
                    start

                ( endX, endY ) =
                    end
            in
            { line
                | start = ( startX - minX, startY - minY )
                , end = ( endX - minX, endY - minY )
            }
        )
        lines

