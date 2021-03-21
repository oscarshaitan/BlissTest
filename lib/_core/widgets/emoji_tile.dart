import 'package:bliss_test/_core/models/emoji.dart';
import 'package:flutter/material.dart';

import 'network_image_widget.dart';

class ImageTile extends StatelessWidget {
  final ImageApp image;
  final Function onTap;

  const ImageTile({
    Key key,
    this.image,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap ?? () {},
      child: Center(
        child: NetworkImageWidget(
          url: image?.url,
        ),
      ),
    );
  }
}
