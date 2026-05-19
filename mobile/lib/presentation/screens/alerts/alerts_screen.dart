import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../data/models/models.dart';
import '../../../domain/providers/alert_provider.dart';
import '../../theme/app_colors.dart';
import '../../widgets/app_card.dart';

class AlertsScreen extends ConsumerStatefulWidget {
  const AlertsScreen({super.key});

  @override
  ConsumerState<AlertsScreen> createState() => _AlertsScreenState();
}

class _AlertsScreenState extends ConsumerState<AlertsScreen> {
  bool _showAddForm = false;

  @override
  Widget build(BuildContext context) {
    final alertsAsync = ref.watch(alertsProvider);
    final historyAsync = ref.watch(alertHistoryProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Alerts'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 8),
                  alertsAsync.when(
                    data: (alerts) => _buildAlertsList(context, alerts),
                    loading: () => const _LoadingCard(),
                    error: (_, __) => const _ErrorCard(),
                  ),
                  if (_showAddForm) _buildAddForm(context),
                  const SizedBox(height: 8),
                  historyAsync.when(
                    data: (history) => _buildHistoryList(context, history),
                    loading: () => const _LoadingCard(),
                    error: (_, __) => const SizedBox.shrink(),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: !_showAddForm
          ? FloatingActionButton.extended(
              onPressed: () => setState(() => _showAddForm = true),
              icon: const Icon(Icons.add),
              label: const Text('Add Alert'),
            )
          : null,
    );
  }

  Widget _buildAlertsList(BuildContext context, List<AlertResponse> alerts) {
    if (alerts.isEmpty && !_showAddForm) {
      return AppCard(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.notifications_off_outlined,
              size: 48,
              color: AppColors.textDisabled,
            ),
            const SizedBox(height: 12),
            const Text(
              'No alerts configured',
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 16,
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Set up glucose threshold alerts',
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 14,
                color: AppColors.textDisabled,
              ),
            ),
          ],
        ),
      );
    }

    return Column(
      children: alerts.map((alert) => _AlertCard(alert: alert)).toList(),
    );
  }

  Widget _buildAddForm(BuildContext context) {
    return _AlertForm(
      onCancel: () => setState(() => _showAddForm = false),
      onSave: (request) async {
        await ref.read(alertNotifierProvider.notifier).createAlert(request);
        setState(() => _showAddForm = false);
      },
    );
  }

  Widget _buildHistoryList(
    BuildContext context,
    List<AlertHistoryResponse> history,
  ) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Alert History',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 12),
          if (history.isEmpty)
            const Center(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Text(
                  'No alerts triggered yet',
                  style: TextStyle(color: AppColors.textSecondary),
                ),
              ),
            )
          else
            ...history.take(10).map((h) => _HistoryItem(history: h)),
        ],
      ),
    );
  }
}

class _AlertCard extends ConsumerWidget {
  final AlertResponse alert;

  const _AlertCard({required this.alert});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: alert.active
                      ? AppColors.success.withValues(alpha: 0.15)
                      : AppColors.textDisabled.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  Icons.notifications_active,
                  color: alert.active ? AppColors.success : AppColors.textDisabled,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${alert.thresholdLow.toStringAsFixed(0)} - ${alert.thresholdHigh.toStringAsFixed(0)} mg/dL',
                      style: const TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      'Notify via: ${alert.notifyVia.name}',
                      style: const TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 12,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              Switch(
                value: alert.active,
                onChanged: (value) async {
                  await ref
                      .read(alertNotifierProvider.notifier)
                      .updateAlert(
                        alert.id,
                        AlertRequest(
                          thresholdLow: alert.thresholdLow,
                          thresholdHigh: alert.thresholdHigh,
                          notifyVia: alert.notifyVia,
                          active: value,
                        ),
                      );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _AlertForm extends StatefulWidget {
  final VoidCallback onCancel;
  final Future<void> Function(AlertRequest) onSave;

  const _AlertForm({required this.onCancel, required this.onSave});

  @override
  State<_AlertForm> createState() => _AlertFormState();
}

class _AlertFormState extends State<_AlertForm> {
  final _formKey = GlobalKey<FormState>();
  final _lowController = TextEditingController(text: '70');
  final _highController = TextEditingController(text: '180');
  NotifyVia _notifyVia = NotifyVia.PUSH;
  bool _isLoading = false;

  @override
  void dispose() {
    _lowController.dispose();
    _highController.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    final request = AlertRequest(
      thresholdLow: double.parse(_lowController.text),
      thresholdHigh: double.parse(_highController.text),
      notifyVia: _notifyVia,
      active: true,
    );

    await widget.onSave(request);

    if (mounted) {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'New Alert',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _lowController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Low Threshold',
                      suffixText: 'mg/dL',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) return 'Required';
                      final num = double.tryParse(value);
                      if (num == null || num <= 0) return 'Invalid';
                      return null;
                    },
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: TextFormField(
                    controller: _highController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'High Threshold',
                      suffixText: 'mg/dL',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) return 'Required';
                      final num = double.tryParse(value);
                      if (num == null || num <= 0) return 'Invalid';
                      return null;
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              'Notify Via',
              style: Theme.of(context).textTheme.titleSmall,
            ),
            const SizedBox(height: 8),
            SegmentedButton<NotifyVia>(
              segments: const [
                ButtonSegment(
                  value: NotifyVia.PUSH,
                  label: Text('Push'),
                  icon: Icon(Icons.notifications),
                ),
                ButtonSegment(
                  value: NotifyVia.EMAIL,
                  label: Text('Email'),
                  icon: Icon(Icons.email),
                ),
                ButtonSegment(
                  value: NotifyVia.SMS,
                  label: Text('SMS'),
                  icon: Icon(Icons.sms),
                ),
              ],
              selected: {_notifyVia},
              onSelectionChanged: (set) {
                setState(() => _notifyVia = set.first);
              },
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: widget.onCancel,
                    child: const Text('Cancel'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _save,
                    child: _isLoading
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                        : const Text('Save'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _HistoryItem extends StatelessWidget {
  final AlertHistoryResponse history;

  const _HistoryItem({required this.history});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: history.glucoseValue < 70
                  ? AppColors.glucoseLow.withValues(alpha: 0.15)
                  : AppColors.glucoseHigh.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              history.glucoseValue < 70
                  ? Icons.trending_down
                  : Icons.trending_up,
              color: history.glucoseValue < 70
                  ? AppColors.glucoseLow
                  : AppColors.glucoseHigh,
              size: 18,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${history.glucoseValue.toStringAsFixed(0)} mg/dL',
                  style: const TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                if (history.message != null)
                  Text(
                    history.message!,
                    style: const TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 12,
                      color: AppColors.textSecondary,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
              ],
            ),
          ),
          Text(
            DateFormat('MMM d, HH:mm').format(history.triggeredAt),
            style: const TextStyle(
              fontFamily: 'Inter',
              fontSize: 12,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}

class _LoadingCard extends StatelessWidget {
  const _LoadingCard();

  @override
  Widget build(BuildContext context) {
    return const AppCard(
      child: SizedBox(
        height: 120,
        child: Center(child: CircularProgressIndicator()),
      ),
    );
  }
}

class _ErrorCard extends StatelessWidget {
  const _ErrorCard();

  @override
  Widget build(BuildContext context) {
    return const AppCard(
      child: SizedBox(
        height: 120,
        child: Center(
          child: Text(
            'Failed to load alerts',
            style: TextStyle(color: AppColors.textSecondary),
          ),
        ),
      ),
    );
  }
}
