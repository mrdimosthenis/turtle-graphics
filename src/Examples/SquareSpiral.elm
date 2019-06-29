module Examples.SquareSpiral exposing (main)

import Color
import Html
import Render.Svg as Svg
import Turtle exposing (..)


iter : Int -> Float -> List Command
iter n dist =
    case n of
        0 ->
            []
        _ ->
            iter (n - 1) (dist + 2.5)
                |> (::) (Turn 89.5)
                |> (::) (Move dist)
                |> (::) (HueShift 1.0)


main : Html.Html msg
main =
    iter 200 1.0
        |> Branch
        |> List.singleton
        |> (::) (IncreaseRed 256.0)
        |> (::) (IncreaseGreen -256.0)
        |> (::) (IncreaseBlue -256.0)
        |> Branch
        |> Svg.render Color.darkCharcoal
