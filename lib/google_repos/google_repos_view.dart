import 'package:bliss_test/google_repos/cubit/google_repos_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../injection_container.dart';

class GoogleReposView extends StatefulWidget {
  @override
  _GoogleReposViewState createState() => _GoogleReposViewState();
}

class _GoogleReposViewState extends State<GoogleReposView> {
  final GoogleReposCubit _cubit = sl.get<GoogleReposCubit>();

  final ScrollController _controller = ScrollController();

  @override
  void initState() {
    _controller.addListener(() {
      if (_controller.position.maxScrollExtent - _controller.offset < 150) {
        _cubit.loadMoreRepos();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<GoogleReposCubit>(
        create: (context) => _cubit,
        child: BlocBuilder<GoogleReposCubit, GoogleReposState>(
          builder: (context, state) {
            return Scaffold(
              backgroundColor: Theme.of(context).primaryColor,
              appBar: AppBar(elevation: 0),
              body: ListView.separated(
                controller: _controller,
                itemCount: state.repos.length,
                separatorBuilder: (context, index) {
                  return Divider(
                    height: 2,
                    thickness: 2,
                    color: Theme.of(context).accentColor,
                  );
                },
                itemBuilder: (context, index) {
                  return ListTile(
                    onTap: () {
                      _cubit.goToRepoPage(
                        state.repos[index].url,
                      );
                    },
                    title: Text(
                      state.repos[index].name,
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    trailing: Icon(Icons.chevron_right),
                  );
                },
              ),
            );
          },
        ));
  }
}
