import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput)
import Regex


main =
  Html.beginnerProgram
    { model = model
    , view = view
    , update = update
    }



-- MODEL


type alias Model =
  { name : String
  , password : String
  , passwordAgain : String
  }


model : Model
model =
  Model "" "" ""



-- UPDATE


type Msg
    = Name String
    | Password String
    | PasswordAgain String


update : Msg -> Model -> Model
update msg model =
  case msg of
    Name name ->
      { model | name = name }

    Password password ->
      { model | password = password }

    PasswordAgain password ->
      { model | passwordAgain = password }



-- VIEW


view : Model -> Html Msg
view model =
  div []
    [ input [ type_ "text", placeholder "Name", onInput Name ] []
    , input [ type_ "password", placeholder "Password", onInput Password ] []
    , input [ type_ "password", placeholder "Re-enter Password", onInput PasswordAgain ] []
    , viewValidation model
    ]


viewValidation : Model -> Html msg
viewValidation model =
  let
    (color, message) =
      if (String.length model.password) < 8 then
        ("red", "password less than 8 chars")
      else if not (Regex.contains (Regex.regex "[0-9]") model.password)  || 
        not (Regex.contains (Regex.regex "[a-z]") model.password) || 
        not (Regex.contains (Regex.regex  "[A-Z]") model.password) then
        ("orange", "password must contain digits, uppercase, lowercase")
      else if model.password == model.passwordAgain then
        ("green", "OK")
      else
        ("red", "Passwords do not match!")
  in
    div [ style [("color", color)] ] [ text message ]
