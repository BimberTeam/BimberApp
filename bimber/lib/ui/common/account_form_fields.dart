import 'package:bimber/models/alcohol_type.dart';
import 'package:bimber/models/gender.dart';
import 'package:bimber/ui/common/custom_form_builder_image_picker.dart';
import 'package:bimber/ui/common/theme.dart';
import 'package:flutter/material.dart';
import 'package:bimber/ui/common/language_utils.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

typedef GenderValidator = String Function(dynamic);
typedef AlcoholTypeValidator = String Function(dynamic);

class AccountFormField {
  static final emailField = FormBuilderTextField(
    maxLines: 1,
    attribute: "email",
    decoration: InputDecoration(labelText: "Email", icon: Icon(Icons.email)),
    validators: [
      FormBuilderValidators.email(errorText: "Nieprawidłowy format email"),
    ],
  );

  static final nameField = FormBuilderTextField(
    attribute: "name",
    maxLines: 1,
    decoration: InputDecoration(
        labelText: "Nazwa",
        hintText: "Nazwa pod jaką cię widać",
        icon: Icon(Icons.person_outline)),
    validators: [
      FormBuilderValidators.pattern("[a-zA-Z ]",
          errorText: "Twoja nazwa może skłądać się tylko z liter"),
      FormBuilderValidators.minLength(3,
          errorText: "Prawdzia osoba zaczyna się od 3 znaków"),
      FormBuilderValidators.maxLength(15,
          errorText: "Myślisz, że komuś chce się to czytać?"),
    ],
  );

  static final passwordField = FormBuilderTextField(
    attribute: "password",
    maxLines: 1,
    obscureText: true,
    decoration: InputDecoration(
        labelText: "Hasło",
        hintText: "Wybierz dobrze",
        icon: Icon(Icons.lock_outline)),
    validators: [
      FormBuilderValidators.minLength(6, errorText: "Użyj conajmniej 6 znaków"),
      FormBuilderValidators.maxLength(30,
          errorText: "Na pewno zapamiętasz tyle znkaów?"),
    ],
  );

  static final confirmPassowrdField = (key) => FormBuilderTextField(
        attribute: "confirmPassword",
        maxLines: 1,
        obscureText: true,
        decoration: InputDecoration(
            labelText: "Powtórz hasło",
            hintText: "Musi być takie samo",
            icon: Icon(Icons.lock_outline)),
        validators: [
          (value) {
            if (value !=
                key.currentState.fields['password'].currentState.value) {
              return "Hasła się nie zgadzają";
            }
            return null;
          }
        ],
      );

  static final genderField = FormBuilderDropdown<Gender>(
      attribute: "gender",
      decoration: InputDecoration(labelText: "Płeć", icon: Icon(Icons.wc)),
      hint: Text('Określ swoją płeć'),
      items: Gender.values
          .map((gender) => DropdownMenuItem<Gender>(
              value: gender, child: Text(gender.readable())))
          .toList(),
      validators: <GenderValidator>[
        FormBuilderValidators.required(errorText: "Podaj płeć")
      ]);

  static final ageField = FormBuilderTextField(
    attribute: "age",
    keyboardType: TextInputType.number,
    maxLines: 1,
    decoration:
        InputDecoration(labelText: "Wiek", icon: Icon(Icons.calendar_today)),
    validators: [
      FormBuilderValidators.required(errorText: "Zapomniałeś o czymś?"),
      FormBuilderValidators.numeric(),
      FormBuilderValidators.min(18, errorText: "Musisz być pełnoletni!"),
      FormBuilderValidators.max(99,
          errorText: "Przy takim wieku może lepiej zostać w domu?"),
    ],
  );

  static final descriptionPlaceholder = """
  Dobry opis zwiększa twoją szansę na znalezienie bratnich dusz do picia! 
  Nie zapominaj, niestosowny opis grozi banem.
  """;

  static final descriptionField = FormBuilderTextField(
    minLines: 3,
    maxLines: 5,
    attribute: "description",
    maxLength: 300,
    decoration: InputDecoration(
        border: new OutlineInputBorder(
            borderSide: new BorderSide(color: orangeSoda)),
        labelText: "Opis",
        hintText: descriptionPlaceholder),
    validators: [
      FormBuilderValidators.minLength(10,
          errorText: "Na prawdę? Minimum 10 znaków!"),
      FormBuilderValidators.maxLength(300, errorText: "Wow, to trochę za dużo!")
    ],
  );

  static final genderPreferenceField = FormBuilderDropdown<Gender>(
    attribute: "genderPreference",
    decoration:
        InputDecoration(labelText: "Preferowana płeć", icon: Icon(Icons.wc)),
    hint: Text("Z kim chcesz balować?"),
    items: Gender.values
        .map((gender) => DropdownMenuItem<Gender>(
            value: gender, child: Text(gender.readable())))
        .toList()
          ..add(
              DropdownMenuItem<Gender>(value: null, child: Text("Ktokolwiek"))),
  );

  static final alcoholPreferenceField = FormBuilderDropdown<AlcoholType>(
      attribute: "alcoholPreference",
      decoration: InputDecoration(
          labelText: "Ulubiony rodzaj alkoholu", icon: Icon(Icons.local_bar)),
      hint: Text("Wybierz rozsądnie"),
      items: AlcoholType.values
          .map((type) => DropdownMenuItem<AlcoholType>(
              value: type, child: Text(type.readable())))
          .toList(),
      validators: <AlcoholTypeValidator>[
        FormBuilderValidators.required(errorText: "Nic nie pijesz?")
      ]);

  static final alcoholNameField = FormBuilderTextField(
    attribute: "alcoholName",
    maxLines: 1,
    decoration: InputDecoration(
        hintText: "Twój ulubiony trunek",
        labelText: "Napój Bogów",
        icon: Icon(Icons.local_bar)),
    validators: [
      FormBuilderValidators.required(errorText: "Pochawl się!"),
      FormBuilderValidators.minLength(3,
          errorText: "Czy coś takiego w ogóle istnieje?"),
      FormBuilderValidators.maxLength(30,
          errorText: "Komu chce się to czytać?"),
    ],
  );

  static final imagePicker = (Size size) => CustomFormBuilderImagePicker(
        imageDecoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
        decoration: InputDecoration(
            labelText: "Avatar",
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(30))),
        maxImages: 1,
        imageWidth: size.width * 4 / 5,
        imageHeight: size.height * 3 / 5,
        attribute: "imageUrl",
        cameraIcon: Icon(Icons.camera_alt),
        iconColor: Colors.black,
        validators: [
          FormBuilderValidators.required(errorText: "Bez zdjęcie nie ma konta!")
        ],
      );
}
