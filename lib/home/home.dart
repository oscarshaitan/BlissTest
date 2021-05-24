import 'package:bliss_test/_core/widgets/emoji_tile.dart';
import 'package:bliss_test/avatar_list/avatar_list_view.dart';
import 'package:bliss_test/emoji_list/emoji_list_view.dart';
import 'package:bliss_test/google_repos/google_repos_view.dart';
import 'package:bliss_test/home/widgets/home_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_overlay/loading_overlay.dart';

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
          if (state is NavigateToUsersAvatarList) {
            Navigator.of(context).push(
              MaterialPageRoute(
                  builder: (context) => AvatarListView(state.images)),
            );
          }
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: Theme.of(context).primaryColor,
            body: LoadingOverlay(
              isLoading: state is FetchingUser,
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(vertical: 32, horizontal: 16),
                child: AnimatedSwitcher(
                  duration: Duration(milliseconds: 350),
                  child: state is FetchError
                      ? Column(
                          children: [
                            Container(
                              margin: EdgeInsets.all(32),
                              child: Icon(
                                Icons.error,
                                color: Colors.white,
                                size: 64,
                              ),
                            ),
                            Center(
                              child: Text(
                                state.error,
                                textAlign: TextAlign.center,
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle1
                                    .copyWith(color: Colors.redAccent),
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                _cubit.init();
                              },
                              child: Text('Refresh'),
                            )
                          ],
                        )
                      : Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            _HomeImage(
                              state: state,
                            ),
                            BlissButton(
                              onPressed: _cubit.randomEmoji,
                              label: 'Random Emoji',
                            ),
                            SizedBox(
                              height: 16,
                            ),
                            BlissButton(
                              onPressed: _cubit.navigateToEmojiList,
                              label: 'Emoji List',
                            ),
                            _SearchUserWidget(onSearch: _cubit.searchUser),
                            BlissButton(
                              onPressed: _cubit.navigatetoAvatarList,
                              label: 'Avatar List',
                            ),
                            SizedBox(
                              height: 16,
                            ),
                            BlissButton(
                              onPressed: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (context) => GoogleReposView()),
                                );
                              },
                              label: 'Google Repos',
                            ),
                          ],
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

class _SearchUserWidget extends StatelessWidget {
  final Function(String user) onSearch;

  _SearchUserWidget({
    Key key,
    @required this.onSearch,
  }) : super(key: key);

  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 16),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: controller,
                decoration: InputDecoration(
                  hintText: 'GitHub User',
                  hintStyle: Theme.of(context).textTheme.bodyText1.copyWith(
                        color: Colors.white54,
                      ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.white54,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Theme.of(context).accentColor,
                    ),
                  ),
                ),
                onSubmitted: onSearch,
              ),
            ),
            IconButton(
              icon: Icon(
                Icons.search_outlined,
                color: Theme.of(context).accentColor,
              ),
              onPressed: () {
                onSearch(controller.text);
              },
            )
          ],
        ),
      ),
    );
  }
}

class _HomeImage extends StatelessWidget {
  final HomeState state;

  const _HomeImage({
    Key key,
    @required this.state,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 16),
        child: AnimatedSwitcher(
          duration: Duration(milliseconds: 350),
          child: Column(
            children: [
              ImageTile(
                image: state?.currentImage,
              ),
              if (!(state is HomeInitial))
                Container(
                  margin: EdgeInsets.only(bottom: 16),
                  child: Center(
                    child: Text(
                      state.currentImage.name,
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
      ),
    );
  }
}
