import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import '../cubit/todos_cubit.dart';

class DottedButton extends StatelessWidget {
  const DottedButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (TodosCubit.get(context).taskImage == null) {
          showDialog(
            context: context,
            builder: (context) {
              return SimpleDialog(
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 30,
                ),
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          IconButton(
                            onPressed: () {
                              TodosCubit.get(context).pickImage(
                                imageSource: ImageSource.gallery,
                              );
                              Navigator.pop(context);
                            },
                            icon: const Icon(
                              Icons.image_rounded,
                              size: 30,
                            ),
                          ),
                          const Text(
                            'Gallary',
                            style: TextStyle(
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        height: 60,
                        width: 2,
                        color: Colors.grey,
                      ),
                      Column(
                        children: [
                          IconButton(
                            onPressed: () {
                              TodosCubit.get(context).pickImage(
                                imageSource: ImageSource.camera,
                              );
                              Navigator.pop(context);
                            },
                            icon: const Icon(
                              Icons.camera_alt_rounded,
                              size: 30,
                            ),
                          ),
                          const Text(
                            'Camera',
                            style: TextStyle(
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              );
            },
          );
        } else {
          TodosCubit.get(context).removeImage();
        }
      },
      child: DottedBorder(
        color: Colors.deepPurple,
        strokeWidth: 1,
        borderType: BorderType.RRect,
        radius: const Radius.circular(10),
        padding: const EdgeInsets.symmetric(vertical: 15),
        child: BlocBuilder<TodosCubit, TodosState>(
          builder: (context, state) {
            if (TodosCubit.get(context).taskImage != null) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.file(
                      TodosCubit.get(context).taskImage!,
                      height: 50,
                      width: 50,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 10),
                  const Text(
                    'remove image',
                  ),
                  const SizedBox(width: 10),
                  const Icon(
                    Icons.remove_circle_outline_rounded,
                    color: Colors.redAccent,
                  )
                ],
              );
            } else {
              return const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.add_photo_alternate_outlined,
                    size: 26,
                    color: Colors.deepPurple,
                  ),
                  SizedBox(width: 5),
                  Text(
                    'Add Image',
                    style: TextStyle(
                      color: Colors.deepPurple,
                    ),
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
