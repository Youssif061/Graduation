import 'package:expertisemarket/core/styles/colors.dart';
import 'package:flutter/material.dart';

import '../cubit/conversations_state.dart';

class ConversationsFilterBar extends StatelessWidget {
  const ConversationsFilterBar({
    super.key,
    required this.selectedFilter,
    required this.onFilterSelected,
  });

  final ConversationsFilter selectedFilter;
  final ValueChanged<ConversationsFilter> onFilterSelected;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      height: 47,
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.55),
        borderRadius: BorderRadius.circular(13),
      ),
      child: Row(
        children: ConversationsFilter.values.map((filter) {
          final isSelected = selectedFilter == filter;

          return Expanded(
            child: InkWell(
              onTap: () => onFilterSelected(filter),
              borderRadius: BorderRadius.circular(10),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 180),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: isSelected ? colorScheme.surface : Colors.transparent,
                  borderRadius: BorderRadius.circular(10),
                  border: isSelected
                      ? Border.all(color: colorScheme.outlineVariant)
                      : null,
                  boxShadow: isSelected
                      ? [
                          BoxShadow(
                            color: colorScheme.shadow.withValues(alpha: 0.06),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ]
                      : null,
                ),
                child: Text(
                  _label(filter),
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: isSelected ? FontWeight.w800 : FontWeight.w600,
                    color: isSelected
                        ? AppColors.marketGreenDark
                        : colorScheme.onSurfaceVariant,
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  String _label(ConversationsFilter filter) {
    switch (filter) {
      case ConversationsFilter.all:
        return 'All';

      case ConversationsFilter.active:
        return 'Active';

      case ConversationsFilter.archived:
        return 'Archived';
    }
  }
}
