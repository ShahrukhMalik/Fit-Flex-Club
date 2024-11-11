// lib/core/theme/loader_theme.dart
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io' show Platform;

enum LoaderType {
  circular, // Standard spinning loader
  progress, // Determinate progress
  adaptive, // Platform specific loader
  linear, // Linear progress indicator
  refresh, // Pull to refresh indicator
  shimmer, // Shimmer loading effect
  custom, // Custom animated loader
  countdown // Countdown timer loader
}

class PlatformLoader {
   Widget buildLoader({
    required LoaderType type,
    Color? color,
    double? size,
    double? value, // For determinate progress (0.0 to 1.0)
    double? strokeWidth, // Width of the loader stroke
    Duration? duration, // Animation duration
    bool isAnimating = true, // Control animation state
    Widget? child, // For custom loaders
    String? semanticsLabel, // Accessibility label
    String? semanticsValue, // Accessibility value
  }) {
    switch (type) {
      case LoaderType.circular:
        return _buildCircularLoader(
          color: color,
          size: size,
          value: value,
          strokeWidth: strokeWidth,
          isAnimating: isAnimating,
          semanticsLabel: semanticsLabel,
          semanticsValue: semanticsValue,
        );

      case LoaderType.progress:
        return _buildProgressLoader(
          color: color,
          size: size,
          value: value,
          strokeWidth: strokeWidth,
          semanticsLabel: semanticsLabel,
          semanticsValue: semanticsValue,
        );

      case LoaderType.adaptive:
        return _buildAdaptiveLoader(
          color: color,
          size: size,
          value: value,
          isAnimating: isAnimating,
        );

      case LoaderType.linear:
        return _buildLinearLoader(
          color: color,
          value: value,
          height: size,
          semanticsLabel: semanticsLabel,
          semanticsValue: semanticsValue,
        );

      case LoaderType.refresh:
        return _buildRefreshLoader(
          color: color,
          size: size,
          value: value,
        );

      case LoaderType.shimmer:
        return _buildShimmerLoader(
          color: color,
          child: child,
          duration: duration,
        );

      case LoaderType.custom:
        return _buildCustomLoader(
          color: color,
          size: size,
          duration: duration,
          child: child,
        );

      case LoaderType.countdown:
        return _buildCountdownLoader(
          color: color,
          size: size,
          duration: duration ?? const Duration(seconds: 3),
          strokeWidth: strokeWidth,
        );
    }
  }

  // 1. Circular Loader (Indeterminate)
  Widget _buildCircularLoader({
    Color? color,
    double? size,
    double? value,
    double? strokeWidth,
    bool isAnimating = true,
    String? semanticsLabel,
    String? semanticsValue,
  }) {
    if (Platform.isIOS) {
      return CupertinoActivityIndicator(
        color: color,
        radius: (size ?? 10) / 2,
        animating: isAnimating,
      );
    } else {
      return SizedBox(
        width: size,
        height: size,
        child: CircularProgressIndicator(
          color: color,
          strokeWidth: strokeWidth ?? 4.0,
          semanticsLabel: semanticsLabel,
          semanticsValue: semanticsValue,
        ),
      );
    }
  }

  // 2. Progress Loader (Determinate)
  Widget _buildProgressLoader({
    Color? color,
    double? size,
    double? value,
    double? strokeWidth,
    String? semanticsLabel,
    String? semanticsValue,
  }) {
    if (Platform.isIOS) {
      return CupertinoActivityIndicator.partiallyRevealed(
        color: color,
        radius: (size ?? 10) / 2,
        progress: value ?? 0.0,
      );
    } else {
      return SizedBox(
        width: size,
        height: size,
        child: CircularProgressIndicator(
          value: value,
          color: color,
          strokeWidth: strokeWidth ?? 4.0,
          semanticsLabel: semanticsLabel,
          semanticsValue: semanticsValue,
        ),
      );
    }
  }

  // 3. Adaptive Loader (Platform Specific)
  Widget _buildAdaptiveLoader({
    Color? color,
    double? size,
    double? value,
    bool isAnimating = true,
  }) {
    if (Platform.isIOS) {
      if (value != null) {
        return CupertinoActivityIndicator.partiallyRevealed(
          color: color,
          radius: (size ?? 10) / 2,
          progress: value,
        );
      }
      return CupertinoActivityIndicator(
        color: color,
        radius: (size ?? 10) / 2,
        animating: isAnimating,
      );
    } else {
      return Theme(
        data: ThemeData(
          progressIndicatorTheme: ProgressIndicatorThemeData(
            color: color,
          ),
        ),
        child: SizedBox(
          width: size,
          height: size,
          child: CircularProgressIndicator(
            value: value,
            strokeWidth: 4.0,
          ),
        ),
      );
    }
  }

  // 4. Linear Loader
  Widget _buildLinearLoader({
    Color? color,
    double? value,
    double? height,
    String? semanticsLabel,
    String? semanticsValue,
  }) {
    if (Platform.isIOS) {
      return SizedBox(
        height: height ?? 2.0,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(height ?? 2.0),
          child: CupertinoActivityIndicator(
            color: color,
          ),
        ),
      );
    } else {
      return LinearProgressIndicator(
        value: value,
        color: color,
        minHeight: height,
        semanticsLabel: semanticsLabel,
        semanticsValue: semanticsValue,
      );
    }
  }

  // 5. Refresh Loader
  Widget _buildRefreshLoader({
    Color? color,
    double? size,
    double? value,
  }) {
    if (Platform.isIOS) {
      return CupertinoSliverRefreshControl(
        refreshTriggerPullDistance: size ?? 100.0,
        refreshIndicatorExtent: size ?? 60.0,
      );
    } else {
      return RefreshProgressIndicator(
        value: value,
        color: color,
        backgroundColor: Colors.white,
      );
    }
  }

  // 6. Shimmer Loader
  Widget _buildShimmerLoader({
    Color? color,
    Widget? child,
    Duration? duration,
  }) {
    return ShimmerLoader(
      baseColor: color ?? Colors.grey[300]!,
      highlightColor: color?.withOpacity(0.7) ?? Colors.grey[100]!,
      duration: duration ?? const Duration(milliseconds: 1500),
      child: child ??
          Container(
            width: double.infinity,
            height: 100,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
          ),
    );
  }

  // 7. Custom Animated Loader
  Widget _buildCustomLoader({
    Color? color,
    double? size,
    Duration? duration,
    Widget? child,
  }) {
    return CustomAnimatedLoader(
      color: color ?? Colors.blue,
      size: size ?? 50,
      duration: duration ?? const Duration(milliseconds: 1500),
      child: child,
    );
  }

  // 8. Countdown Loader
  Widget _buildCountdownLoader({
    Color? color,
    double? size,
    Duration duration = const Duration(seconds: 3),
    double? strokeWidth,
  }) {
    return CountdownLoader(
      duration: duration,
      color: color ?? Colors.blue,
      size: size ?? 50,
      strokeWidth: strokeWidth ?? 4.0,
    );
  }
}

// Custom Shimmer Loader Implementation
class ShimmerLoader extends StatefulWidget {
  final Color baseColor;
  final Color highlightColor;
  final Duration duration;
  final Widget child;

  const ShimmerLoader({
    super.key,
    required this.baseColor,
    required this.highlightColor,
    required this.duration,
    required this.child,
  });

  @override
  State<ShimmerLoader> createState() => _ShimmerLoaderState();
}

class _ShimmerLoaderState extends State<ShimmerLoader>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Color?> _colorAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    )..repeat(reverse: true);

    _colorAnimation = ColorTween(
      begin: widget.baseColor,
      end: widget.highlightColor,
    ).animate(_controller);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return ShaderMask(
          shaderCallback: (bounds) {
            return LinearGradient(
              colors: [
                _colorAnimation.value!,
                widget.highlightColor,
                _colorAnimation.value!,
              ],
              stops: const [0.0, 0.5, 1.0],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ).createShader(bounds);
          },
          child: widget.child,
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

// Custom Animated Loader Implementation
class CustomAnimatedLoader extends StatefulWidget {
  final Color color;
  final double size;
  final Duration duration;
  final Widget? child;

  const CustomAnimatedLoader({
    super.key,
    required this.color,
    required this.size,
    required this.duration,
    this.child,
  });

  @override
  State<CustomAnimatedLoader> createState() => _CustomAnimatedLoaderState();
}

class _CustomAnimatedLoaderState extends State<CustomAnimatedLoader>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    )..repeat();
  }

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: _controller,
      child: widget.child ??
          Icon(
            Icons.refresh,
            color: widget.color,
            size: widget.size,
          ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

// Countdown Loader Implementation
class CountdownLoader extends StatefulWidget {
  final Duration duration;
  final Color color;
  final double size;
  final double strokeWidth;

  const CountdownLoader({
    Key? key,
    required this.duration,
    required this.color,
    required this.size,
    required this.strokeWidth,
  }) : super(key: key);

  @override
  State<CountdownLoader> createState() => _CountdownLoaderState();
}

class _CountdownLoaderState extends State<CountdownLoader>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    )..forward();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.size,
      height: widget.size,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Stack(
            children: [
              CircularProgressIndicator(
                value: 1 - _controller.value,
                color: widget.color,
                strokeWidth: widget.strokeWidth,
              ),
              Center(
                child: Text(
                  '${((1 - _controller.value) * (widget.duration.inSeconds)).round()}',
                  style: TextStyle(
                    color: widget.color,
                    fontSize: widget.size * 0.3,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

// Example Usage
