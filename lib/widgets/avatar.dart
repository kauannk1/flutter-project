import 'package:flutter/material.dart';

class Avatar extends StatelessWidget {
  final String? url;
  final double size;
  const Avatar({super.key, this.url, this.size = 44});

  @override
  Widget build(BuildContext context) {
    final hasValidUrl =
        url != null && url!.isNotEmpty && url!.startsWith('http');

    return CircleAvatar(
      radius: size / 2,
      backgroundColor: Colors.grey.shade300,
      backgroundImage: hasValidUrl ? NetworkImage(url!) : null,
      child: !hasValidUrl
          ? Icon(Icons.person, size: size / 2, color: Colors.white)
          : null,
    );
  }
}
