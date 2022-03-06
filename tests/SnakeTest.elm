module SnakeTest exposing (..)

import Expect exposing (Expectation)
import Test exposing (..)


suite : Test
suite =
    describe "Snake Behaviour"
        [ test "has no effect on a palindrome" <|
            \_ ->
                let
                    palindrome =
                        "hannah"
                in
                Expect.equal palindrome (String.reverse palindrome)
        ]
