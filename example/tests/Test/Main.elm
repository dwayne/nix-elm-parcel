module Test.Main exposing (suite)

import Main
import Test exposing (Test, describe, test)
import Test.Html.Query as Query
import Test.Html.Selector as Sel


suite : Test
suite =
    describe "main"
        [ test "it displays the correct greeting" <|
            \_ ->
                Main.main
                    |> Query.fromHtml
                    |> Query.has
                        [ Sel.exactText "Hello, world!"
                        ]
        ]
