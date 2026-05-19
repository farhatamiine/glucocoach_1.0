import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../data/models/models.dart';
import '../../../domain/providers/bolus_provider.dart';
import '../../../domain/providers/meal_provider.dart';
import '../../theme/app_colors.dart';
import '../../widgets/app_card.dart';

class AddBolusScreen extends ConsumerStatefulWidget {
  const AddBolusScreen({super.key});

  @override
  ConsumerState<AddBolusScreen> createState() => _AddBolusScreenState();
}

class _AddBolusScreenState extends ConsumerState<AddBolusScreen> {
  final _formKey = GlobalKey<FormState>();
  final _amountController = TextEditingController(text: '0.0');
  BolusType _bolusType = BolusType.MEAL;
  DateTime _timestamp = DateTime.now();
  int? _selectedMealId;
  bool _isLoading = false;

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  Future<void> _pickTimestamp() async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: _timestamp,
      firstDate: DateTime(2020),
      lastDate: DateTime.now().add(const Duration(days: 1)),
    );
    if (pickedDate != null) {
      final pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(_timestamp),
      );
      if (pickedTime != null) {
        setState(() {
          _timestamp = DateTime(
            pickedDate.year,
            pickedDate.month,
            pickedDate.day,
            pickedTime.hour,
            pickedTime.minute,
          );
        });
      }
    }
  }

  void _adjustAmount(double delta) {
    final current = double.tryParse(_amountController.text) ?? 0;
    final newValue = (current + delta).clamp(0.0, 50.0);
    _amountController.text = newValue.toStringAsFixed(1);
  }

  Future<void> _saveBolus() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      final request = BolusRequest(
        amount: double.parse(_amountController.text),
        bolusType: _bolusType,
        timestamp: _timestamp,
        mealId: _bolusType == BolusType.MEAL ? _selectedMealId : null,
      );

      await ref.read(bolusNotifierProvider.notifier).createBolus(request);

      if (mounted) {
        context.pop();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: $e'),
            backgroundColor: AppColors.error,
          ),
        );
      }
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final mealsAsync = ref.watch(mealsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Bolus'),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => context.pop(),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: AppCard(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Bolus Details',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 24),

                  // Amount with steppers
                  Row(
                    children: [
                      _StepperButton(
                        icon: Icons.remove,
                        onPressed: () => _adjustAmount(-0.5),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: TextFormField(
                          controller: _amountController,
                          keyboardType: const TextInputType.numberWithOptions(
                            decimal: true,
                          ),
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                          ),
                          decoration: const InputDecoration(
                            labelText: 'Units',
                            contentPadding: EdgeInsets.symmetric(vertical: 16),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Required';
                            }
                            final num = double.tryParse(value);
                            if (num == null || num <= 0) {
                              return 'Enter a valid amount';
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(width: 12),
                      _StepperButton(
                        icon: Icons.add,
                        onPressed: () => _adjustAmount(0.5),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Type selector
                  Text(
                    'Type',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  const SizedBox(height: 8),
                  SegmentedButton<BolusType>(
                    segments: const [
                      ButtonSegment(
                        value: BolusType.MEAL,
                        label: Text('Meal'),
                        icon: Icon(Icons.restaurant),
                      ),
                      ButtonSegment(
                        value: BolusType.CORRECTION,
                        label: Text('Correction'),
                        icon: Icon(Icons.trending_down),
                      ),
                    ],
                    selected: {_bolusType},
                    onSelectionChanged: (set) {
                      setState(() => _bolusType = set.first);
                    },
                  ),
                  const SizedBox(height: 24),

                  // Meal link (if MEAL type)
                  if (_bolusType == BolusType.MEAL)
                    mealsAsync.when(
                      data: (meals) {
                        if (meals.isEmpty) return const SizedBox.shrink();
                        final recentMeals = meals
                            .where((m) => m.timestamp.isAfter(
                                  DateTime.now().subtract(
                                    const Duration(hours: 4),
                                  ),
                                ))
                            .toList();
                        if (recentMeals.isEmpty) return const SizedBox.shrink();

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Link to Meal (optional)',
                              style: Theme.of(context).textTheme.titleSmall,
                            ),
                            const SizedBox(height: 8),
                            DropdownButtonFormField<int?>(
                              value: _selectedMealId,
                              decoration: const InputDecoration(
                                prefixIcon: Icon(Icons.restaurant_outlined),
                              ),
                              hint: const Text('Select a recent meal'),
                              items: [
                                const DropdownMenuItem<int?>(
                                  value: null,
                                  child: Text('None'),
                                ),
                                ...recentMeals.map((meal) => DropdownMenuItem(
                                      value: meal.id,
                                      child: Text(
                                        '${meal.name} (${meal.carbs.toStringAsFixed(0)}g)',
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    )),
                              ],
                              onChanged: (value) {
                                setState(() => _selectedMealId = value);
                              },
                            ),
                            const SizedBox(height: 24),
                          ],
                        );
                      },
                      loading: () => const SizedBox.shrink(),
                      error: (_, __) => const SizedBox.shrink(),
                    ),

                  // Timestamp
                  InkWell(
                    onTap: _pickTimestamp,
                    child: InputDecorator(
                      decoration: const InputDecoration(
                        labelText: 'Time',
                        prefixIcon: Icon(Icons.access_time),
                      ),
                      child: Text(
                        DateFormat('MMM d, yyyy HH:mm').format(_timestamp),
                        style: const TextStyle(color: AppColors.textPrimary),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      onPressed: _isLoading ? null : _saveBolus,
                      child: _isLoading
                          ? const SizedBox(
                              width: 24,
                              height: 24,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.white,
                              ),
                            )
                          : const Text('Save Bolus'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _StepperButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;

  const _StepperButton({required this.icon, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.primary.withValues(alpha: 0.1),
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          width: 48,
          height: 48,
          alignment: Alignment.center,
          child: Icon(icon, color: AppColors.primary),
        ),
      ),
    );
  }
}
