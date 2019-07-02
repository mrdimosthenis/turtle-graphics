module SquareSpiral exposing (main)

import Color
import Html
import TurtleGraphics exposing (..)


iter : Int -> Float -> List Command
iter n dist =
    case n of
        0 ->
            []

        _ ->
            iter (n - 1) (dist + 2.5)
                |> List.append
                    [ turn 89.5
                    , move dist
                    , rotateHue 0.002
                    , increaseAlpha -0.005
                    , increaseWidth 0.02
                    ]


main : Html.Html msg
main =
    iter 200 1.0
        |> branch
        |> List.singleton
        |> List.append
            [ increaseRed -1
            , increaseGreen 1
            , increaseBlue -1
            ]
        |> branch
        |> render Color.darkCharcoal
