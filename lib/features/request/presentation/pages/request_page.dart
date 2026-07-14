import 'package:expertisemarket/core/styles/colors.dart';
import 'package:expertisemarket/features/request/data/firebase_request_repository.dart';
import 'package:expertisemarket/features/request/presentation/cubit/request_cubit.dart';
import 'package:expertisemarket/features/request/presentation/cubit/request_state.dart';
import 'package:expertisemarket/features/request/presentation/widgets/expert_tip_card.dart';
import 'package:expertisemarket/features/request/presentation/widgets/photo_upload_section.dart';
import 'package:expertisemarket/features/request/presentation/widgets/post_request_button.dart';
import 'package:expertisemarket/features/request/presentation/widgets/pricing_preference_section.dart';
import 'package:expertisemarket/features/request/presentation/widgets/request_header.dart';
import 'package:expertisemarket/features/request/presentation/widgets/request_section_card.dart';
import 'package:expertisemarket/features/request/presentation/widgets/request_text_field.dart';
import 'package:expertisemarket/features/request/presentation/widgets/urgency_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class RequestPage extends StatelessWidget {
  const RequestPage({super.key, this.repository});

  final FirebaseRequestRepository? repository;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          RequestCubit(repository: repository ?? FirebaseRequestRepository()),
      child: const _RequestView(),
    );
  }
}

class _RequestView extends StatefulWidget {
  const _RequestView();

  @override
  State<_RequestView> createState() => _RequestViewState();
}

class _RequestViewState extends State<_RequestView> {
  final _formKey = GlobalKey<FormState>();

  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _budgetController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _budgetController.dispose();
    super.dispose();
  }

  Future<void> _showPhotoSourcePicker() async {
    final source = await showModalBottomSheet<ImageSource>(
      context: context,
      showDragHandle: true,
      backgroundColor: AppColors.marketCard,
      builder: (sheetContext) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Attach Photo',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: AppColors.marketText,
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

    await context.read<RequestCubit>().pickPhoto(source);
  }

  void _submitRequest() {
    FocusScope.of(context).unfocus();

    if (!(_formKey.currentState?.validate() ?? false)) {
      return;
    }

    context.read<RequestCubit>().submitRequest(
      title: _titleController.text,
      description: _descriptionController.text,
      budgetText: _budgetController.text,
    );
  }

  void _clearControllers() {
    _titleController.clear();
    _descriptionController.clear();
    _budgetController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RequestCubit, RequestState>(
      listener: (context, state) {
        if (state.submissionStatus == RequestSubmissionStatus.success) {
          _clearControllers();

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Your request has been posted successfully.'),
              backgroundColor: AppColors.marketGreenDark,
            ),
          );

          context.read<RequestCubit>().clearFeedback();
        }

        if (state.submissionStatus == RequestSubmissionStatus.failure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                state.errorMessage ?? 'Unable to post the request.',
              ),
              backgroundColor: AppColors.marketRed,
            ),
          );

          context.read<RequestCubit>().clearFeedback();
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: AppColors.marketBg,
          body: SafeArea(
            bottom: false,
            child: Column(
              children: [
                RequestHeader(
                  onNotificationTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('No new notifications.')),
                    );
                  },
                ),
                Expanded(
                  child: Form(
                    key: _formKey,
                    child: SingleChildScrollView(
                      keyboardDismissBehavior:
                          ScrollViewKeyboardDismissBehavior.onDrag,
                      padding: const EdgeInsets.fromLTRB(16, 28, 16, 32),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Post a New Request',
                            style: TextStyle(
                              fontSize: 29,
                              height: 1.15,
                              fontWeight: FontWeight.w700,
                              color: AppColors.marketText,
                            ),
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            'Describe your project or problem to get offers from verified experts.',
                            style: TextStyle(
                              fontSize: 16,
                              height: 1.5,
                              color: AppColors.marketTextSub,
                            ),
                          ),
                          const SizedBox(height: 26),
                          RequestSectionCard(
                            child: RequestTextField(
                              controller: _titleController,
                              label: 'Request Title',
                              hintText: 'e.g. Kitchen Sink Leak',
                              textInputAction: TextInputAction.next,
                              validator: (value) {
                                final title = value?.trim() ?? '';

                                if (title.isEmpty) {
                                  return 'Please enter a request title';
                                }

                                if (title.length < 3) {
                                  return 'Enter at least 3 characters';
                                }

                                return null;
                              },
                            ),
                          ),
                          const SizedBox(height: 18),
                          RequestSectionCard(
                            child: RequestTextField(
                              controller: _descriptionController,
                              label: 'Detailed Description',
                              hintText:
                                  'Describe the problem, when it started, and what you have tried so far...',
                              maxLines: 7,
                              validator: (value) {
                                final description = value?.trim() ?? '';

                                if (description.isEmpty) {
                                  return 'Please describe your request';
                                }

                                if (description.length < 10) {
                                  return 'Please provide more details';
                                }

                                return null;
                              },
                            ),
                          ),
                          const SizedBox(height: 18),
                          RequestSectionCard(
                            child: PhotoUploadSection(
                              selectedPhoto: state.selectedPhoto,
                              onUploadPressed: _showPhotoSourcePicker,
                              onRemovePressed: () {
                                context.read<RequestCubit>().removePhoto();
                              },
                            ),
                          ),
                          const SizedBox(height: 18),
                          RequestSectionCard(
                            child: UrgencySelector(
                              selectedUrgency: state.urgency,
                              onChanged: (urgency) {
                                context.read<RequestCubit>().changeUrgency(
                                  urgency,
                                );
                              },
                            ),
                          ),
                          const SizedBox(height: 18),
                          RequestSectionCard(
                            child: PricingPreferenceSection(
                              budgetController: _budgetController,
                              willingToNegotiate: state.willingToNegotiate,
                              onNegotiationChanged: (value) {
                                context.read<RequestCubit>().changeNegotiation(
                                  value,
                                );
                              },
                              budgetValidator: (value) {
                                final budgetText = value?.trim() ?? '';

                                if (!state.willingToNegotiate &&
                                    budgetText.isEmpty) {
                                  return 'Enter a budget or enable negotiation';
                                }

                                if (budgetText.isNotEmpty) {
                                  final budget = double.tryParse(budgetText);

                                  if (budget == null || budget <= 0) {
                                    return 'Enter a valid budget amount';
                                  }
                                }

                                return null;
                              },
                            ),
                          ),
                          const SizedBox(height: 18),
                          const ExpertTipCard(),
                          const SizedBox(height: 24),
                          PostRequestButton(
                            isLoading: state.isSubmitting,
                            onPressed: _submitRequest,
                          ),
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
    );
  }
}
