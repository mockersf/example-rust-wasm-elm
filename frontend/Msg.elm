module Msg exposing (Msg(..))

import Browser exposing (UrlRequest(..))
import Model exposing (Movie)
import Url


type Msg
    = LinkClicked UrlRequest
    | UrlChange Url.Url
    | WasmReady Bool
    | SetA Int
    | SetB Int
    | Add
    | AddResult Int
    | GotMovies (List Movie)
