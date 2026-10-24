module Test.Main exposing (suite)

import Html as H
import Main
import Test exposing (Test, describe, test)
import Test.Html.Event as Event
import Test.Html.Query as Query
import Test.Html.Selector as Sel


suite : Test
suite =
    describe "view"
        [ test "it displays the count" <|
            \_ ->
                Main.view 5
                    |> Query.fromHtml
                    |> Query.contains [ H.text "5" ]
        , test "clicking + sends Increment" <|
            \_ ->
                Main.view 5
                    |> Query.fromHtml
                    |> Query.find
                        [ Sel.tag "button"
                        , Sel.containing [ Sel.text "+" ]
                        ]
                    |> Event.simulate Event.click
                    |> Event.expect Main.Increment
        , test "clicking - sends Decrement" <|
            \_ ->
                Main.view 5
                    |> Query.fromHtml
                    |> Query.find
                        [ Sel.tag "button"
                        , Sel.containing [ Sel.text "-" ]
                        ]
                    |> Event.simulate Event.click
                    |> Event.expect Main.Decrement
        ]
