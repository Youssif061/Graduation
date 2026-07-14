import 'package:expertisemarket/core/routes/routers.dart';
import 'package:expertisemarket/core/styles/colors.dart';
import 'package:expertisemarket/core/theme/theme_cubit.dart';
import 'package:expertisemarket/core/theme/theme_state.dart';
import 'package:expertisemarket/features/auth/change_password_screen.dart';
import 'package:expertisemarket/features/profile/data/firebase_profile_repository.dart';
import 'package:expertisemarket/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:expertisemarket/features/profile/presentation/cubit/profile_state.dart';
import 'package:expertisemarket/features/profile/presentation/widgets/profile_action_tile.dart';
import 'package:expertisemarket/features/profile/presentation/widgets/profile_name_editor.dart';
import 'package:expertisemarket/features/profile/presentation/widgets/profile_photo_card.dart';
import 'package:expertisemarket/features/profile/presentation/widgets/profile_section_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key, this.embedded = false, this.repository});

  final bool embedded;
  final FirebaseProfileRepository? repository;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          ProfileCubit(repository: repository ?? FirebaseProfileRepository())
            ..loadProfile(),
      child: _ProfileView(embedded: embedded),
    );
  }
}

class _ProfileView extends StatefulWidget {
  const _ProfileView({required this.embedded});

  final bool embedded;

  @override
  State<_ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<_ProfileView> {
  final GlobalKey<FormState> _nameFormKey = GlobalKey<FormState>();

  final TextEditingController _fullNameController = TextEditingController();

  @override
  void dispose() {
    _fullNameController.dispose();
    super.dispose();
  }

  Future<void> _showPhotoSourcePicker() async {
    final ImageSource? source = await showModalBottomSheet<ImageSource>(
      context: context,
      showDragHandle: true,
      backgroundColor: Theme.of(context).colorScheme.surface,
      builder: (sheetContext) {
        final colorScheme = Theme.of(sheetContext).colorScheme;

        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Change Profile Photo',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                      color: colorScheme.onSurface,
                    ),
                  ),
                ),
                const SizedBox(height: 14),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: const Icon(
                    Icons.camera_alt_outlined,
                    color: AppColors.marketGreenDark,
                  ),
                  title: const Text('Take a photo'),
                  onTap: () {
                    Navigator.pop(sheetContext, ImageSource.camera);
                  },
                ),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: const Icon(
                    Icons.photo_library_outlined,
                    color: AppColors.marketGreenDark,
                  ),
                  title: const Text('Choose from gallery'),
                  onTap: () {
                    Navigator.pop(sheetContext, ImageSource.gallery);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );

    if (!mounted || source == null) {
      return;
    }

    await context.read<ProfileCubit>().changePhoto(source);
  }

  Future<void> _confirmDeletePhoto() async {
    final bool? shouldDelete = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Delete profile photo?'),
          content: const Text(
            'Your current profile photo will be permanently removed.',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext, false);
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext, true);
              },
              style: TextButton.styleFrom(foregroundColor: AppColors.marketRed),
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );

    if (!mounted || shouldDelete != true) {
      return;
    }

    await context.read<ProfileCubit>().deletePhoto();
  }

  Future<void> _confirmLogout() async {
    final bool? shouldLogout = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Log out?'),
          content: const Text(
            'You will need to sign in again to access your account.',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext, false);
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext, true);
              },
              style: TextButton.styleFrom(foregroundColor: AppColors.marketRed),
              child: const Text('Logout'),
            ),
          ],
        );
      },
    );

    if (!mounted || shouldLogout != true) {
      return;
    }

    await context.read<ProfileCubit>().logout();
  }

  void _saveFullName() {
    FocusScope.of(context).unfocus();

    final bool isValid = _nameFormKey.currentState?.validate() ?? false;

    if (!isValid) {
      return;
    }

    context.read<ProfileCubit>().updateFullName(_fullNameController.text);
  }

  void _openChangePassword() {
    Navigator.of(context).push(
      MaterialPageRoute<void>(builder: (_) => const ChangePasswordScreen()),
    );
  }

  void _showMessage(String message, {bool isError = false}) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: isError
              ? AppColors.marketRed
              : AppColors.marketGreenDark,
        ),
      );
  }

  void _handleProfileState(ProfileState state) {
    final profile = state.profile;

    if (profile != null && _fullNameController.text != profile.fullName) {
      _fullNameController.text = profile.fullName;

      _fullNameController.selection = TextSelection.collapsed(
        offset: _fullNameController.text.length,
      );
    }

    if (state.status == ProfileStatus.success) {
      if (state.successAction == ProfileSuccessAction.nameUpdated) {
        _showMessage('Full name updated successfully.');
      } else if (state.successAction == ProfileSuccessAction.photoUpdated) {
        _showMessage('Profile photo updated successfully.');
      } else if (state.successAction == ProfileSuccessAction.photoDeleted) {
        _showMessage('Profile photo deleted successfully.');
      }

      context.read<ProfileCubit>().clearFeedback();
      return;
    }

    if (state.status == ProfileStatus.failure && state.profile != null) {
      _showMessage(
        state.errorMessage ?? 'Unable to update the profile.',
        isError: true,
      );

      context.read<ProfileCubit>().clearFeedback();
      return;
    }

    if (state.status == ProfileStatus.signedOut) {
      Navigator.of(
        context,
      ).pushNamedAndRemoveUntil(Routers.splash, (route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileCubit, ProfileState>(
      listener: (context, state) {
        _handleProfileState(state);
      },
      builder: (context, state) {
        final colorScheme = Theme.of(context).colorScheme;

        return Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          appBar: widget.embedded
              ? null
              : AppBar(
                  backgroundColor: colorScheme.surface,
                  surfaceTintColor: Colors.transparent,
                  elevation: 0,
                  title: Text(
                    'Profile',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                      color: colorScheme.onSurface,
                    ),
                  ),
                ),
          body: _buildBody(state),
        );
      },
    );
  }

  Widget _buildBody(ProfileState state) {
    if (state.isInitialLoading) {
      return const Center(
        child: CircularProgressIndicator(color: AppColors.marketGreen),
      );
    }

    final profile = state.profile;

    if (profile == null) {
      return _ProfileErrorView(
        message: state.errorMessage ?? 'Unable to load your profile.',
        onRetry: () {
          context.read<ProfileCubit>().loadProfile();
        },
      );
    }

    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 32),
      children: [
        if (widget.embedded) ...[
          Text(
            'Profile',
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.w800,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: 16),
        ],

        ProfileSectionCard(
          child: ProfilePhotoCard(
            profile: profile,
            isBusy: state.isUpdating,
            onChangePhoto: _showPhotoSourcePicker,
            onDeletePhoto: _confirmDeletePhoto,
          ),
        ),

        const SizedBox(height: 24),

        const _SectionLabel(label: 'ACCOUNT SETTINGS'),

        const SizedBox(height: 10),

        ProfileSectionCard(
          child: Column(
            children: [
              ProfileNameEditor(
                formKey: _nameFormKey,
                controller: _fullNameController,
                isLoading: state.isUpdating,
                onSave: _saveFullName,
              ),
              const SizedBox(height: 12),
              Divider(color: Theme.of(context).dividerColor),
              ProfileActionTile(
                title: 'Change Password',
                subtitle: 'Update your account password',
                icon: Icons.lock_outline_rounded,
                enabled: !state.isBusy,
                onTap: _openChangePassword,
              ),
            ],
          ),
        ),

        const SizedBox(height: 24),

        const _SectionLabel(label: 'PREFERENCES'),

        const SizedBox(height: 10),

        ProfileSectionCard(
          child: BlocBuilder<ThemeCubit, ThemeState>(
            builder: (context, themeState) {
              return ProfileActionTile(
                title: 'Dark Mode',
                subtitle: themeState.isDarkMode
                    ? 'Dark appearance is enabled'
                    : 'Use a darker app appearance',
                icon: themeState.isDarkMode
                    ? Icons.dark_mode_rounded
                    : Icons.dark_mode_outlined,
                enabled: !state.isBusy,
                onTap: () {
                  context.read<ThemeCubit>().toggleTheme();
                },
                trailing: Switch(
                  value: themeState.isDarkMode,
                  activeThumbColor: AppColors.marketGreen,
                  onChanged: state.isBusy
                      ? null
                      : (value) {
                          context.read<ThemeCubit>().setDarkMode(value);
                        },
                ),
              );
            },
          ),
        ),

        const SizedBox(height: 24),

        const _SectionLabel(label: 'ACCOUNT'),

        const SizedBox(height: 10),

        ProfileSectionCard(
          child: ProfileActionTile(
            title: state.isSigningOut ? 'Logging out...' : 'Logout',
            subtitle: 'Sign out from this device',
            icon: Icons.logout_rounded,
            foregroundColor: AppColors.marketRed,
            enabled: !state.isBusy,
            trailing: state.isSigningOut
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: AppColors.marketRed,
                    ),
                  )
                : null,
            onTap: _confirmLogout,
          ),
        ),
      ],
    );
  }
}

class _SectionLabel extends StatelessWidget {
  const _SectionLabel({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: TextStyle(
        fontSize: 11,
        fontWeight: FontWeight.w800,
        color: Theme.of(context).colorScheme.onSurfaceVariant,
        letterSpacing: 1,
      ),
    );
  }
}

class _ProfileErrorView extends StatelessWidget {
  const _ProfileErrorView({required this.message, required this.onRetry});

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(28),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.person_off_outlined,
              size: 56,
              color: colorScheme.onSurfaceVariant,
            ),
            const SizedBox(height: 16),
            Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15,
                height: 1.5,
                color: colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 20),
            FilledButton.icon(
              onPressed: onRetry,
              icon: const Icon(Icons.refresh_rounded),
              label: const Text('Try Again'),
              style: FilledButton.styleFrom(
                backgroundColor: AppColors.marketGreen,
                foregroundColor: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
