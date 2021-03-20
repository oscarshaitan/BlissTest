import 'package:bliss_test/_core/widgets/emoji_tile.dart';
import 'package:bliss_test/emoji_list/emoji_list_view.dart';
import 'package:bliss_test/home/widgets/home_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../injection_container.dart';
import 'cubit/home_cubit.dart';

class HomeView extends StatelessWidget {
  final HomeCubit _cubit = sl.get<HomeCubit>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomeCubit>(
      create: (context) => _cubit,
      child: BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {
          if (state is NavigateToEmojisList) {
            Navigator.of(context).push(
              MaterialPageRoute(
                  builder: (context) => EmojiListView(state.emojis)),
            );
          }
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: Theme.of(context).primaryColor,
            body: SingleChildScrollView(
              padding: EdgeInsets.symmetric(vertical: 32, horizontal: 16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Flexible(
                    child: Column(
                      children: [
                        EmojiTile(
                          loading: state is HomeInitial,
                          emoji: state.randomEmoji,
                        ),
                        if (!(state is HomeInitial))
                          Container(
                            margin: EdgeInsets.only(bottom: 16),
                            child: Center(
                              child: Text(
                                state.randomEmoji.name,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.center,
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                            ),
                          )
                      ],
                    ),
                  ),
                  BlissButton(
                    onPressed: _cubit.randomEmoji,
                    label: 'Random Emoji',
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  BlissButton(
                    onPressed: () {
                      _cubit.navigateToEmojiList();
                    },
                    label: 'Emoji List',
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
