import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yourmanager/features/img_vids/presentation/cubit/representation_cubit.dart';
import 'package:yourmanager/features/img_vids/presentation/cubit/representation_state.dart';

class CCircleAvatar extends StatefulWidget {
  late String imagePath = "";
  late IconData icon;
  late double radius;
  CCircleAvatar({
    super.key,
    this.imagePath = "",
    required this.icon,
    this.radius = 20,
  });

  @override
  State<CCircleAvatar> createState() => _CCircleAvatarState();
}

class _CCircleAvatarState extends State<CCircleAvatar> {
  late String imgLink = "";
  @override
  void initState() {
    super.initState();
    imgLink = '';
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RepresentationCubit, RepresentationState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (widget.imagePath.isNotEmpty) {
          return CircleAvatar(
            radius: widget.radius,
            backgroundImage: NetworkImage(widget.imagePath),
          );
        } else {
          return CircleAvatar(
              radius: widget.radius,
              backgroundColor: const Color.fromARGB(255, 217, 217, 217),
              child: Center(
                child: GestureDetector(
                  onTap: () {
                    if (widget.imagePath.isNotEmpty) {}
                  },
                  child: Icon(widget.icon),
                ),
              ));
        }
      },
    );
  }
}
