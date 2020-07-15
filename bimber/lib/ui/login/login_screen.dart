import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {

  final TextEditingController _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: new SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [Color(0xfff4d35e), Color(0xffee964b)],
                tileMode: TileMode.repeated, // repeats the gradient over the canvas
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    flex: 2,
                    child: Container(),
                  ),
                  Expanded(
                    flex: 4,
                    child: FlareActor("assets/Bimber-logo.flr", alignment:Alignment.center, fit:BoxFit.contain, animation:"idle"),
                  ),
                  Expanded(
                    flex: 3,
                    child: Padding(
                        padding: new EdgeInsets.only(top: 15),
                        child: Text("Logując się akceptujesz nasz regulamin. Informację na temat sposobu, w jaki sposób wykorzystujemy twoje dane, znajdziesz w naszej Polityce prywatności oraz polityce plików cookies.",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 14,
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.w600,
                                fontStyle: FontStyle.italic
                            )),
                      ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text("Mój email to:", style: TextStyle(fontSize: 33, fontWeight: FontWeight.w900, fontFamily: 'Baloo'), textAlign: TextAlign.center,),
                  ),
                  Expanded(
                    flex: 5,
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: <Widget>[
                          TextFormField(
                            controller: _emailController,
                            obscureText: false,
                            style: TextStyle(fontFamily: 'Montserrat', fontSize: 15.0),
                            decoration: InputDecoration(
                              contentPadding:
                              EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
                              hintText: "Email",),
                            validator: (value) {
                              if (value.isEmpty) {
                                return "Pole nie może być puste";
                              }
                              if (!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value)) {
                                return "Niepoprawny format email";
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 30.0),
                          Material(
                              elevation: 5.0,
                              borderRadius: BorderRadius.circular(50.0),
                              color: Color(0xff0d3b66),
                              child: MaterialButton(
                                  minWidth: MediaQuery.of(context).size.width,
                                  padding: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
                                  onPressed: () {
                                    _formKey.currentState.validate();
                                  },
                                  child: Text("DALEJ",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(fontFamily: 'Montserrat', fontSize: 15.0, fontWeight: FontWeight.bold)
                                  )
                              )
                          ),
                        ],
                      ),
                    )
                  ),
                ],
              ),
              ),
          ),
        ),
    );
  }
}
