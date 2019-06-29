module Examples.SquareSpiral exposing (main)

import Color
import Html
import TurtleGraphics.Core exposing (Command(..))
import TurtleGraphics.Render exposing (render)


iter : Int -> Float -> List Command
iter n dist =
    case n of
        0 ->
            []

        _ ->
            iter (n - 1) (dist + 2.5)
                |> List.append
                    [ Turn 89.5
                    , Move dist
                    , RotateHue 0.002
                    , IncreaseAlpha -0.005
                    , IncreaseWidth 0.02
                    ]


main : Html.Html msg
main =
    iter 200 1.0
        |> Branch
        |> List.singleton
        |> List.append
            [ IncreaseRed -1
            , IncreaseGreen 1
            , IncreaseBlue -1
            ]
        |> Branch
        |> render Color.darkCharcoal
