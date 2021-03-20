import 'package:bliss_test/_core/models/emoji.dart';
import 'package:flutter/material.dart';

import 'loading_widget.dart';
import 'network_image_widget.dart';

class EmojiTile extends StatelessWidget {
  final Emoji emoji;
  final bool loading;
  final Function onTap;

  const EmojiTile({
    Key key,
    this.emoji,
    this.loading = true,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap ?? () {},
      child: Column(
        children: [
          Center(
            child: AnimatedSwitcher(
              duration: Duration(milliseconds: 350),
              child: loading
                  ? LoadingWidget()
                  : NetworkImageWidget(
                      url: emoji.url,
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
