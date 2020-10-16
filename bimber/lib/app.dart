import 'package:bimber/bloc/auth/authentication_bloc.dart';
import 'package:bimber/resources/graphql_repositories/graphql_account_repository.dart';
import 'package:bimber/resources/repositories/repositories.dart';
import 'package:bimber/resources/mocks/mocks.dart';
import 'package:bimber/models/account_data.dart';
import 'package:bimber/resources/services/graphql_service.dart';
import 'package:bimber/ui/account/account_edit_screen.dart';
import 'package:bimber/ui/chat_list/friend_menu.dart';
import 'package:bimber/ui/discover/discover_screen.dart';
import 'package:bimber/ui/group_create/group_maker_screen.dart';
import 'package:bimber/ui/group_details/group_details.dart';
import 'package:bimber/ui/home/home_screen.dart';
import 'package:bimber/ui/invitations/invitations_screen.dart';
import 'package:bimber/ui/login/login_screen.dart';
import 'package:bimber/ui/common/theme.dart';
import 'package:bimber/ui/login/starting_screen.dart';
import 'package:bimber/ui/register/register_screen.dart';
import 'package:bimber/ui/splash/splash_screen.dart';
import 'package:bimber/ui/user_details/user_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
        providers: [
          RepositoryProvider<AccountRepository>(
            create: (context) =>
                GraphqlAccountRepository(client: GraphqlClientService.client),
          ),
          RepositoryProvider<FriendRepository>(
            create: (context) => MockFriendRepository(),
          ),
          RepositoryProvider<ChatRepository>(
            create: (context) => MockChatRepository(),
          ),
          RepositoryProvider<GroupRepository>(
            create: (context) => MockGroupRepository(),
          )
        ],
        child: BlocProvider<AuthenticationBloc>(
          create: (BuildContext context) => AuthenticationBloc(
              accountRepository: context.repository<AccountRepository>())
            ..add(AppStarted()),
          child: MaterialApp(
            title: "Bimber",
            theme: themeData,
            onGenerateRoute: (settings) {
              switch (settings.name) {
                case "/":
                  {
                    return PageTransition(
                        type: PageTransitionType.fade, child: StartingScreen());
                  }
                case "/splash":
                  {
                    return PageTransition(
                        type: PageTransitionType.fade, child: SplashScreen());
                  }
                case "/login":
                  {
                    return PageTransition(
                        type: PageTransitionType.bottomToTop,
                        child: LoginScreen());
                  }
                case "/register":
                  {
                    return PageTransition(
                        settings: settings,
                        type: PageTransitionType.fade,
                        duration: Duration(milliseconds: 200),
                        child: RegisterScreen());
                  }
                case "/edit-account":
                  {
                    return PageTransition(
                        type: PageTransitionType.bottomToTop,
                        child: AccountEditScreen(
                            accountData: settings.arguments as AccountData));
                  }
                case "/home":
                  {
                    return PageTransition(
                        type: PageTransitionType.fade, child: HomeScreen());
                  }
                case "/discover":
                  {
                    return PageTransition(
                        type: PageTransitionType.scale,
                        child: DiscoverScreen());
                  }
                case "/user-details":
                  {
                    return PageTransition(
                        type: PageTransitionType.fade,
                        duration: Duration(milliseconds: 500),
                        child: UserDetails(user: settings.arguments));
                  }
                case "/group-details":
                  {
                    return PageTransition(
                        type: PageTransitionType.fade,
                        duration: Duration(milliseconds: 500),
                        child: GroupDetails(group: settings.arguments));
                  }
                case "/invitations":
                  {
                    return PageTransition(
                        type: PageTransitionType.fade,
                        duration: Duration(milliseconds: 500),
                        child: InvitationsScreen());
                  }
                case "/friend-menu":
                  {
                    FriendMenuArguments args = settings.arguments;
                    return PageRouteBuilder(
                        opaque: false,
                        pageBuilder: (_, __, ___) => FriendMenu(
                              child: args.child,
                              menuContent: args.menuContent,
                              childOffset: args.childOffset,
                              childSize: args.childSize,
                            ),
                        transitionDuration: Duration(milliseconds: 100));
                  }
                case "/group-create":
                  {
                    return PageTransition(
                        type: PageTransitionType.fade,
                        duration: Duration(milliseconds: 500),
                        child: GroupMakerScreen());
                  }
                default:
                  {
                    // this should not happen
                    assert(false);
                    return null;
                  }
              }
            },
            initialRoute: "/home",
          ),
        ));
  }
}
