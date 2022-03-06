module SnakeTest exposing (..)

import Expect exposing (Expectation)
import Test exposing (..)
import Snake exposing (Direction(..), snakeStep)

suite : Test
suite =
    describe "Snake Behaviour"
        [ test "2 cell snake test one step right" <|
            \_ ->
                let
                    snakeBefore =
                        { heading=Right
                        , head={x=1, y=2}
                        , body=[{x=0, y=2}]
                        }
                    expected =
                        { heading=Right
                        , head={x=2, y=2}
                        , body=[{x=1, y=2}]
                        }
                in
                Expect.equal expected (snakeStep snakeBefore)
        , test "2 cell snake test one step down" <|
                      \_ ->
                          let
                              snakeBefore =
                                  { heading=Down
                                  , head={x=1, y=2}
                                  , body=[{x=0, y=2}]
                                  }
                              expected =
                                  { heading=Down
                                  , head={x=1, y=3}
                                  , body=[{x=1, y=2}]
                                  }
                          in
                          Expect.equal expected (snakeStep snakeBefore)
        ]
