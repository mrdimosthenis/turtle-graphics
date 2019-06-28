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
            iter (n - 1) (dist + 1.5)
                |> (::) (Turn 89.5)
                |> (::) (Move dist)


main : Html.Html msg
main =
    iter 300 1.0
        |> Branch
        |> toLines
        |> Svg.render Color.darkCharcoal
