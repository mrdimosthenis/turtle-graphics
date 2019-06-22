module TurtleTests exposing (toLinesTests)

import Color
import Expect exposing (..)
import Test exposing (..)
import Turtle exposing (..)


toLinesTests : Test
toLinesTests =
    describe "flat"
        [ describe "single command"
            [ test "move" <|
                \_ ->
                    [ Move 10 ]
                        |> toLines
                        |> equal
                            [ { end = ( 10, 0 )
                              , lineColor = Color.black
                              , lineWidth = 1
                              , start = ( 0, 0 )
                              }
                            ]
            , test "turn" <|
                \_ ->
                    [ Turn 90 ]
                        |> toLines
                        |> equal
                            []
            ]
        , describe "multiple commands"
            [ test "move" <|
                \_ ->
                    [ Move 10
                    , Move 5
                    , Move 5
                    ]
                        |> toLines
                        |> equal
                            [ { end = ( 10, 0 )
                              , lineColor = Color.black
                              , lineWidth = 1
                              , start = ( 0, 0 )
                              }
                            , { end = ( 15, 0 )
                              , lineColor = Color.black
                              , lineWidth = 1
                              , start = ( 10, 0 )
                              }
                            , { end = ( 20, 0 )
                              , lineColor = Color.black
                              , lineWidth = 1
                              , start = ( 15, 0 )
                              }
                            ]
            , test "move and turn" <|
                \_ ->
                    [ Move 10
                    , Turn 90
                    , Move 5
                    ]
                        |> toLines
                        |> equal
                            [ { end = ( 10, 0 )
                              , lineColor = Color.black
                              , lineWidth = 1
                              , start = ( 0, 0 )
                              }
                            , { end = ( 10, 5 )
                              , lineColor = Color.black
                              , lineWidth = 1
                              , start = ( 10, 0 )
                              }
                            ]
            ]
        ]
