import 'package:bimber/models/account_data.dart';
import 'package:bimber/ui/common/account_form_fields.dart';
import 'package:bimber/ui/common/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class AccountEditScreen extends StatefulWidget {
  final AccountData accountData;

  AccountEditScreen({@required this.accountData});

  @override
  State<StatefulWidget> createState() => _AccountEditScreenState();
}

class _AccountEditScreenState extends State<AccountEditScreen> {
  final _fbKey = GlobalKey<FormBuilderState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FormBuilder(
          key: _fbKey,
          initialValue: {
            "name": widget.accountData.name,
            "email": widget.accountData.email,
            "gender": widget.accountData.gender,
            "age": widget.accountData.age,
            "description": widget.accountData.description,
            "alcoholType": widget.accountData.alcoholPreference,
            "alcohol": widget.accountData.favoriteAlcohol,
            "agePreference": widget.accountData.agePreference,
            "imageUrl": widget.accountData.imageUrl
          },
          child: ListView(
            children: <Widget>[
              AccountFormField.nameField,
              AccountFormField.emailField,
              AccountFormField.genderField,
              AccountFormField.ageField,
              AccountFormField.descriptionField,
              AccountFormField.alcoholPreferenceField,
              AccountFormField.alcoholNameField,

              // agePreference
              // imageurl

            ],
          )),
    );
  }

  _name() {

  }
}

class FormFieldCard extends StatelessWidget {
  final String title;
  final String attribute;

  FormFieldCard({@required this.title, @required this.attribute});


  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          _header(),
          SizedBox(height: 5),
          _field(),
        ],
      ),
    );
  }

  _header() {
    return Text(title, style: TextStyle(fontWeight: FontWeight.w700, color: indigoDye));
  }

  _field() {
    return FormBuilderTextField()
  }
}
