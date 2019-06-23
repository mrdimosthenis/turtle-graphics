module TurtleTests exposing (toLinesTests)

import Color
import Expect exposing (..)
import Test exposing (..)
import Turtle exposing (..)


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
                                  , lineColor = Color.gray
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
                                  , lineColor = Color.gray
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
                                  , lineColor = Color.gray
                                  , lineWidth = 1
                                  , start = ( 0, 0 )
                                  }
                                , { end = ( 15, 0 )
                                  , lineColor = Color.gray
                                  , lineWidth = 1
                                  , start = ( 10, 0 )
                                  }
                                , { end = ( 20, 0 )
                                  , lineColor = Color.gray
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
                                  , lineColor = Color.gray
                                  , lineWidth = 1
                                  , start = ( 0, 0 )
                                  }
                                , { end = ( 10, -5 )
                                  , lineColor = Color.gray
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
                                  , lineColor = Color.rgba 64.82745098039216 0.8431372549019608 0.8117647058823529 1
                                  , lineWidth = 1
                                  , start = ( 0, 0 )
                                  }
                                , { end = ( 15, 0 )
                                  , lineColor = Color.rgba 64.82745098039216 32.84313725490196 0.8117647058823529 1
                                  , lineWidth = 1
                                  , start = ( 5, 0 )
                                  }
                                , { end = ( 20, 0 )
                                  , lineColor = Color.rgba 64.82745098039216 48.84313725490196 0.8117647058823529 1
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
                        [ IncreaseWidth 0.5
                        , Move 5
                        ]
                    , Branch
                        [ HueShift 180
                        , Move 5
                        ]
                    , Branch
                        [ IncreaseSaturation -0.5
                        , Move 5
                        ]
                    , Branch
                        [ IncreaseLightness -0.5
                        , Move 5
                        ]
                    , Branch
                        [ IncreaseAlpha -0.5
                        , Move 5
                        ]
                    , Branch
                        [ Move 50
                        , Branch
                            [ Turn 90
                            , Move 5
                            ]
                        , Branch
                            [ IncreaseWidth 0.5
                            , Move 5
                            ]
                        , Branch
                            [ HueShift 180
                            , Move 5
                            ]
                        , Branch
                            [ IncreaseSaturation -0.5
                            , Move 5
                            ]
                        , Branch
                            [ IncreaseLightness -0.5
                            , Move 5
                            ]
                        , Branch
                            [ IncreaseAlpha -0.5
                            , Move 5
                            ]
                        ]
                    ]
                        |> Branch
                        |> toLines
                        |> equal
                            [ { end = ( 10, 0 )
                              , lineColor = Color.gray
                              , lineWidth = 1
                              , start = ( 0, 0 )
                              }
                            , { end = ( 10, -5 )
                              , lineColor = Color.gray
                              , lineWidth = 1
                              , start = ( 10, 0 )
                              }
                            , { end = ( 15, 0 )
                              , lineColor = Color.gray
                              , lineWidth = 1.5
                              , start = ( 10, 0 )
                              }
                            , { end = ( 15, 0 )
                              , lineColor = Color.rgba 0.8117647058823528 0.8117647058823528 0.8117647058823528 1
                              , lineWidth = 1
                              , start = ( 10, 0 )
                              }
                            , { end = ( 15, 0 )
                              , lineColor = Color.rgba 0.8274509803921568 0.8274509803921568 0.8274509803921568 1
                              , lineWidth = 1
                              , start = ( 10, 0 )
                              }
                            , { end = ( 15, 0 )
                              , lineColor = Color.rgba 0.3274509803921567 0.3572192513368983 0.2976827094474153 1
                              , lineWidth = 1
                              , start = ( 10, 0 )
                              }
                            , { end = ( 15, 0 )
                              , lineColor = Color.rgba 0.8274509803921568 0.8431372549019608 0.8117647058823528 0.5
                              , lineWidth = 1
                              , start = ( 10, 0 )
                              }
                            , { end = ( 60, 0 )
                              , lineColor = Color.gray
                              , lineWidth = 1
                              , start = ( 10, 0 )
                              }
                            , { end = ( 60, -5 )
                              , lineColor = Color.gray
                              , lineWidth = 1
                              , start = ( 60, 0 )
                              }
                            , { end = ( 65, 0 )
                              , lineColor = Color.gray
                              , lineWidth = 1.5
                              , start = ( 60, 0 )
                              }
                            , { end = ( 65, 0 )
                              , lineColor = Color.rgba 0.8117647058823528 0.8117647058823528 0.8117647058823528 1
                              , lineWidth = 1
                              , start = ( 60, 0 )
                              }
                            , { end = ( 65, 0 )
                              , lineColor = Color.rgba 0.8274509803921568 0.8274509803921568 0.8274509803921568 1
                              , lineWidth = 1
                              , start = ( 60, 0 )
                              }
                            , { end = ( 65, 0 )
                              , lineColor = Color.rgba 0.3274509803921567 0.3572192513368983 0.2976827094474153 1
                              , lineWidth = 1
                              , start = ( 60, 0 )
                              }
                            , { end = ( 65, 0 )
                              , lineColor = Color.rgba 0.8274509803921568 0.8431372549019608 0.8117647058823528 0.5
                              , lineWidth = 1
                              , start = ( 60, 0 )
                              }
                            ]
            ]
        ]
