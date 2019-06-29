module TurtleGraphics.Render exposing (lineToSvg, render)

import Color
import Html
import TurtleGraphics.Core as Turtle
import TypedSvg
import TypedSvg.Attributes as Attr
import TypedSvg.Attributes.InPx as PxAttr
import TypedSvg.Core as SvgCore
import TypedSvg.Types as SvgTypes


lineToSvg : Turtle.Line -> SvgCore.Svg msg
lineToSvg line =
    let
        { start, end, lineWidth, lineColor } =
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


render : Color.Color -> Turtle.Command -> Html.Html msg
render color command =
    let
        lines =
            Turtle.toLines command

        ({ minX, maxX, minY, maxY } as edges) =
            Turtle.linesToEdges lines

        width =
            maxX - minX

        height =
            maxY - minY
    in
    lines
        |> Turtle.adjustLinesToEdges edges
        |> List.map lineToSvg
        |> (::)
            (TypedSvg.rect
                [ Attr.fill (SvgTypes.Fill color)
                , PxAttr.width width
                , PxAttr.height height
                ]
                []
            )
        |> TypedSvg.svg
            [ PxAttr.width width
            , PxAttr.height height
            ]
