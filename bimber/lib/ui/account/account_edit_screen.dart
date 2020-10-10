import 'package:bimber/models/account_data.dart';
import 'package:bimber/models/age_preference.dart';
import 'package:bimber/ui/common/account_form_fields.dart';
import 'package:bimber/ui/common/age_preference_slider.dart';
import 'package:bimber/ui/common/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:tinycolor/tinycolor.dart';
import 'package:build_context/build_context.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class AccountEditScreen extends StatefulWidget {
  final AccountData accountData;

  AccountEditScreen({@required this.accountData});

  @override
  State<StatefulWidget> createState() => _AccountEditScreenState();
}

class _AccountEditScreenState extends State<AccountEditScreen> {
  final _fbKey = GlobalKey<FormBuilderState>();
  AgePreference _agePreference;

  @override
  void initState() {
    super.initState();
    _agePreference = widget.accountData.agePreference;
  }

  Future<String> _getAvatarLocalPath(String imageUrl) async {
    final fileInfo = await DefaultCacheManager().getFileFromCache(imageUrl);
    return fileInfo.file.path;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: sandyBrown,
        centerTitle: true,

        title: Text("Edycja Konta",
            style: TextStyle(fontFamily: "Baloo", color: orangeYellowCrayola)),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.save, color: orangeYellowCrayola),
        onPressed: () {
          // TODO: edditing bloc

          context.pop();
        },
      ),
      body: FutureBuilder(
        future: _getAvatarLocalPath(widget.accountData.imageUrl),
        builder: (context, AsyncSnapshot<String> snapshot) {
          if (!snapshot.hasData) return CircularProgressIndicator();
          if (snapshot.hasError) return CircularProgressIndicator();

          return FormBuilder(
              key: _fbKey,
              initialValue: {
                "imageUrl": [widget.accountData.imageUrl],
                "name": widget.accountData.name,
                "email": widget.accountData.email.toString(),
                "gender": widget.accountData.gender,
                "age": widget.accountData.age.toString(),
                "description": widget.accountData.description,
                "alcoholPreference": widget.accountData.alcoholPreference,
                "alcoholName": widget.accountData.favoriteAlcohol.name,
                "agePreference": widget.accountData.agePreference,
              },
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    AccountFormField.imagePicker(size),
                    AccountFormField.nameField,
                    AccountFormField.emailField,
                    AccountFormField.genderField,
                    AccountFormField.ageField,
                    AccountFormField.descriptionField,
                    AgePreferenceSlider(
                        preference: _agePreference,
                        onChanged: (range) {
                          setState(() {
                            _agePreference = AgePreference(
                                from: range.start.toInt(),
                                to: range.end.toInt());
                          });
                        }),
                    AccountFormField.alcoholPreferenceField,
                    AccountFormField.alcoholNameField,
                    // agePreference
                    // imageurl
                  ].map((field) => FormFieldCard(child: field)).toList(),
                ),
              ));
        },
      ),
    );
  }
}

class FormFieldCard extends StatelessWidget {
  final Widget child;

  FormFieldCard({@required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: TinyColor(lemonMeringue).darken(5).color,
          boxShadow: [
            BoxShadow(
              color: TinyColor(Colors.black).lighten(30).color,
              offset: Offset(3, 3),
              blurRadius: 3,
            )
          ]),
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 3),
      padding: EdgeInsets.all(15),
      child: Column(
        children: <Widget>[child],
      ),
    );
  }
}
