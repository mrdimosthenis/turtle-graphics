module TurtleGrahpicsTests.CoreTests exposing (adjustLinesToEdgesTests, linesToEdgesTests, toLinesTests)

import Color
import Expect exposing (..)
import Test exposing (..)
import TurtleGraphics.Core exposing (..)


toLinesTests : Test
toLinesTests =
    describe "commands to lines"
        [ describe "flat"
            [ describe "single command"
                [ test "move" <|
                    \_ ->
                        Move 20
                            |> toLines
                            |> equal
                                [ { end = ( 20, 0 )
                                  , lineColor = Color.rgba 0 0 0 1
                                  , lineWidth = 1
                                  , start = ( 0, 0 )
                                  }
                                ]
                , test "move in branch" <|
                    \_ ->
                        [ Move 10 ]
                            |> Branch
                            |> toLines
                            |> equal
                                [ { end = ( 10, 0 )
                                  , lineColor = Color.rgba 0 0 0 1
                                  , lineWidth = 1
                                  , start = ( 0, 0 )
                                  }
                                ]
                , test "turn in branch" <|
                    \_ ->
                        Turn 90
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
                            |> Branch
                            |> toLines
                            |> equal
                                [ { end = ( 10, 0 )
                                  , lineColor = Color.rgba 0 0 0 1
                                  , lineWidth = 1
                                  , start = ( 0, 0 )
                                  }
                                , { end = ( 15, 0 )
                                  , lineColor = Color.rgba 0 0 0 1
                                  , lineWidth = 1
                                  , start = ( 10, 0 )
                                  }
                                , { end = ( 20, 0 )
                                  , lineColor = Color.rgba 0 0 0 1
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
                            |> Branch
                            |> toLines
                            |> equal
                                [ { end = ( 10, 0 )
                                  , lineColor = Color.rgba 0 0 0 1
                                  , lineWidth = 1
                                  , start = ( 0, 0 )
                                  }
                                , { end = ( 10, -5 )
                                  , lineColor = Color.rgba 0 0 0 1
                                  , lineWidth = 1
                                  , start = ( 10, 0 )
                                  }
                                ]
                , test "change rgb and move" <|
                    \_ ->
                        [ IncreaseRed 64
                        , Move 5
                        , IncreaseGreen 32
                        , Move 10
                        , IncreaseGreen 16
                        , Move 5
                        ]
                            |> Branch
                            |> toLines
                            |> equal
                                [ { end = ( 5, 0 )
                                  , lineColor = Color.rgba 1 0 0 1
                                  , lineWidth = 1
                                  , start = ( 0, 0 )
                                  }
                                , { end = ( 15, 0 )
                                  , lineColor = Color.rgba 1 1 0 1
                                  , lineWidth = 1
                                  , start = ( 5, 0 )
                                  }
                                , { end = ( 20, 0 )
                                  , lineColor = Color.rgba 1 1 0 1
                                  , lineWidth = 1
                                  , start = ( 15, 0 )
                                  }
                                ]
                ]
            ]
        , describe "nested"
            [ test "multiple branches" <|
                \_ ->
                    [ Move 10
                    , Branch
                        [ Turn 90
                        , Move 5
                        ]
                    , Branch
                        [ IncreaseWidth 0.15
                        , Move 5
                        ]
                    , Branch
                        [ RotateHue 0.18
                        , Move 5
                        ]
                    , Branch
                        [ IncreaseSaturation -0.15
                        , Move 5
                        ]
                    , Branch
                        [ IncreaseLightness -0.15
                        , Move 5
                        ]
                    , Branch
                        [ IncreaseAlpha -0.15
                        , Move 5
                        ]
                    , Branch
                        [ Move 50
                        , Branch
                            [ Turn 90
                            , Move 5
                            ]
                        , Branch
                            [ IncreaseWidth 0.15
                            , Move 5
                            ]
                        , Branch
                            [ RotateHue 0.18
                            , Move 5
                            ]
                        , Branch
                            [ IncreaseSaturation -0.15
                            , Move 5
                            ]
                        , Branch
                            [ IncreaseLightness -0.15
                            , Move 5
                            ]
                        , Branch
                            [ IncreaseAlpha -0.15
                            , Move 5
                            ]
                        ]
                    ]
                        |> Branch
                        |> toLines
                        |> equal
                            [ { end = ( 10, 0 )
                              , lineColor = Color.rgba 0 0 0 1
                              , lineWidth = 1
                              , start = ( 0, 0 )
                              }
                            , { end = ( 10, -5 )
                              , lineColor = Color.rgba 0 0 0 1
                              , lineWidth = 1
                              , start = ( 10, 0 )
                              }
                            , { end = ( 15, 0 )
                              , lineColor = Color.rgba 0 0 0 1
                              , lineWidth = 1.15
                              , start = ( 10, 0 )
                              }
                            , { end = ( 15, 0 )
                              , lineColor = Color.rgba 0 0 0 1
                              , lineWidth = 1
                              , start = ( 10, 0 )
                              }
                            , { end = ( 15, 0 )
                              , lineColor = Color.rgba 0 0 0 1
                              , lineWidth = 1
                              , start = ( 10, 0 )
                              }
                            , { end = ( 15, 0 )
                              , lineColor = Color.rgba 0 0 0 1
                              , lineWidth = 1
                              , start = ( 10, 0 )
                              }
                            , { end = ( 15, 0 )
                              , lineColor = Color.rgba 0 0 0 0.85
                              , lineWidth = 1
                              , start = ( 10, 0 )
                              }
                            , { end = ( 60, 0 )
                              , lineColor = Color.rgba 0 0 0 1
                              , lineWidth = 1
                              , start = ( 10, 0 )
                              }
                            , { end = ( 60, -5 )
                              , lineColor = Color.rgba 0 0 0 1
                              , lineWidth = 1
                              , start = ( 60, 0 )
                              }
                            , { end = ( 65, 0 )
                              , lineColor = Color.rgba 0 0 0 1
                              , lineWidth = 1.15
                              , start = ( 60, 0 )
                              }
                            , { end = ( 65, 0 )
                              , lineColor = Color.rgba 0 0 0 1
                              , lineWidth = 1
                              , start = ( 60, 0 )
                              }
                            , { end = ( 65, 0 )
                              , lineColor = Color.rgba 0 0 0 1
                              , lineWidth = 1
                              , start = ( 60, 0 )
                              }
                            , { end = ( 65, 0 )
                              , lineColor = Color.rgba 0 0 0 1
                              , lineWidth = 1
                              , start = ( 60, 0 )
                              }
                            , { end = ( 65, 0 )
                              , lineColor = Color.rgba 0 0 0 0.85
                              , lineWidth = 1
                              , start = ( 60, 0 )
                              }
                            ]
            ]
        ]


linesToEdgesTests : Test
linesToEdgesTests =
    describe "lines to edges"
        [ test "single test" <|
            \_ ->
                [ { end = ( 10, 0 )
                  , lineColor = Color.gray
                  , lineWidth = 1
                  , start = ( 0, 0 )
                  }
                , { end = ( -20, 0 )
                  , lineColor = Color.gray
                  , lineWidth = 1
                  , start = ( 10, 0 )
                  }
                , { end = ( -20, 30 )
                  , lineColor = Color.gray
                  , lineWidth = 1
                  , start = ( -20, 0 )
                  }
                , { end = ( -20, -25 )
                  , lineColor = Color.gray
                  , lineWidth = 1
                  , start = ( -20, 30 )
                  }
                ]
                    |> linesToEdges
                    |> equal (Edges -20 10 -25 30)
        ]


adjustLinesToEdgesTests : Test
adjustLinesToEdgesTests =
    describe "change the coordinates in order to be centered"
        [ test "single test" <|
            \_ ->
                [ { end = ( 10, 0 )
                  , lineColor = Color.gray
                  , lineWidth = 1
                  , start = ( 0, 0 )
                  }
                , { end = ( -20, 0 )
                  , lineColor = Color.gray
                  , lineWidth = 1
                  , start = ( 10, 0 )
                  }
                , { end = ( -20, 30 )
                  , lineColor = Color.gray
                  , lineWidth = 1
                  , start = ( -20, 0 )
                  }
                , { end = ( -20, -25 )
                  , lineColor = Color.gray
                  , lineWidth = 1
                  , start = ( -20, 30 )
                  }
                ]
                    |> adjustLinesToEdges (Edges -20 10 -25 30)
                    |> equal
                        [ { end = ( 30, 25 )
                          , lineColor = Color.gray
                          , lineWidth = 1
                          , start = ( 20, 25 )
                          }
                        , { end = ( 0, 25 )
                          , lineColor = Color.gray
                          , lineWidth = 1
                          , start = ( 30, 25 )
                          }
                        , { end = ( 0, 55 )
                          , lineColor = Color.gray
                          , lineWidth = 1
                          , start = ( 0, 25 )
                          }
                        , { end = ( 0, 0 )
                          , lineColor = Color.gray
                          , lineWidth = 1
                          , start = ( 0, 55 )
                          }
                        ]
        ]
