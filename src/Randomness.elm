module Randomness exposing (..)

import Browser
import Html exposing (..)
import Html.Events exposing (..)
import Random


-- MAIN

main =
  Browser.element
  { init = init
  , update = update
  , subscriptions = subscriptions
  , view = view
  }


-- MODEL

type alias Model =
 { dieFace : Int,
   faceValue: String
 }

init : () -> (Model, Cmd Msg)

init _ =
  ( Model 1 "one", Cmd.none)


-- UPDATE

type Msg = Roll | NewFace Int


update : Msg -> Model -> (Model, Cmd Msg)

update msg model =
  case msg of
    Roll ->
      ( model, Random.generate NewFace (Random.int 1 6) )
    
    NewFace newFace ->
      case newFace of
        1 ->
          ( Model newFace, Cmd.none)
        2 ->
          ( Model newFace, Cmd.none)
        3 ->
          ( Model newFace, Cmd.none)
        4 ->
          ( Model newFace, Cmd.none)
        5 ->
          ( Model newFace, Cmd.none)
        6 ->
          ( Model newFace, Cmd.none)
          


-- SUBSCRIPTIONS

subscriptions : Model -> Sub Msg

subscriptions model =
  Sub.none


-- VIEW

view : Model -> Html Msg

view model =
  div []
    [ h1 [] [text (String.fromInt model.dieFace) ]
    , button [ onClick Roll ] [text "Roll" ]
    ]
