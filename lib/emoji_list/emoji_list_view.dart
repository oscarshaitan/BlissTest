import 'package:bliss_test/_core/models/emoji.dart';
import 'package:bliss_test/_core/widgets/grid_images_widget.dart';
import 'package:bliss_test/_core/widgets/loading_widget.dart';
import 'package:bliss_test/emoji_list/cubit/emoji_list_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../injection_container.dart';

class EmojiListView extends StatefulWidget {
  final List<ImageApp> emojis;

  EmojiListView(this.emojis);

  @override
  _EmojiListViewState createState() => _EmojiListViewState();
}

class _EmojiListViewState extends State<EmojiListView> {
  EmojiListCubit _cubit;

  @override
  void initState() {
    _cubit = sl.get<EmojiListCubit>()..init(widget.emojis);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<EmojiListCubit>(
      create: (context) => _cubit,
      child: BlocConsumer<EmojiListCubit, EmojiListState>(
        listener: (context, state) {
          if (state is RemovingEmoji) {
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
              child: RefreshIndicator(
                onRefresh: () async {
                  _cubit.refreshEmojis();
                },
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16,
                  ),
                  child: AnimatedSwitcher(
                    duration: Duration(milliseconds: 350),
                    child: state is EmojiListInitial
                        ? LoadingWidget()
                        : GridImageAppWidget(
                            images: state.emojis,
                            onTap: (ImageApp imageApp) {
                              _cubit.removeTile(imageApp);
                            },
                          ),
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
