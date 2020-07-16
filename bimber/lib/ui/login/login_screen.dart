import 'package:bimber/bloc/auth/authentication.dart';
import 'package:bimber/bloc/login/login.dart';
import 'package:bimber/resources/account_repository.dart';
import 'package:bimber/ui/register/register_screen.dart';
import 'package:bimber/ui/splash/splash_screen.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';


class LoginScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => LoginScreenState();

}
class LoginScreenState extends State<LoginScreen> {
  bool animate;

  @override
  void initState() {
    animate = false;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LoginBloc>(
      create: (BuildContext context) => LoginBloc(RepositoryProvider.of<AccountRepository>(context)),
      child: Scaffold(
        body: BlocListener<LoginBloc, LoginState>(
          listener: (context, state){
            Scaffold.of(context).removeCurrentSnackBar();
            if(state is LoginEmailExists){
              setState(() {
                animate = true;
              });
            } else if (state is LoginFailed) {
              Scaffold.of(context)
                ..showSnackBar(
                  SnackBar(
                    content: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Hasło nie jest prawidłowe', style: TextStyle(color: Colors.white)),
                        Icon(Icons.error)],
                    ),
                    backgroundColor: Colors.red,
                    duration: Duration(seconds: 3),
                  ),
                );
            }
            else if (state is LoginSucceed) {
              BlocProvider.of<AuthenticationBloc>(context).add(LoggedIn());
            }
            else if(state is LoginLoading){
              Scaffold.of(context)
                ..showSnackBar(
                    SnackBar(
                      content: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Logowanie, prosze czekać', style: TextStyle(color: Colors.white)),
                          CircularProgressIndicator()
                        ],
                      ),
                      backgroundColor: Colors.black,
                      duration: Duration(seconds: 5),
                    ));
            } else if(state is LoginEmailNotExists){
              Navigator.push(context, PageTransition(type: PageTransitionType.downToUp,child: RegisterScreen()));
            } else {
              Navigator.push(context, PageTransition(type: PageTransitionType.downToUp,child: SplashScreen()));
            }
          },
          child: SingleChildScrollView(
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
               child:LoginForm(animate)
              )
             )
          )
        )
      )
    );
  }

}

class LoginForm extends StatefulWidget{
  final bool animate;
  LoginForm(this.animate);

  @override
  State<StatefulWidget> createState() => LoginFormState();

}

class LoginFormState extends State<LoginForm> with SingleTickerProviderStateMixin{
  final TextEditingController _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  AnimationController _animationController;
  Animation _animation;


  @override
  void didUpdateWidget(LoginForm oldWidget) {
    if(widget.animate){
      _animationController.forward();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(duration: Duration(seconds: 2), vsync: this);
    _animation = IntTween(begin: 30, end: 0).animate(_animationController);
    _animation.addListener(() => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
   return  Column(
     crossAxisAlignment: CrossAxisAlignment.center,
     mainAxisAlignment: MainAxisAlignment.center,
     children: <Widget>[
       Expanded(
         flex: 20,
         child: Container(),
       ),
       Expanded(
         flex: 40,
         child: FlareActor("assets/Bimber-logo.flr", alignment:Alignment.center, fit:BoxFit.contain, animation:"idle"),
       ),
       Expanded(
         flex: _animation.value,
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
         flex: 20,
         child: Text("Mój email to:", style: TextStyle(fontSize: 33, fontWeight: FontWeight.w900, fontFamily: 'Baloo'), textAlign: TextAlign.center,),
       ),
       Expanded(
           flex: 50 + (30 - _animation.value),
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
                           FocusScope.of(context).unfocus();
                           if(_formKey.currentState.validate()){
                             BlocProvider.of<LoginBloc>(context).add(LoginCheckEmail(_emailController.value.text));
                           }
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
   );
  }

}
