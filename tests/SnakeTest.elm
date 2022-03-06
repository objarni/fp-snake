module SnakeTest exposing (..)

import Expect exposing (Expectation)
import Test exposing (..)
import Snake exposing (Direction(..), snakeStep)

suite : Test
suite =
    describe "Snake Behaviour"
        [ test "2 cell snake test one step" <|
            \_ ->
                let
                    snakeBefore =
                        { direction=Right
                        , head={x=1, y=2}
                        , body=[{x=0, y=2}]
                        }
                    expected =
                        { direction=Right
                        , head={x=2, y=2}
                        , body=[{x=1, y=2}]
                        }
                in
                Expect.equal expected (snakeStep snakeBefore)
        ]
