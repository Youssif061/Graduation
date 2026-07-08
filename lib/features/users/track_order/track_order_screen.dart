import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/constants/app_spacing.dart';
import '../../../core/styles/colors.dart';
import 'cubit/track_order_cubit.dart';
import 'cubit/track_order_state.dart';
import 'data/track_order_demo_data.dart';
import 'models/track_order_model.dart';
import 'widgets/item_summary_card.dart';
import 'widgets/order_overview_card.dart';
import 'widgets/order_progress_card.dart';
import 'widgets/service_address_card.dart';
import 'widgets/track_order_header.dart';

class TrackOrderScreen extends StatelessWidget {
  const TrackOrderScreen({
    super.key,
    required this.order,
  });

  final TrackOrderModel order;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => TrackOrderCubit(order: order),
      child: Scaffold(
        backgroundColor: AppColors.lightBackgroundColor,
        body: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.screenPadding,
                ),
                child: const TrackOrderHeader(),
              ),
              Expanded(
                child: BlocBuilder<TrackOrderCubit, TrackOrderState>(
                  builder: (context, state) {
                    return SingleChildScrollView(
                      padding: const EdgeInsets.fromLTRB(
                        AppSpacing.screenPadding,
                        AppSpacing.md,
                        AppSpacing.screenPadding,
                        AppSpacing.xl,
                      ),
                      child: Column(
                        children: [
                          OrderOverviewCard(
                            order: state.order,
                          ),
                          const SizedBox(height: AppSpacing.lg),
                          OrderProgressCard(
                            state: state,
                          ),
                          const SizedBox(height: AppSpacing.lg),
                          ServiceAddressCard(
                            order: state.order,
                          ),
                          const SizedBox(height: AppSpacing.lg),
                          ItemSummaryCard(
                            order: state.order,
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static Widget demo() {
    return TrackOrderScreen(
      order: demoTrackOrder,
    );
  }
}