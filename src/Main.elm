module Main exposing (..)

import Browser
import Browser.Dom as Dom
import Html exposing (Html, div, text)
import Html.Attributes exposing (id, style, tabindex)
import Keyboard exposing (Key(..))
import Keyboard.Events as Keyboard
import Snake exposing (Coordinate, Direction(..), Snake, snakeStep)
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


type Model
    = Game GameData
    | GameOver


type alias GameData =
    { count : Int
    , snake : Snake
    }


type Msg
    = Steer Direction
    | Tick Time.Posix
    | NoOp


subscriptions : Model -> Sub Msg
subscriptions _ =
    Time.every 1000 Tick


initialSnake =
    { heading = Right
    , head = { x = 10, y = 10 }
    , body = [ { x = 9, y = 10 }, { x = 8, y = 10 } ]
    }


init : Flags -> ( Model, Cmd Msg )
init _ =
    ( Game
        { count = 0
        , snake = initialSnake
        }
    , Dom.focus "app-div" |> Task.attempt (always NoOp)
    )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case model of
        GameOver ->
            ( model, Cmd.none )

        Game gameData ->
            case msg of
                NoOp ->
                    ( model, Cmd.none )

                Steer dir ->
                    let
                        oldSnake =
                            gameData.snake

                        newSnake =
                            { oldSnake | heading = dir }
                    in
                    ( Game { gameData | snake = newSnake }, Cmd.none )

                Tick _ ->
                    let
                        newSnake = snakeStep gameData.snake
                    in
                        ( Game
                            { gameData
                                | count = gameData.count + 1
                                , snake = newSnake
                            }
                        , Cmd.none
                        )


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


view : Model -> Html Msg
view model =
    let
        enclosingDivAttribs =
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
    in
    case model of
        Game gameData ->
            div
                enclosingDivAttribs
                (Html.text (String.fromInt gameData.count)
                    :: viewCell "lightgray" gameData.snake.head
                    :: List.map (viewCell "pink") gameData.snake.body
                )

        GameOver ->
            div enclosingDivAttribs [ Html.text "Game Over" ]
