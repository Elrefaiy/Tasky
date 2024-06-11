import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/todos_cubit.dart';

import '../../../../core/utils/app_colors.dart';

class CategoriesList extends StatelessWidget {
  const CategoriesList({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = TodosCubit.get(context);
    return SizedBox(
      height: 53,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 10,
        ),
        scrollDirection: Axis.horizontal,
        separatorBuilder: (context, index) {
          return const SizedBox(width: 5);
        },
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              cubit.changeCategoryIndex(index);
              cubit.getTodosLists();
            },
            child: BlocBuilder<TodosCubit, TodosState>(
              builder: (context, state) {
                return Container(
                  decoration: BoxDecoration(
                    color: cubit.categoriesCurrentIndex == index
                        ? AppColors.buttonsColor
                        : AppColors.secondaryColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 5,
                  ),
                  child: Text(
                    cubit.lables[index],
                    style: TextStyle(
                      color: cubit.categoriesCurrentIndex == index
                          ? Colors.white
                          : Colors.grey[500],
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                );
              },
            ),
          );
        },
        itemCount: 4,
      ),
    );
  }
}
