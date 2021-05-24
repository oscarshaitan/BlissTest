import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 75,
      child: Image.asset(
        'lib/assets/gif/bliss_loading.gif',
        fit: BoxFit.contain,
      ),
    );
  }
}
