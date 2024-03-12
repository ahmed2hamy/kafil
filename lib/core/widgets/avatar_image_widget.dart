import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kafil/constants/constants.dart';

class AvatarImageWidget extends StatefulWidget {
  final String? avatarImageUrl;
  final double radius;

  final Future<void> Function(File?)? onImagePicked;

  const AvatarImageWidget({
    super.key,
    this.avatarImageUrl,
    this.radius = 50.0,
    this.onImagePicked,
  });

  @override
  State<AvatarImageWidget> createState() => _AvatarImageWidgetState();
}

class _AvatarImageWidgetState extends State<AvatarImageWidget> {
  File? _imageFile;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
        if (widget.onImagePicked != null) {
          widget.onImagePicked!(_imageFile);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _pickImage,
      child: Container(
        width: widget.radius * 2,
        height: widget.radius * 2,
        padding: const EdgeInsets.all(2.0),
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          shape: BoxShape.circle,
        ),
        child: CircleAvatar(
          radius: widget.radius,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          backgroundImage: _imageFile != null
              ? FileImage(_imageFile!) as ImageProvider
              : widget.avatarImageUrl != null &&
                      widget.avatarImageUrl!.isNotEmpty
                  ? NetworkImage(widget.avatarImageUrl!)
                  : const AssetImage(kAvatarImage) as ImageProvider,
          child: _imageFile == null &&
                  (widget.avatarImageUrl == null ||
                      widget.avatarImageUrl!.isEmpty)
              ? Align(
                  alignment: AlignmentDirectional.bottomEnd,
                  child: Container(
                    padding: const EdgeInsets.all(2.0),
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.add, color: Colors.white),
                  ),
                )
              : const SizedBox(),
        ),
      ),
    );
  }
}
