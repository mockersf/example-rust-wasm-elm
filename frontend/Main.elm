module Main exposing (main)

import Browser exposing (UrlRequest(..))
import Browser.Navigation as Nav
import Model exposing (CurrentView(..), Model)
import Msg exposing (Msg(..))
import Url
import View exposing (view)
import Wasm


init : () -> Url.Url -> Nav.Key -> ( Model, Cmd Msg )
init a url key =
    ( Model.init a url key
    , Cmd.none
    )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        LinkClicked _ ->
            ( model, Cmd.none )

        UrlChange url ->
            ( { model | view = Model.urlToView url }, Cmd.none )

        Add ->
            ( model
            , Wasm.addCall ( model.a, model.b )
            )

        SetA a ->
            ( { model | a = a }, Cmd.none )

        SetB b ->
            ( { model | b = b }, Cmd.none )

        WasmReady ready ->
            ( { model
                | wasm_ready = ready
              }
            , Wasm.getMoviesCall ()
            )

        AddResult return ->
            ( { model
                | res = return
              }
            , Cmd.none
            )

        GotMovies return ->
            ( { model | movies = return }, Cmd.none )


main : Program () Model Msg
main =
    Browser.application
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        , onUrlRequest = LinkClicked
        , onUrlChange = UrlChange
        }


subscriptions : Model -> Sub Msg
subscriptions a =
    Wasm.subscriptions a
