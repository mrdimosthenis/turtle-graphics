module Examples.Trivial exposing (..)

import Color
import Html
import Turtle exposing (..)
import Render.Svg as Svg


main : Html.Html msg
main =
    [ Move 300
    , Turn 90
    , Move 300
    , Turn 90
    , Move 300
    , Turn 45
    , Move 100
    ]
        |> Branch
        |> toLines
        |> Svg.render Color.green
