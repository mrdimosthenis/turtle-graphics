module Examples.Trivial exposing (main)

import Color
import Html
import Render.Svg as Svg
import Turtle exposing (..)


main : Html.Html msg
main =
    [ Move 300
    , Turn 90
    , Move 200
    , Turn 90
    , Move 300
    , Turn 45
    , Move 100
    , Turn 45
    , Move 100
    , Turn 45
    , Move 100
    , Turn 45
    , Move 100
    ]
        |> Branch
        |> toLines
        |> Svg.render Color.darkBlue
