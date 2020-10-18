module Timeliness exposing (..)

import Browser
import Html exposing (..)
import Html.Events exposing (onClick)
import Html.Attributes exposing (style)
import Task
import Time

-- main

main = 
  Browser.element
  { init = init
  , view = view
  , update = update
  , subscriptions = subscriptions
  }

-- model

type alias Model =
 { zone : Time.Zone
 , time : Time.Posix
 , pause : Bool
 }

init : () -> (Model, Cmd Msg)

init _ =
  ( Model Time.utc (Time.millisToPosix 0) False
  , Task.perform AdjustTimeZone Time.here
  )

-- update

type Msg = Tick Time.Posix | AdjustTimeZone Time.Zone | Pause | Resume

update : Msg -> Model -> (Model, Cmd Msg)

update msg model =
  case msg of
    Tick newTime ->
      ( { model | time = newTime },
      Cmd.none)

    AdjustTimeZone newZone ->
      ( { model | zone = newZone }, Cmd.none)

    Pause ->
      ( { model | pause = True }, Cmd.none )

    Resume ->
      ( { model | pause = False }, Cmd.none )


-- subscriptions


subscriptions : Model -> Sub Msg

subscriptions model =
  if model.pause then
    Sub.none
  else
    Time.every 1000 Tick

-- view

view : Model -> Html Msg

view model = 
  let 
    hour = String.fromInt (Time.toHour model.zone model.time)
    minute = String.fromInt(Time.toMinute model.zone model.time)
    second = String.fromInt (Time.toSecond model.zone model.time)

  in
  div []
    [ h1 [ style "color" "red" ] [ text (hour ++ ":" ++ minute ++ ":" ++ second) ],
      button [ onClick Pause, style "border" "5 px" ] [ text "Pause" ],
      button [ onClick Resume, style "border" "5 px" ] [ text "Resume" ]
    ]
