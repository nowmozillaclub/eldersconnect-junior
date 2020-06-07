import 'package:flutter/material.dart';

class PhotoCircleAvatarWidget extends StatelessWidget {
  final bool isUnknown;
  final String photoUrl;

  const PhotoCircleAvatarWidget(
      {Key key, @required this.isUnknown, @required this.photoUrl})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (isUnknown) {
      return Container(
        padding: EdgeInsets.all(12.0),
        width: 58.0,
        child: CircleAvatar(
          child: Icon(Icons.person),
          radius: 15.0,
        ),
      );
    } else {
      return Container(
        padding: EdgeInsets.all(12.0),
        width: 58.0,
        child: CircleAvatar(
          backgroundImage: NetworkImage(photoUrl),
          radius: 15.0,
        ),
      );
    }
  }
}
