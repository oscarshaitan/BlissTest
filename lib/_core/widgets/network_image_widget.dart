import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'loading_widget.dart';

class NetworkImageWidget extends StatelessWidget {
  final String url;

  const NetworkImageWidget({
    Key key,
    @required this.url,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: url,
      height: 75,
      placeholder: (context, _) {
        return LoadingWidget();
      },
      errorWidget: (context, url, error) => Icon(Icons.error),
    );
  }
}
