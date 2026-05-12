import 'package:flutter/material.dart';
import 'package:trip_marche/core/config/app_icons.dart';
import 'package:trip_marche/core/theme/app_colors.dart';
import 'package:url_launcher/url_launcher.dart';

/// A small, square Google Maps-style button used next to hotel names and
/// departure / return location details. Tapping it opens the location in the
/// Google Maps app (or browser fallback).
///
/// The button purposefully mimics the look of the Google Maps app icon:
/// a rounded white card with a subtle map-tinted background and a red
/// location pin in the centre. This keeps it instantly recognisable to users
/// without bundling the actual Google trademarked logo asset.
class GoogleMapsLinkButton extends StatelessWidget {
  const GoogleMapsLinkButton({
    super.key,
    required this.label,
    this.lat,
    this.lng,
    this.size = 36,
    this.tooltip,
  });

  /// Location label/address used as a fallback search query when [lat]/[lng]
  /// are not provided.
  final String label;

  final double? lat;
  final double? lng;

  /// Outer square size in logical pixels (the icon scales with this).
  final double size;

  /// Optional accessibility tooltip / Semantics label.
  final String? tooltip;

  bool get _hasTarget {
    final hasCoords = lat != null && lng != null;
    final hasLabel = label.trim().isNotEmpty;
    return hasCoords || hasLabel;
  }

  Future<void> _handleTap() async {
    if (!_hasTarget) return;
    Uri? uri;
    if (lat != null && lng != null) {
      uri = Uri.parse(
        'https://www.google.com/maps/search/?api=1&query=$lat,$lng',
      );
    } else {
      final encoded = Uri.encodeComponent(label.trim());
      uri = Uri.parse(
        'https://www.google.com/maps/search/?api=1&query=$encoded',
      );
    }

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!_hasTarget) {
      return const SizedBox.shrink();
    }

    final radius = BorderRadius.circular(size * 0.22);

    final button = Material(
      color: AppColors.transparent,
      borderRadius: radius,
      child: InkWell(
        onTap: _handleTap,
        borderRadius: radius,
        child: Ink(
          width: size,
          height: size,
          decoration: BoxDecoration(
            borderRadius: radius,
            color: AppColors.cardBg(context),
            border: Border.all(color: AppColors.border(context), width: 1),
            boxShadow: [
              BoxShadow(
                color: AppColors.shadow.withValues(alpha: 0.08),
                blurRadius: 4,
                offset: const Offset(0, 1),
              ),
            ],
          ),
          child: Stack(
            fit: StackFit.expand,
            children: [
              // Subtle map-tinted background (Google-blue → Google-green).
              DecoratedBox(
                decoration: BoxDecoration(
                  borderRadius: radius,
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Color(0xFFE8F0FE), Color(0xFFE6F4EA)],
                  ),
                ),
              ),
              Center(
                child: AppIcons.icon(
                  icon: AppIcons.googleMapsIcon,
                  size: size * 0.62,
                ),
              ),
            ],
          ),
        ),
      ),
    );

    return Semantics(
      button: true,
      label: tooltip ?? 'Open in Google Maps',
      child: tooltip == null
          ? button
          : Tooltip(message: tooltip!, child: button),
    );
  }
}
