module Model exposing (CurrentView(..), Model, Movie, init, urlToView)

import Browser exposing (UrlRequest(..))
import Browser.Navigation as Nav
import Url
import Url.Parser as Url exposing ((</>), Parser)


type alias Model =
    { nav_key : Nav.Key
    , view : CurrentView
    , wasm_ready : Bool
    , a : Int
    , b : Int
    , res : Int
    , movies : List Movie
    }


init : () -> Url.Url -> Nav.Key -> Model
init _ url key =
    Model
        key
        (urlToView url)
        False
        0
        0
        0
        []


type alias Movie =
    { title : String
    , description : String
    , rating : Float
    }


type CurrentView
    = TestView


urlToView : Url.Url -> CurrentView
urlToView url =
    url
        |> Url.parse urlParser
        |> Maybe.withDefault TestView


urlParser : Parser (CurrentView -> a) a
urlParser =
    Url.oneOf
        [ Url.map TestView (Url.s "ui" </> Url.s "tests")
        ]
