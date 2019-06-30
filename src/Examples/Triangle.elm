module Examples.Triangle exposing (main)

import Color
import Html
import TurtleGraphics exposing (..)


main : Html.Html msg
main =
    [ move 100
    , turn 120
    , move 100
    , turn 120
    , move 100
    ]
        |> branch
        |> render Color.white
