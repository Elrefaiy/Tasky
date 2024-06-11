import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/widgets/error_widget.dart';
import '../../domain/entities/profile_info.dart';
import '../cubit/auth_cubit.dart';
import '../widgets/info_item.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Profile',
          style: TextStyle(
            fontSize: 18,
          ),
        ),
        titleSpacing: 0,
      ),
      body: BlocBuilder<AuthCubit, AuthState>(
        builder: (context, state) {
          if (state is GetProfileInfoLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is GetProfileInfoSuccessState) {
            return ListView.separated(
              padding: const EdgeInsets.all(20),
              itemBuilder: (context, index) {
                final ProfileInfo info = state.profileInfo;
                return ProfileInfoItem(
                  index: index,
                  info: [
                    info.displayName,
                    info.username,
                    info.level,
                    info.experienceYears.toString(),
                    info.address,
                  ],
                );
              },
              separatorBuilder: (context, index) {
                return const SizedBox(height: 8);
              },
              itemCount: AuthCubit.get(context).profileData.length,
            );
          } else {
            return DefaultErrorWidget(
              refresh: () {
                AuthCubit.get(context).getProfileInfo();
              },
            );
          }
        },
      ),
    );
  }
}
