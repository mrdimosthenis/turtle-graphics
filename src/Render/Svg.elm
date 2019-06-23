module Render.Svg exposing (..)

import Color
import Html
import Turtle
import TypedSvg
import TypedSvg.Attributes as Attr
import TypedSvg.Attributes.InPx as PxAttr
import TypedSvg.Core as SvgCore
import TypedSvg.Types as SvgTypes


lineToSvg : Turtle.Line -> SvgCore.Svg msg
lineToSvg line =
    let
        {start, end, lineWidth, lineColor } =
            line
    in
    TypedSvg.line
        [ PxAttr.x1 (Tuple.first start)
        , PxAttr.x2 (Tuple.first end)
        , PxAttr.y1 (Tuple.second start)
        , PxAttr.y2 (Tuple.second end)
        , PxAttr.strokeWidth lineWidth
        , Attr.stroke lineColor
        ]
        []


render : Color.Color -> List Turtle.Line -> Html.Html msg
render background lines =
    let ({width, height } as edges) =
            Turtle.linesToEdges lines
    in
    lines
        |> Turtle.adjustLinesToEdges edges
        |> List.map lineToSvg
        |> TypedSvg.svg
                   [ Attr.fill (SvgTypes.Fill background)
                   , PxAttr.width width
                   , PxAttr.height height
                   ]
