import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:yourmanager/features/authentication/data/models/user_model.dart';
import 'package:yourmanager/features/authentication/domain/entities/users.dart';
import 'package:yourmanager/features/authentication/presentation/cubit/authentication_cubit.dart';
import 'package:yourmanager/features/img_vids/presentation/cubit/representation_cubit.dart';

import '../cubit/representation_state.dart';

class ProfileImage extends StatefulWidget {
  late UserModel user;
  ProfileImage({super.key, required this.user});

  @override
  State<ProfileImage> createState() => _ProfileImageState();
}

class _ProfileImageState extends State<ProfileImage> {
  late File? _imageFile;
  late String imageName;
  final picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _imageFile = File(pickedFile.path);
        if (_imageFile!.path.isNotEmpty) {
          context.read<RepresentationCubit>().uploadImage(_imageFile!);
        }
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _imageFile = File.fromUri(Uri());
    imageName = widget.user.image;
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RepresentationCubit, RepresentationState>(
      listener: (context, state) {
        if (state is ImageUploadSuccessfully) {
          imageName = state.imageFile;
          var myUser = widget.user;
          if (myUser.image.isNotEmpty) {
            context.read<RepresentationCubit>().deleteImage(myUser.image);
          }
          context.read<AuthenticationCubit>().updateUserAccount(
                myUser.id,
                myUser.fullName,
                imageName,
                myUser.phoneNumber,
              );
        }
        if (state is DeleteImageSuccessfully) {
          print("We delete this images successfully.");
        }
      },
      builder: (context, state) {
        return Stack(
          alignment: Alignment.center,
          children: [
            Container(
              color: const Color.fromARGB(0, 255, 193, 7),
              height: 260,
            ),
            Positioned(
              top: 0,
              child: Container(
                width: MediaQuery.of(context).size.width * 1,
                height: 220,
                color: const Color.fromARGB(255, 87, 144, 171),
              ),
            ),
            Positioned(
              top: 45,
              child: imageName.isNotEmpty
                  ? CircleAvatar(
                      radius: 100,
                      backgroundImage: NetworkImage(imageName),
                    )
                  : const CircleAvatar(
                      radius: 100,
                      backgroundColor: Colors.white,
                      child: Center(
                        child: Icon(Icons.person),
                      ),
                    ),
            ),
            Positioned(
              bottom: 10,
              right: 100,
              child: Container(
                width: 45,
                height: 45,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(22.5),
                ),
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      getImage();
                    });
                  },
                  child: const Center(
                    child: Icon(
                      Icons.photo_camera,
                      color: Colors.blue,
                    ),
                  ),
                ),
              ),
            )
          ],
        );
      },
    );
  }
}
