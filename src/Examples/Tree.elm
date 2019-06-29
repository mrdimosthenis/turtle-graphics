module Examples.Tree exposing (main, tree)

import Color
import Html
import TurtleGraphics exposing (..)


tree : Float -> Command
tree distance =
    let
        angle =
            distance * 2
    in
    if distance > 0 then
        branch
            [ move 40
            , increaseWidth -1
            , increaseRed -0.04
            , increaseGreen 0.04
            , increaseBlue -0.04
            , turn angle
            , tree (distance - 1)
            , turn (-2 * angle)
            , tree (distance - 1)
            ]

    else
        branch []


main : Html.Html msg
main =
    tree 11
        |> List.singleton
        |> List.append
            [ turn 90
            , increaseWidth 10
            , increaseRed 0.65
            , increaseGreen 0.15
            , increaseBlue 0.15
            ]
        |> branch
        |> render Color.white
