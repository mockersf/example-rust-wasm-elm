module View exposing (view)

import Browser exposing (UrlRequest(..))
import Html exposing (Html, button, div, input, text)
import Html.Attributes exposing (style, type_, value)
import Html.Events exposing (onClick, onInput)
import Model exposing (CurrentView(..), Model, Movie)
import Msg exposing (Msg(..))


view : Model -> Browser.Document Msg
view model =
    Browser.Document
        "Tests"
        [ div [ style "display" "flex" ]
            [ input [ type_ "text", value (String.fromInt model.a), onInput (\val -> SetA (Maybe.withDefault 0 (String.toInt val))) ]
                []
            , text " + 2 * "
            , input
                [ type_ "text", value (String.fromInt model.b), onInput (\val -> SetB (Maybe.withDefault 0 (String.toInt val))) ]
                []
            , button [ onClick Add ] [ text "=" ]
            , div [] [ text (String.fromInt model.res) ]
            ]
        , div [] (List.map viewMovie model.movies)
        ]


viewMovie : Movie -> Html Msg
viewMovie movie =
    div [ style "display" "flex" ]
        [ div [] [ text movie.title ]
        , div [] [ text "-" ]
        , div [] [ text movie.description ]
        , div [] [ text "-" ]
        , div [] [ text (String.fromFloat movie.rating) ]
        ]
