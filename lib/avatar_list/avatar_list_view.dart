import 'package:bliss_test/_core/models/emoji.dart';
import 'package:bliss_test/_core/widgets/grid_images_widget.dart';
import 'package:bliss_test/_core/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../injection_container.dart';
import 'cubit/avatar_list_cubit.dart';

class AvatarListView extends StatefulWidget {
  final List<ImageApp> avatars;

  AvatarListView(this.avatars);

  @override
  _AvatarListViewState createState() => _AvatarListViewState();
}

class _AvatarListViewState extends State<AvatarListView> {
  AvatarListCubit _cubit;

  @override
  void initState() {
    _cubit = sl.get<AvatarListCubit>()..init(widget.avatars);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AvatarListCubit>(
      create: (context) => _cubit,
      child: BlocConsumer<AvatarListCubit, AvatarListState>(
        listener: (context, state) {
          if (state is RemovingAvatar) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Removing ${state.name}'),
                duration: Duration(seconds: 1),
              ),
            );
          }
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: Theme.of(context).primaryColor,
            appBar: AppBar(elevation: 0),
            body: SafeArea(
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 16,
                ),
                child: AnimatedSwitcher(
                  duration: Duration(milliseconds: 350),
                  child: state is AvatarListInitial
                      ? LoadingWidget()
                      : GridImageAppWidget(
                          images: state.avatars,
                          onTap: (ImageApp imageApp) {
                            _cubit.removeTile(imageApp);
                          },
                        ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
