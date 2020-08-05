import 'package:bimber/bloc/login/login_bloc.dart';
import 'package:bimber/ui/common/themed_primary_button.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginForm extends StatefulWidget {
  final AnimationController controller;
  LoginForm({@required this.controller});

  @override
  State<StatefulWidget> createState() => LoginFormState();
}

class LoginFormState extends State<LoginForm> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  Animation _animation;

  final rules = """
  Logując się akceptujesz nasz regulamin. Informację na temat sposobu, 
  w jaki sposób wykorzystujemy twoje dane, 
  znajdziesz w naszej Polityce prywatności.
  """;
  final formTitle = "Mój email to";

  String _emailValidator(value) {
    if (value.isEmpty) {
      return "Pole nie może być puste";
    }
    if (!RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(value)) {
      return "Niepoprawny format email";
    }
    return null;
  }

  void _onConfirmClick() {
    FocusManager.instance.primaryFocus.unfocus();
    if (_formKey.currentState.validate()) {
      if (widget.controller.isCompleted) {
        context.bloc<LoginBloc>().add(LoginCheckPassword(
            email: _emailController.value.text,
            password: _passwordController.value.text));
      } else {
        context
            .bloc<LoginBloc>()
            .add(LoginCheckEmail(email: _emailController.value.text));
      }
    }
  }

  void _onCancelClick() {
    // context.bloc<LoginBloc>().add(LoginReset());
    widget.controller.reverse();
  }

  @override
  void initState() {
    super.initState();
    _animation = IntTween(begin: 500, end: 50).animate(new CurvedAnimation(
        parent: widget.controller, curve: Curves.decelerate));
    _animation.addListener(() => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Spacer(
          flex: 150,
        ),
        Expanded(
            flex: 400,
            child: Padding(
              padding: new EdgeInsets.only(bottom: 15),
              child: FlareActor("assets/Bimber-logo.flr",
                  alignment: Alignment.center,
                  fit: BoxFit.contain,
                  animation: "idle"),
            )),
        Expanded(
            flex: _animation.value,
            child: FadeTransition(
              opacity:
                  Tween<double>(begin: 1, end: 0).animate(widget.controller),
              child: Column(
                children: <Widget>[
                  Expanded(
                    flex: 3,
                    child: Text(rules,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 14,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w600,
                            fontStyle: FontStyle.italic)),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(
                      formTitle,
                      style: TextStyle(
                          fontSize: 33,
                          fontWeight: FontWeight.w900,
                          fontFamily: 'Baloo'),
                      textAlign: TextAlign.center,
                    ),
                  )
                ],
              ),
            )),
        Expanded(
            flex: 500,
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    enabled: widget.controller.isDismissed,
                    controller: _emailController,
                    obscureText: false,
                    style: TextStyle(fontFamily: 'Montserrat', fontSize: 15.0),
                    decoration: InputDecoration(
                      labelText: "Email",
                      contentPadding:
                          EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
                      hintText: "Twój email...",
                    ),
                    validator: _emailValidator,
                  ),
                  SizeTransition(
                    sizeFactor: widget.controller,
                    child: TextFormField(
                      controller: _passwordController,
                      obscureText: true,
                      style:
                          TextStyle(fontFamily: 'Montserrat', fontSize: 15.0),
                      decoration: InputDecoration(
                        labelText: "Hasło",
                        contentPadding:
                            EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
                        hintText: "Twoje hasło...",
                      ),
                    ),
                  ),
                  SizedBox(height: 30.0),
                  SizedBox(
                      width: double.infinity,
                      child: ThemedPrimaryButton(
                          label: widget.controller.isDismissed
                              ? "DALEJ"
                              : "ZALOGUJ",
                          onPressed: _onConfirmClick)),
                  FadeTransition(
                      opacity: widget.controller,
                      child: SizedBox(
                          width: double.infinity,
                          child: ThemedPrimaryButton(
                              label: "POWRÓT", onPressed: _onCancelClick))),
                ],
              ),
            )),
      ],
    );
  }
}
