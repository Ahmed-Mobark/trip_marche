import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/theme/app_colors.dart';

/// A row of single-digit OTP input boxes.
///
/// Manages its own [TextEditingController]s and [FocusNode]s internally.
/// Use [onCompleted] to be notified when all digits have been entered, and
/// [onChanged] to receive the current partial value on every keystroke.
class OtpInputField extends StatefulWidget {
  /// Number of OTP digits. Defaults to 4.
  final int length;

  /// Size of each individual box. Defaults to 52.
  final double boxSize;

  /// Spacing between boxes. Defaults to 12.
  final double spacing;

  /// Called with the full OTP string when all digits are entered.
  final ValueChanged<String>? onCompleted;

  /// Called with the current partial OTP string on every change.
  final ValueChanged<String>? onChanged;

  const OtpInputField({
    super.key,
    this.length = 4,
    this.boxSize = 48,
    this.spacing = 8,
    this.onCompleted,
    this.onChanged,
  });

  @override
  State<OtpInputField> createState() => _OtpInputFieldState();
}

class _OtpInputFieldState extends State<OtpInputField> {
  late final List<TextEditingController> _controllers;
  late final List<FocusNode> _focusNodes;

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(widget.length, (_) => TextEditingController());
    _focusNodes = List.generate(widget.length, (_) => FocusNode());
  }

  @override
  void dispose() {
    for (final c in _controllers) {
      c.dispose();
    }
    for (final n in _focusNodes) {
      n.dispose();
    }
    super.dispose();
  }

  String get _currentOtp => _controllers.map((c) => c.text).join();

  void _handleChanged(String value, int index) {
    if (value.isNotEmpty && index < widget.length - 1) {
      _focusNodes[index + 1].requestFocus();
    }
    if (value.isEmpty && index > 0) {
      _focusNodes[index - 1].requestFocus();
    }
    setState(() {});

    final otp = _currentOtp;
    widget.onChanged?.call(otp);
    if (otp.length == widget.length) {
      widget.onCompleted?.call(otp);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(widget.length, (index) {
        final child = Container(
          margin: EdgeInsets.symmetric(horizontal: widget.spacing / 2),
          height: widget.boxSize,
          decoration: BoxDecoration(
            color: AppColors.inputBg,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Center(
            child: TextField(
              controller: _controllers[index],
              focusNode: _focusNodes[index],
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              maxLength: 1,
              style: GoogleFonts.inter(
                fontSize: 24,
                fontWeight: FontWeight.w700,
                color: AppColors.darkText,
              ),
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              decoration: const InputDecoration(
                counterText: '',
                border: InputBorder.none,
                contentPadding: EdgeInsets.zero,
              ),
              onChanged: (value) => _handleChanged(value, index),
            ),
          ),
        );

        return Expanded(child: child);
      }),
    );
  }
}
