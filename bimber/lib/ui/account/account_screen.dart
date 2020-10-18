import 'package:bimber/bloc/account_bloc/account_bloc.dart';
import 'package:bimber/models/account_data.dart';
import 'package:bimber/resources/repositories/account_repository.dart';
import 'package:bimber/resources/services/image_service.dart';
import 'package:bimber/ui/account/sliver_account_header.dart';
import 'package:bimber/ui/account/sliver_fill_account_info.dart';
import 'package:flutter/material.dart';
import 'package:build_context/build_context.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AccountScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  double bottomSheetOpacity = 0;
  ScrollController controller;

  @override
  void initState() {
    controller = ScrollController();
    controller.addListener(() {
      final position = controller.position;
      setState(() {
        bottomSheetOpacity = position.extentBefore / position.maxScrollExtent;
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AccountBloc>(
      create: (context) =>
          AccountBloc(repository: context.repository<AccountRepository>())
            ..add(FetchAccount()),
      child: BlocConsumer<AccountBloc, AccountState>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state is AccountInitial || state is AccountLoading) {
              return Center(child: CircularProgressIndicator());
            }
            if (state is AccountFetched) {
              return _screen(context, state.account);
            }
            if (state is AccountError) {
              return FittedBox(
                fit: BoxFit.contain,
                child: Icon(Icons.error, color: Colors.red),
              );
            }
            return Container();
          }),
    );
  }

  _screen(BuildContext context, AccountData account) {
    return CustomScrollView(
      controller: controller,
      physics: PageScrollPhysics(),
      slivers: <Widget>[
        SliverAccountHeader(
            name: account.name,
            email: account.email,
            imageUrl: ImageService.getImageUrl(account.id),
            onEditAccount: () {
              context.pushNamed("/edit-account", arguments: {
                "account": account,
                "onAccountUpdate": () {
                  context
                      .bloc<AccountBloc>()
                      .add(FetchAccount(useCache: false));
                }
              });
            }),
        SliverFillAccountInfo(
            infoOpacity: bottomSheetOpacity, accountData: account)
      ],
    );
  }
}
