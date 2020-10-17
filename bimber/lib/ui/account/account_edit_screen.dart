import 'dart:io';
import 'dart:math';

import 'package:bimber/bloc/account_bloc/account_bloc.dart';
import 'package:bimber/models/account_data.dart';
import 'package:bimber/models/age_preference.dart';
import 'package:bimber/models/edit_account_data.dart';
import 'package:bimber/models/gender.dart';
import 'package:bimber/resources/repositories/account_repository.dart';
import 'package:bimber/resources/services/image_service.dart';
import 'package:bimber/ui/common/account_form_fields.dart';
import 'package:bimber/ui/common/age_preference_slider.dart';
import 'package:bimber/ui/common/dialog_utils.dart';
import 'package:bimber/ui/common/snackbar_utils.dart';
import 'package:bimber/ui/common/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:tinycolor/tinycolor.dart';
import 'package:build_context/build_context.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class AccountEditScreen extends StatefulWidget {
  final AccountData accountData;
  final void Function() onAccountUpdate;

  AccountEditScreen({@required this.accountData, this.onAccountUpdate});

  @override
  State<StatefulWidget> createState() => _AccountEditScreenState();
}

class _AccountEditScreenState extends State<AccountEditScreen> {
  final _fbKey = GlobalKey<FormBuilderState>();
  AgePreference _agePreference;

  @override
  void initState() {
    super.initState();
    _agePreference = AgePreference(
        from: widget.accountData.agePreferenceFrom,
        to: widget.accountData.agePreferenceTo);
  }

  Future<String> _getAvatarLocalPath(String imageUrl) async {
    final fileInfo = await DefaultCacheManager().getFileFromCache(imageUrl);
    return fileInfo.file.path;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocProvider<AccountBloc>(
      create: (context) =>
          AccountBloc(repository: context.repository<AccountRepository>()),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Edycja Konta",
              style:
                  TextStyle(fontFamily: "Baloo", color: orangeYellowCrayola)),
        ),
        floatingActionButton: Builder(
          builder: (buttonContext) {
            final bloc = buttonContext.bloc<AccountBloc>();

            return FloatingActionButton(
              child: Icon(Icons.save, color: orangeYellowCrayola),
              onPressed: () {
                if (_fbKey.currentState.saveAndValidate()) {
                  Map<String, dynamic> values = _fbKey.currentState.value;
                  values.update("age", (age) => int.parse(age));

                  final data = EditAccountData(
                    id: widget.accountData.id,
                    imagePath:
                        ((values["imageUrl"] as List).first as File).path,
                    name: values["name"],
                    gender: values["gender"],
                    genderPreference: values["genderPreference"],
                    age: values["age"],
                    description: values["description"],
                    alcoholPreference: values["alcoholPreference"],
                    favoriteAlcoholName: values["alcoholName"],
                    // FIXME this should be a field
                    favoriteAlcoholType: values["alcoholPreference"],
                    agePreferenceFrom: _agePreference.from,
                    agePreferenceTo: _agePreference.to,
                  );

                  bloc.add(
                      EditAccount(data: data, version: Random().nextInt(1000)));
                }
              },
            );
          },
        ),
        body: BlocConsumer<AccountBloc, AccountState>(
          listener: (context, state) {
            if (state is EditAccountLoading) {
              showLoadingIndicatorDialog(
                  context, "Trwa aktualizowanie konta...");
            } else {
              hideDialog(context);
            }
            if (state is EditAccountError) {
              showErrorSnackbar(context,
                  message: "Błąd podczas aktualizacji informacji...");
            }
            if (state is EditAccountSuccess) {
              // context.bloc<AccountBloc>().add(FetchAccount());
              widget.onAccountUpdate();
              context.pop();
            }
          },
          builder: (context, state) {
            return FutureBuilder(
              future: _getAvatarLocalPath(
                  ImageService.getImageUrl(widget.accountData.id)),
              builder: (context, AsyncSnapshot<String> snapshot) {
                String imagePath;
                if (snapshot.hasError) {
                  imagePath = snapshot.data;
                } else if (snapshot.hasData) {
                  imagePath = snapshot.data;
                } else {
                  return Center(child: CircularProgressIndicator());
                }

                return FormBuilder(
                    key: _fbKey,
                    initialValue: {
                      "imageUrl": imagePath != null ? [File(imagePath)] : [],
                      "name": widget.accountData.name,
                      "gender": widget.accountData.gender,
                      "genderPreference": widget.accountData.genderPreference,
                      "age": widget.accountData.age.toString(),
                      "description": widget.accountData.description,
                      "alcoholPreference": widget.accountData.alcoholPreference,
                      "alcoholName": widget.accountData.favoriteAlcoholName,
                      "agePreference": _agePreference
                    },
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          AccountFormField.imagePicker(size),
                          AccountFormField.nameField,
                          AccountFormField.genderField,
                          AccountFormField.genderPreferenceField,
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
                        ].map((field) => FormFieldCard(child: field)).toList(),
                      ),
                    ));
              },
            );
          },
        ),
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
