import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class OfflineBanner extends StatelessWidget {
  final bool isOffline;

  const OfflineBanner({
    super.key,
    required this.isOffline,
  });

  @override
  Widget build(BuildContext context) {
    if (!isOffline) return const SizedBox.shrink();

    return Container(
      width: double.infinity,
      color: AppColors.warning.withValues(alpha: 0.15),
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.cloud_off,
            size: 16,
            color: AppColors.warning,
          ),
          SizedBox(width: 8),
          Text(
            'Offline mode — showing cached data',
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: AppColors.warning,
            ),
          ),
        ],
      ),
    );
  }
}
