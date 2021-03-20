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
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            body: Center(
              child: TextButton(
                  onPressed: () {
                    print('hola');
                  },
                  child: Text('Hola')),
            ),
          );
        },
      ),
    );
  }
}
