import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../widgets/trip_summary_card.dart';
import '../widgets/radio_option.dart';
import '../widgets/counter_button.dart';

class TripOptionsView extends StatefulWidget {
  const TripOptionsView({super.key});

  @override
  State<TripOptionsView> createState() => _TripOptionsViewState();
}

class _TripOptionsViewState extends State<TripOptionsView> {
  String _roomType = 'Double';
  String _busSeat = 'Middle';
  int _travelers = 1;
  final _specialRequestsController = TextEditingController();

  double get _basePrice => 699.0;
  double get _roomExtra {
    switch (_roomType) {
      case 'Single':
        return 100.0;
      case 'Triple':
        return -50.0;
      default:
        return 0.0;
    }
  }

  double get _seatExtra {
    if (_busSeat == 'Front') return 20.0;
    return 0.0;
  }

  double get _totalPrice => (_basePrice + _roomExtra + _seatExtra) * _travelers;

  @override
  void dispose() {
    _specialRequestsController.dispose();
    super.dispose();
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
        title: Text('Trip Options', style: AppTextStyles.subtitle(color: AppColors.darkText)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TripSummaryCard(
              title: 'Dahab Trip',
              subtitle: '7 Days | 20 Person | Mixed',
              trailing: Text(
                '\$699/Person',
                style: AppTextStyles.bodyMedium(color: AppColors.primary),
              ),
            ),
            const SizedBox(height: 24),
            _buildRoomTypeSection(),
            const SizedBox(height: 24),
            _buildBusSeatSection(),
            const SizedBox(height: 24),
            _buildTravelersSection(),
            const SizedBox(height: 24),
            _buildSpecialRequests(),
            const SizedBox(height: 24),
            _buildTotalPrice(),
            const SizedBox(height: 24),
            _buildContinueButton(),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildRoomTypeSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Room Type', style: AppTextStyles.subtitle(color: AppColors.darkText)),
        const SizedBox(height: 12),
        RadioOption(value: 'Single', label: 'Single Room (+\$100)', groupValue: _roomType, onChanged: (v) => setState(() => _roomType = v!)),
        RadioOption(value: 'Double', label: 'Double Room (Default)', groupValue: _roomType, onChanged: (v) => setState(() => _roomType = v!)),
        RadioOption(value: 'Triple', label: 'Triple Room (-\$50)', groupValue: _roomType, onChanged: (v) => setState(() => _roomType = v!)),
      ],
    );
  }

  Widget _buildBusSeatSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Bus Seat', style: AppTextStyles.subtitle(color: AppColors.darkText)),
        const SizedBox(height: 12),
        RadioOption(value: 'Front', label: 'Front Seat (+\$20)', groupValue: _busSeat, onChanged: (v) => setState(() => _busSeat = v!)),
        RadioOption(value: 'Middle', label: 'Middle Seat (Default)', groupValue: _busSeat, onChanged: (v) => setState(() => _busSeat = v!)),
        RadioOption(value: 'Back', label: 'Back Seat', groupValue: _busSeat, onChanged: (v) => setState(() => _busSeat = v!)),
      ],
    );
  }

  Widget _buildTravelersSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Number of Travelers', style: AppTextStyles.subtitle(color: AppColors.darkText)),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: AppColors.lightBg,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.border),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Travelers', style: AppTextStyles.bodyMedium(color: AppColors.darkText)),
              Row(
                children: [
                  CounterButton(
                    icon: Iconsax.minus,
                    onTap: () {
                      if (_travelers > 1) setState(() => _travelers--);
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      '$_travelers',
                      style: AppTextStyles.subtitle(color: AppColors.darkText),
                    ),
                  ),
                  CounterButton(
                    icon: Iconsax.add,
                    onTap: () => setState(() => _travelers++),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSpecialRequests() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Special Requests', style: AppTextStyles.subtitle(color: AppColors.darkText)),
        const SizedBox(height: 12),
        TextFormField(
          controller: _specialRequestsController,
          maxLines: 3,
          style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w500, color: AppColors.darkText),
          decoration: InputDecoration(
            hintText: 'Any special requests or dietary requirements...',
            hintStyle: GoogleFonts.inter(fontSize: 14, color: AppColors.greyText),
            filled: true,
            fillColor: AppColors.lightBg,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: AppColors.border),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: AppColors.border),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: AppColors.primary),
            ),
            contentPadding: const EdgeInsets.all(16),
          ),
        ),
      ],
    );
  }

  Widget _buildTotalPrice() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.primary.withValues(alpha: 0.2)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Total Price', style: AppTextStyles.subtitle(color: AppColors.darkText)),
          Text(
            '\$${_totalPrice.toStringAsFixed(0)}',
            style: GoogleFonts.inter(
              fontSize: 24,
              fontWeight: FontWeight.w700,
              color: AppColors.primary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContinueButton() {
    return GestureDetector(
      onTap: () {},
      child: Container(
        width: double.infinity,
        height: 56,
        decoration: BoxDecoration(
          gradient: AppColors.primaryGradient,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: Text('Continue', style: AppTextStyles.button()),
        ),
      ),
    );
  }
}
