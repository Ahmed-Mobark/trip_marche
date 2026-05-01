import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../widgets/price_range_slider.dart';
import '../widgets/filter_chip_option.dart';
import '../../../../core/extensions/localization.dart';

class FilterView extends StatefulWidget {
  const FilterView({super.key});

  @override
  State<FilterView> createState() => _FilterViewState();
}

class _FilterViewState extends State<FilterView> {
  RangeValues _priceRange = const RangeValues(50, 500);
  String _selectedDuration = '';
  final Set<String> _selectedTripTypes = {};
  int _selectedRating = 0;
  String _selectedCity = '';

  final List<String> _durations = ['1-3 days', '3-7 days', '7+ days'];
  final List<String> _tripTypes = [
    'Beach',
    'Adventure',
    'Cultural',
    'Safari',
    'Mountain',
    'City Tour',
    'Cruise',
    'Religious',
  ];
  final List<String> _cities = [
    'Cairo',
    'Alexandria',
    'Hurghada',
    'Sharm El Sheikh',
    'Luxor',
    'Aswan',
  ];

  void _resetFilters() {
    setState(() {
      _priceRange = const RangeValues(50, 500);
      _selectedDuration = '';
      _selectedTripTypes.clear();
      _selectedRating = 0;
      _selectedCity = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Iconsax.arrow_left, color: AppColors.darkText),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(context.tr.filterTitle, style: AppTextStyles.subtitle()),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: _resetFilters,
            child: Text(
              context.tr.filterReset,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: AppColors.primary,
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Price Range
                  PriceRangeSlider(
                    values: _priceRange,
                    min: 0,
                    max: 1000,
                    divisions: 20,
                    onChanged: (values) {
                      setState(() {
                        _priceRange = values;
                      });
                    },
                  ),
                  const SizedBox(height: 24),

                  // Duration
                  Text(
                    context.tr.filterDuration,
                    style: AppTextStyles.subtitle(),
                  ),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: _durations.map((duration) {
                      final isSelected = _selectedDuration == duration;
                      return FilterChipOption(
                        label: duration,
                        isSelected: isSelected,
                        onTap: () {
                          setState(() {
                            _selectedDuration = isSelected ? '' : duration;
                          });
                        },
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 24),

                  // Trip Type
                  Text(
                    context.tr.filterTripType,
                    style: AppTextStyles.subtitle(),
                  ),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: _tripTypes.map((type) {
                      final isSelected = _selectedTripTypes.contains(type);
                      return FilterChipOption(
                        label: type,
                        isSelected: isSelected,
                        showCheckmark: true,
                        onTap: () {
                          setState(() {
                            if (isSelected) {
                              _selectedTripTypes.remove(type);
                            } else {
                              _selectedTripTypes.add(type);
                            }
                          });
                        },
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 24),

                  // Rating Filter
                  Text(
                    context.tr.filterRating,
                    style: AppTextStyles.subtitle(),
                  ),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: [4, 3, 2, 1].map((rating) {
                      final isSelected = _selectedRating == rating;
                      return FilterChipOption(
                        label: '$rating+',
                        isSelected: isSelected,
                        leading: Icon(
                          Icons.star,
                          size: 16,
                          color: isSelected
                              ? AppColors.onImage
                              : AppColors.yellow,
                        ),
                        onTap: () {
                          setState(() {
                            _selectedRating = isSelected ? 0 : rating;
                          });
                        },
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 24),

                  // Departure City
                  Text(
                    context.tr.filterDepartureCity,
                    style: AppTextStyles.subtitle(),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: AppColors.border),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: _selectedCity.isEmpty ? null : _selectedCity,
                        hint: Text(
                          context.tr.filterSelectCity,
                          style: Theme.of(context).textTheme.bodyMedium!
                              .copyWith(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: AppColors.greyText,
                              ),
                        ),
                        isExpanded: true,
                        icon: Icon(
                          Iconsax.arrow_down_1,
                          color: AppColors.greyText,
                          size: 18,
                        ),
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: AppColors.darkText,
                        ),
                        items: _cities
                            .map(
                              (city) => DropdownMenuItem(
                                value: city,
                                child: Text(city),
                              ),
                            )
                            .toList(),
                        onChanged: (value) {
                          setState(() {
                            _selectedCity = value ?? '';
                          });
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),

          // Apply Button
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: SizedBox(
              width: double.infinity,
              height: 56,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: AppColors.primaryGradient,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ElevatedButton(
                  onPressed: () {
                    // Apply filters and pop
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.transparent,
                    shadowColor: AppColors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    context.tr.filterApply,
                    style: AppTextStyles.button(),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
