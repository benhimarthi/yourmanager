import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:yourmanager/features/authentication/data/models/user_model.dart';
import 'package:yourmanager/features/authentication/presentation/cubit/authentication_cubit.dart';
import '../../../../../core/widgets/loading.dart';
import '../../../../img_vids/presentation/cubit/representation_cubit.dart';
import '../../../../img_vids/presentation/widgets/profile_image.dart';
import '../../cubit/authentication_state.dart';

class ProfileViewSmallScreen extends StatefulWidget {
  final String userUid;
  const ProfileViewSmallScreen({super.key, required this.userUid});

  @override
  State<ProfileViewSmallScreen> createState() => _ProfileViewSmallScreenState();
}

class _ProfileViewSmallScreenState extends State<ProfileViewSmallScreen> {
  late File? _imageFile;
  late String imageName;
  final picker = ImagePicker();
  late UserModel user;
  late ProfileImage pi;
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
    user = UserModel(
      id: widget.userUid,
      fullName: '',
      phoneNumber: '',
      image: '',
      email: '',
    );
    pi = ProfileImage(
      user: user,
    );
    _imageFile = File('');
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 87, 144, 171),
          elevation: 0,
          title: const Text('Profile'),
          actions: [
            GestureDetector(
              child: Stack(
                alignment: Alignment.center,
                children: const [
                  CircleAvatar(
                    backgroundColor: Color.fromARGB(0, 217, 217, 217),
                  ),
                  Icon(
                    Icons.edit,
                    color: Colors.blue,
                  )
                ],
              ),
            )
          ],
        ),
        body: SizedBox(
          child: BlocConsumer<AuthenticationCubit, AuthenticationState>(
            listener: (context, state) {
              if (state is GetUserSuccessfully) {}
            },
            builder: (context, state) {
              return state is GetUserSuccessfully
                  ? Column(
                      children: [
                        pi,
                      ],
                    )
                  : state is GettingUser
                      ? const SizedBox(
                          height: double.infinity,
                          child: Center(
                            child: LoadingColumn(
                              message: 'Charging profile',
                            ),
                          ),
                        )
                      : SizedBox(
                          height: double.infinity,
                          child: Center(
                            child: IconButton(
                              onPressed: () {
                                context
                                    .read<AuthenticationCubit>()
                                    .getUser(widget.userUid);
                              },
                              icon: const Icon(Icons.replay),
                            ),
                          ),
                        );
            },
          ),
        ));
  }
}
