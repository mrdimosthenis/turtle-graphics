module Examples.VerticalTriangles exposing (main, triangle)

import Color
import Html
import TurtleGraphics exposing (..)


triangle : Command
triangle =
    branch
        [ move 100
        , turn 120
        , move 100
        , turn 120
        , move 100
        ]


main : Html.Html msg
main =
    [ triangle
    , turn 180
    , triangle
    ]
        |> branch
        |> render Color.white
