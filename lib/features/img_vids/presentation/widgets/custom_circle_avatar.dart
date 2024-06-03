import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yourmanager/features/img_vids/presentation/cubit/representation_cubit.dart';
import 'package:yourmanager/features/img_vids/presentation/cubit/representation_state.dart';

class CCircleAvatar extends StatefulWidget {
  late String imagePath = "";
  late IconData icon;
  CCircleAvatar({
    super.key,
    this.imagePath = "",
    required this.icon,
  });

  @override
  State<CCircleAvatar> createState() => _CCircleAvatarState();
}

class _CCircleAvatarState extends State<CCircleAvatar> {
  @override
  void initState() {
    super.initState();
    if (widget.imagePath.isNotEmpty) {
      context.read<RepresentationCubit>().getImage(widget.imagePath);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RepresentationCubit, RepresentationState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is GetImageSuccessfully) {
            return CircleAvatar(
              backgroundImage: NetworkImage(state.imageLink),
            );
          } else {
            return GestureDetector(
              onTap: () {
                if (widget.imagePath.isNotEmpty) {
                  context
                      .read<RepresentationCubit>()
                      .getImage(widget.imagePath);
                }
              },
              child: CircleAvatar(
                backgroundColor: const Color.fromARGB(255, 217, 217, 217),
                child: Center(
                  child: Icon(widget.icon),
                ),
              ),
            );
          }
        });
  }
}
