import 'package:bimber/bloc/discover/discover_bloc.dart';
import 'package:bimber/resources/repositories/group_repository.dart';
import 'package:bimber/ui/common/utils.dart';
import 'package:bimber/ui/discover/discover_stack.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DiscoverScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = sizeWithoutAppBar(context);
    final stackSize = Size(size.width, size.height * 0.9);
    return BlocProvider<DiscoverBloc>(
      create: (context) =>
          DiscoverBloc(groupRepository: context.repository<GroupRepository>())
            ..add(InitDiscover()),
      child: Column(
        children: <Widget>[
          Container(
              height: stackSize.height, child: DiscoverStack(size: stackSize)),
          Expanded(
            child: Container(
              padding: EdgeInsets.only(bottom: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  DiscoverButton(
                      icon: Icons.clear,
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      iconColor: Theme.of(context).colorScheme.secondaryVariant,
                      swipeType: SwipeType.DISLIKE),
                  DiscoverButton(
                      icon: Icons.favorite_border,
                      backgroundColor: Theme.of(context).colorScheme.secondary,
                      iconColor: Theme.of(context).colorScheme.primary,
                      swipeType: SwipeType.LIKE)
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class DiscoverButton extends StatelessWidget {
  final IconData icon;
  final Color backgroundColor;
  final Color iconColor;
  final SwipeType swipeType;

  const DiscoverButton(
      {Key key,
      this.icon,
      this.backgroundColor,
      this.iconColor,
      this.swipeType})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DiscoverBloc, DiscoverState>(builder: (context, state) {
      if (state is DiscoverFetched || state is DiscoverSwipeButtonPressed) {
        return Container(
          child: MaterialButton(
            color: backgroundColor,
            child: Icon(icon, color: iconColor, size: 50),
            onPressed: () {
              context
                  .bloc<DiscoverBloc>()
                  .add(SwipeButtonPressed(swipeType: swipeType));
            },
            padding: EdgeInsets.all(5),
            shape: CircleBorder(),
          ),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                  color: Colors.grey,
                  blurRadius: 10.0,
                  offset: Offset(3.0, 3.0),
                  spreadRadius: 3.0)
            ],
          ),
        );
      }
      return Container();
    });
  }
}
