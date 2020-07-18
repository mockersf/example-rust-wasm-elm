port module Wasm exposing (addCall, addReturn, getMoviesCall, getMoviesReturn, subscriptions, wasmReady)

import Model
import Msg exposing (Msg(..))


port addCall : ( Int, Int ) -> Cmd msg


port addReturn : (Int -> msg) -> Sub msg


port getMoviesCall : () -> Cmd msg


port getMoviesReturn : (List Model.Movie -> msg) -> Sub msg


port wasmReady : (Bool -> msg) -> Sub msg


subscriptions : a -> Sub Msg.Msg
subscriptions _ =
    Sub.batch
        [ wasmReady WasmReady
        , addReturn AddResult
        , getMoviesReturn GotMovies
        ]
