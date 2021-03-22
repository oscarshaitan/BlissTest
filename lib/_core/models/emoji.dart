import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

class ImageApp extends Equatable {
  final String name;
  final String url;

  const ImageApp({
    @required this.name,
    @required this.url,
  });

  @override
  List<Object> get props => [name, url];
}
