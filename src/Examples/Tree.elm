module Examples.Tree exposing (main, tree)

import Color
import Html
import TurtleGraphics.Core exposing (Command(..))
import TurtleGraphics.Render exposing (render)


tree : Float -> Command
tree distance =
    let
        angle =
            distance * 2
    in
    if distance > 0 then
        Branch
            [ Move 40
            , IncreaseWidth -1
            , IncreaseRed -0.04
            , IncreaseGreen 0.04
            , IncreaseBlue -0.04
            , Turn angle
            , tree (distance - 1)
            , Turn (-2 * angle)
            , tree (distance - 1)
            ]

    else
        Branch []


main : Html.Html msg
main =
    tree 11
        |> List.singleton
        |> List.append
            [ Turn 90
            , IncreaseWidth 10
            , IncreaseRed 0.65
            , IncreaseGreen 0.15
            , IncreaseBlue 0.15
            ]
        |> Branch
        |> render Color.white
