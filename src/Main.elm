module Main exposing (..)

import Browser
import Browser.Dom as Dom
import Html exposing (Html, div, text)
import Html.Attributes exposing (id, style, tabindex)
import Keyboard exposing (Key(..))
import Keyboard.Events as Keyboard
import Snake exposing (Coordinate, Direction(..), move)
import Task
import Time


main =
    Browser.element
        { init = init
        , update = update
        , view = view
        , subscriptions = subscriptions
        }


type alias Flags =
    {}


type alias Model =
    { count : Int
    , head : Coordinate
    , bodyParts : List Coordinate
    }


type Msg
    = Increment
    | Decrement
    | Steer Direction
    | Tick Time.Posix
    | NoOp


subscriptions : Model -> Sub Msg
subscriptions _ =
    Time.every 1000 Tick


init : Flags -> ( Model, Cmd Msg )
init _ =
    ( { count = 0
      , head = { x = 10, y = 10 }
      , bodyParts = [ { x = 8, y = 10 }, { x = 9, y = 10 } ]
      }
    , Dom.focus "app-div" |> Task.attempt (always NoOp)
    )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Increment ->
            ( model, Cmd.none )

        Decrement ->
            ( { model | count = model.count - 1 }, Cmd.none )

        NoOp ->
            ( model, Cmd.none )

        Steer dir ->
            ( { model | head = move dir model.head }, Cmd.none )

        Tick _ ->
            ( {model|count = model.count + 1}, Cmd.none )


viewCell color { x, y } =
    div
        [ style "background-color" color
        , style "position" "absolute"
        , style "width" "10px"
        , style "height" "10px"
        , style "left" (String.fromInt (10 * x) ++ "px")
        , style "top" (String.fromInt (10 * y) ++ "px")
        ]
        [ text " " ]


drawHead =
    viewCell "orange"


view : Model -> Html Msg
view model =
    div
        [ style "height" "500px"
        , style "width" "500px"
        , style "background-color" "gray"
        , style "position" "relative"
        , tabindex 0
        , id "app-div"
        , Keyboard.on Keyboard.Keydown
            [ ( ArrowLeft, Steer Left )
            , ( ArrowRight, Steer Right )
            , ( ArrowUp, Steer Up )
            , ( ArrowDown, Steer Down )
            ]
        ]
        ([ Html.text (String.fromInt model.count), drawHead model.head ] ++ List.map (viewCell "white") model.bodyParts)
