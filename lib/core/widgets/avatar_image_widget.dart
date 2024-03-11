import 'package:flutter/material.dart';
import 'package:kafil/constants/constants.dart';

class AvatarImageWidget extends StatelessWidget {
  final String? avatarImageUrl;
  final double radius;

  const AvatarImageWidget({
    super.key,
    this.avatarImageUrl,
    this.radius = 50.0,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: radius * 2,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            width: radius * 2,
            height: radius * 2,
            padding: const EdgeInsets.all(1.0),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              shape: BoxShape.circle,
            ),
            child: CircleAvatar(
              radius: radius * 2,
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              backgroundImage: const AssetImage(kAvatarImage),
              foregroundImage:
                  avatarImageUrl != null && avatarImageUrl!.isNotEmpty
                      ? NetworkImage(avatarImageUrl!)
                      : null,
            ),
          ),
          avatarImageUrl != null
              ? const SizedBox()
              : Align(
                  alignment: AlignmentDirectional.bottomEnd,
                  child: Container(
                    padding: const EdgeInsets.all(2.0),
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.add, color: Colors.white),
                  ),
                ),
        ],
      ),
    );
  }
}
