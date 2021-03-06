module Views.Shared.Alert exposing (annotation, annotationsButton, generatorUrlButton, titleView)

import Data.GettableAlert exposing (GettableAlert)
import Html exposing (Html, a, button, div, i, li, span, table, td, text, th, tr)
import Html.Attributes exposing (class, href, style)
import Html.Events exposing (onClick)
import Utils.Date exposing (dateTimeFormat)
import Utils.Views exposing (linkifyText)
import Views.Shared.Types exposing (Msg)


annotationsButton : Maybe String -> GettableAlert -> Html Msg
annotationsButton activeAlertId alert =
    if activeAlertId == Just alert.fingerprint then
        button
            [ onClick Nothing
            , class "btn btn-outline-info border-0 active"
            ]
            [ i [ class "fa fa-minus mr-2" ] [], text "Info" ]

    else
        button
            [ class "btn btn-outline-info border-0"
            , onClick (Just alert.fingerprint)
            ]
            [ i [ class "fa fa-plus mr-2" ] [], text "Info" ]


annotation : ( String, String ) -> Html msg
annotation ( key, value ) =
    tr []
        [ th [ class "text-nowrap" ] [ text (key ++ ":") ]
        , td [ class "w-100" ] (linkifyText value)
        ]


titleView : GettableAlert -> Html msg
titleView alert =
    let
        ( className, inhibited ) =
            if List.isEmpty alert.status.inhibitedBy then
                ( "text-muted", " (inhibited)" )

            else
                ( "", "" )
    in
    span
        [ class ("align-self-center mr-2 " ++ className) ]
        [ text
            (dateTimeFormat alert.startsAt
                ++ inhibited
            )
        ]


generatorUrlButton : String -> Html msg
generatorUrlButton url =
    a
        [ class "btn btn-outline-info border-0", href url ]
        [ i [ class "fa fa-line-chart mr-2" ] []
        , text "Source"
        ]
