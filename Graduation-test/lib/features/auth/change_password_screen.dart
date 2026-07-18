import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../core/constants/app_icon_sizes.dart';
import '../../core/constants/app_icons.dart';
import '../../core/constants/app_spacing.dart';
import '../../core/functions/validations.dart';
import '../../core/styles/colors.dart';
import '../../core/styles/text_styles.dart';
import '../../core/widgets/app_button.dart';
import '../../core/widgets/app_password_field.dart';
import 'cubit/change_password_cubit.dart';
import 'cubit/change_password_state.dart';
import 'widgets/password_strength_bar.dart';
import 'widgets/security_standards_card.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _currentPasswordController =
      TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;

  @override
  void dispose() {
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _onNewPasswordChanged(String value) {
    setState(() {});
  }

  void _onUpdatePasswordPressed(BuildContext context) {
    FocusScope.of(context).unfocus();

    final bool isValid = _formKey.currentState?.validate() ?? false;

    if (!isValid) {
      setState(() {
        _autovalidateMode = AutovalidateMode.onUserInteraction;
      });
      return;
    }

    context.read<ChangePasswordCubit>().changePassword(
      currentPassword: _currentPasswordController.text.trim(),
      newPassword: _newPasswordController.text,
      confirmPassword: _confirmPasswordController.text,
    );
  }

  void _handleSuccess(BuildContext context) {
    _currentPasswordController.clear();
    _newPasswordController.clear();
    _confirmPasswordController.clear();

    setState(() {
      _autovalidateMode = AutovalidateMode.disabled;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Password updated successfully')),
    );

    context.read<ChangePasswordCubit>().resetStatus();
  }

  void _handleFailure(BuildContext context, String? errorMessage) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(errorMessage ?? 'Failed to update password')),
    );

    context.read<ChangePasswordCubit>().resetStatus();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ChangePasswordCubit(),
      child: BlocConsumer<ChangePasswordCubit, ChangePasswordState>(
        listener: (context, state) {
          if (state.isSuccess) {
            _handleSuccess(context);
          }

          if (state.isFailure) {
            _handleFailure(context, state.errorMessage);
          }
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: AppColors.lightBackgroundColor,
            body: SafeArea(
              child: Column(
                children: [
                  _ChangePasswordHeader(
                    onBackPressed: () => Navigator.of(context).maybePop(),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.screenPadding,
                      ),
                      child: Form(
                        key: _formKey,
                        autovalidateMode: _autovalidateMode,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 32),
                            const SecurityStandardsCard(),
                            const SizedBox(height: 34),
                            AppPasswordField(
                              label: 'Current Password',
                              controller: _currentPasswordController,
                              hintText: '••••••••',
                              textInputAction: TextInputAction.next,
                              validator: (value) {
                                return AppValidations.requiredPassword(
                                  value,
                                  fieldName: 'Current password',
                                );
                              },
                            ),
                            const SizedBox(height: 31),
                            AppPasswordField(
                              label: 'New Password',
                              controller: _newPasswordController,
                              hintText: '••••••••',
                              textInputAction: TextInputAction.next,
                              onChanged: _onNewPasswordChanged,
                              validator: (value) {
                                return AppValidations.newPassword(
                                  value,
                                  currentPassword: _currentPasswordController
                                      .text
                                      .trim(),
                                );
                              },
                            ),
                            const SizedBox(height: 13),
                            PasswordStrengthBar(
                              password: _newPasswordController.text,
                            ),
                            const SizedBox(height: 34),
                            AppPasswordField(
                              label: 'Confirm New Password',
                              controller: _confirmPasswordController,
                              hintText: '••••••••',
                              textInputAction: TextInputAction.done,
                              validator: (value) {
                                return AppValidations.confirmPassword(
                                  value,
                                  newPassword: _newPasswordController.text,
                                );
                              },
                            ),
                            const SizedBox(height: 64),
                            AppButton(
                              title: 'Update Password',
                              iconPath: AppIcons.shieldCheck,
                              iconWidth: AppIconSizes.buttonShieldCheckWidth,
                              iconHeight: AppIconSizes.buttonShieldCheckHeight,
                              iconPosition: AppButtonIconPosition.trailing,
                              isLoading: state.isLoading,
                              onPressed: state.isLoading
                                  ? null
                                  : () => _onUpdatePasswordPressed(context),
                            ),
                            const SizedBox(height: 32),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _ChangePasswordHeader extends StatelessWidget {
  const _ChangePasswordHeader({required this.onBackPressed});

  final VoidCallback onBackPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppSpacing.appBarHeight,
      decoration: BoxDecoration(
        color: AppColors.lightBackgroundColor,
        border: Border(
          bottom: BorderSide(
            color: AppColors.inputBorderColor.withValues(alpha: 0.25),
          ),
        ),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 48,
            child: IconButton(
              onPressed: onBackPressed,
              padding: EdgeInsets.zero,
              icon: SvgPicture.asset(
                AppIcons.arrowLeft,
                width: AppIconSizes.backArrowWidth,
                height: AppIconSizes.backArrowHeight,
                colorFilter: const ColorFilter.mode(
                  AppColors.navyColor,
                  BlendMode.srcIn,
                ),
              ),
            ),
          ),
          Expanded(
            child: Text(
              'Change Password',
              style: ExpertiseTextStyles.screenTitle,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: SvgPicture.asset(
              AppIcons.shield,
              width: AppIconSizes.headerShieldWidth,
              height: AppIconSizes.headerShieldHeight,
              colorFilter: const ColorFilter.mode(
                AppColors.navyColor,
                BlendMode.srcIn,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
