import 'dart:math' as math;

import 'package:flutter/material.dart';
import '../../../../core/config/app_icons.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/injection/injection_container.dart';
import '../../../../core/navigation/app_navigator.dart';
import '../../../../core/storage/data/storage.dart';
import '../../../auth/presentation/view/login_view.dart';
import '../../../nav_bar/presentation/view/main_nav_view.dart';
import '../../../currency/presentation/cubit/currency_cubit.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> with TickerProviderStateMixin {
  late final AnimationController _introController;
  late final AnimationController _pulseController;
  late final Animation<double> _logoOpacity;
  late final Animation<double> _logoScale;
  late final Animation<Offset> _logoSlide;
  late final Animation<double> _contentOpacity;
  late final Animation<double> _progressValue;

  @override
  void initState() {
    super.initState();
    _introController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    );
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    )..repeat();

    _logoOpacity = CurvedAnimation(
      parent: _introController,
      curve: const Interval(0.0, 0.45, curve: Curves.easeOut),
    );
    _logoScale = Tween<double>(begin: 0.78, end: 1).animate(
      CurvedAnimation(
        parent: _introController,
        curve: const Interval(0.0, 0.65, curve: Curves.easeOutBack),
      ),
    );
    _logoSlide = Tween<Offset>(begin: const Offset(0, 0.12), end: Offset.zero)
        .animate(
          CurvedAnimation(
            parent: _introController,
            curve: const Interval(0.0, 0.65, curve: Curves.easeOutCubic),
          ),
        );
    _contentOpacity = CurvedAnimation(
      parent: _introController,
      curve: const Interval(0.45, 0.85, curve: Curves.easeOut),
    );
    _progressValue = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _introController,
        curve: const Interval(0.22, 1.0, curve: Curves.easeInOutCubic),
      ),
    );

    _introController.forward();
    _navigateWhenReady();
  }

  Future<void> _navigateWhenReady() async {
    await Future.wait([
      Future<void>.delayed(const Duration(milliseconds: 2600)),
      sl<CurrencyCubit>().ensureCurrencySelected(),
    ]);

    if (!mounted) return;

    final isLoggedIn = sl<Storage>().isAuthorized();
    sl<AppNavigator>().pushReplacement(
      screen: isLoggedIn ? const MainNavView() : const LoginView(),
    );
  }

  @override
  void dispose() {
    _introController.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DecoratedBox(
        decoration: const BoxDecoration(gradient: AppColors.primaryGradient),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final logoWidth = (constraints.maxWidth * 0.5).clamp(160.0, 238.0);
            final pulseSize = logoWidth * 1.34;

            return Stack(
              children: [
                Positioned.fill(
                  child: AnimatedBuilder(
                    animation: _pulseController,
                    builder: (context, _) {
                      return CustomPaint(
                        painter: _SplashAtmospherePainter(
                          progress: _pulseController.value,
                        ),
                      );
                    },
                  ),
                ),
                SafeArea(
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          width: pulseSize,
                          height: pulseSize,
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              AnimatedBuilder(
                                animation: _pulseController,
                                builder: (context, _) {
                                  return CustomPaint(
                                    size: Size.square(pulseSize),
                                    painter: _SplashPulsePainter(
                                      progress: _pulseController.value,
                                    ),
                                  );
                                },
                              ),
                              SlideTransition(
                                position: _logoSlide,
                                child: FadeTransition(
                                  opacity: _logoOpacity,
                                  child: ScaleTransition(
                                    scale: _logoScale,
                                    child: Image.asset(
                                      AppIcons.lloPng,
                                      width: logoWidth,
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 26),
                        FadeTransition(
                          opacity: _contentOpacity,
                          child: Column(
                            children: [
                              Text(
                                'Trevlen',
                                style: Theme.of(context).textTheme.headlineSmall
                                    ?.copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w800,
                                      letterSpacing: 0,
                                    ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Plan. Book. Travel.',
                                style: Theme.of(context).textTheme.bodyMedium
                                    ?.copyWith(
                                      color: Colors.white.withValues(
                                        alpha: 0.78,
                                      ),
                                      fontWeight: FontWeight.w500,
                                      letterSpacing: 0,
                                    ),
                              ),
                              const SizedBox(height: 28),
                              SizedBox(
                                width: 168,
                                child: AnimatedBuilder(
                                  animation: _progressValue,
                                  builder: (context, _) {
                                    return ClipRRect(
                                      borderRadius: BorderRadius.circular(999),
                                      child: LinearProgressIndicator(
                                        value: _progressValue.value,
                                        minHeight: 4,
                                        backgroundColor: Colors.white
                                            .withValues(alpha: 0.18),
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
                                              Colors.white.withValues(
                                                alpha: 0.92,
                                              ),
                                            ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _SplashPulsePainter extends CustomPainter {
  const _SplashPulsePainter({required this.progress});

  final double progress;

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);
    final maxRadius = size.shortestSide / 2;

    for (var i = 0; i < 3; i++) {
      final shifted = (progress + (i * 0.28)) % 1.0;
      final radius = maxRadius * (0.42 + shifted * 0.52);
      final opacity = (1 - shifted).clamp(0.0, 1.0) * 0.18;
      final paint = Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.4
        ..color = Colors.white.withValues(alpha: opacity);

      canvas.drawCircle(center, radius, paint);
    }

    final dotPaint = Paint()..color = Colors.white.withValues(alpha: 0.9);
    final angle = (progress * math.pi * 2) - math.pi / 2;
    final dotOffset =
        Offset(math.cos(angle), math.sin(angle)) * maxRadius * 0.48;
    canvas.drawCircle(center + dotOffset, 3.2, dotPaint);
  }

  @override
  bool shouldRepaint(covariant _SplashPulsePainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}

class _SplashAtmospherePainter extends CustomPainter {
  const _SplashAtmospherePainter({required this.progress});

  final double progress;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;
    final points = <({Offset base, double radius, double speed})>[
      (
        base: Offset(size.width * 0.18, size.height * 0.22),
        radius: 4,
        speed: 1,
      ),
      (
        base: Offset(size.width * 0.82, size.height * 0.28),
        radius: 3,
        speed: 1.3,
      ),
      (
        base: Offset(size.width * 0.72, size.height * 0.74),
        radius: 5,
        speed: 0.8,
      ),
      (
        base: Offset(size.width * 0.24, size.height * 0.68),
        radius: 2.8,
        speed: 1.15,
      ),
    ];

    for (final point in points) {
      final dy = math.sin((progress * math.pi * 2 * point.speed)) * 10;
      paint.color = Colors.white.withValues(alpha: 0.12);
      canvas.drawCircle(point.base.translate(0, dy), point.radius, paint);
    }
  }

  @override
  bool shouldRepaint(covariant _SplashAtmospherePainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}
