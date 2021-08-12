import 'package:flutter/material.dart';

import 'package:smooth_page_indicator/smooth_page_indicator.dart';

enum EffectType {
  colorTransition,
  expanding,
  jumping,
  scale,
  scrolling,
  slide,
  swap,
  worm,
}

class OwPageIndicator extends StatelessWidget {
  final PageController pageController;
  final int length;
  final Effect effect;
  final void Function(int index) onDotClicked;
  final EdgeInsetsGeometry padding;
  final double spacing;
  final double radius;
  final double dotWidth;
  final double dotHeight;
  final double strokeWidth;
  final PaintingStyle paintStyle;
  final Color dotColor;
  final Color activeDotColor;
  final bool onTapChangePage;
  final bool loop;

  const OwPageIndicator({
    Key key,
    @required this.pageController,
    @required this.length,
    this.effect = const Effect.worm(),
    this.onDotClicked,
    this.padding,
    this.spacing = 8,
    this.radius = 5,
    this.dotWidth = 32,
    this.dotHeight = 8,
    this.strokeWidth = 1.5,
    this.paintStyle = PaintingStyle.fill,
    this.dotColor,
    this.activeDotColor,
    this.onTapChangePage = true,
  })  : this.loop = false,
        assert(length != null && length > 0),
        super(key: key);

  const OwPageIndicator.dot({
    Key key,
    @required this.pageController,
    @required this.length,
    this.effect = const Effect.worm(),
    this.onDotClicked,
    this.padding,
    this.spacing = 16,
    this.radius = 16,
    this.dotWidth = 16,
    this.dotHeight = 16,
    this.strokeWidth = 1.5,
    this.paintStyle = PaintingStyle.fill,
    this.dotColor,
    this.activeDotColor,
    this.onTapChangePage = true,
  })  : this.loop = false,
        assert(length != null && length > 0),
        super(key: key);

  const OwPageIndicator.loop({
    Key key,
    @required this.pageController,
    @required this.length,
    this.effect = const Effect.worm(),
    this.onDotClicked,
    this.padding,
    this.spacing = 8,
    this.radius = 5,
    this.dotWidth = 32,
    this.dotHeight = 8,
    this.strokeWidth = 1.5,
    this.paintStyle = PaintingStyle.fill,
    this.dotColor,
    this.activeDotColor,
    this.onTapChangePage = true,
  })  : this.loop = true,
        assert(length != null && length > 0),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      child: _pageIndicator(context),
    );
  }

  Widget _pageIndicator(BuildContext context) {
    PageController _loopController;
    if (loop) {
      _loopController = PageController(
        initialPage: (pageController.initialPage ?? 0) % length,
        viewportFraction: pageController.viewportFraction ?? 1,
        keepPage: false,
      );
      pageController.addListener(() {
        if (_loopController.hasClients && pageController.page % 1 == 0) {
          _loopController.animateToPage(
            (pageController.page % length).toInt(),
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeOutSine,
          );
        }
      });
    }

    return Column(
      children: [
        if (loop) // To build a PageView with '_loopController'
          SizedBox(
            height: 0,
            width: 1,
            child: PageView.builder(
              controller: _loopController,
              itemCount: length,
              itemBuilder: (_, i) => const SizedBox(),
            ),
          ),
        SmoothPageIndicator(
          controller: loop ? _loopController : pageController,
          count: length,
          onDotClicked: (page) {
            if (onDotClicked == null && onTapChangePage) {
              pageController.animateToPage(
                page,
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeOutSine,
              );
            }
            onDotClicked?.call(page);
          },
          effect: _getEffect(context),
        ),
      ],
    );
  }

  dynamic _getEffect(BuildContext context) {
    final Color _activeDotColor =
        activeDotColor ?? Theme.of(context).accentColor;
    final Color _dotColor = dotColor ?? _activeDotColor.withOpacity(.5);

    switch (effect.effectType) {
      case EffectType.colorTransition:
        return ColorTransitionEffect(
          spacing: spacing,
          radius: radius,
          dotWidth: dotWidth,
          dotHeight: dotHeight,
          paintStyle: paintStyle,
          strokeWidth: strokeWidth,
          dotColor: _dotColor,
          activeDotColor: _activeDotColor,
          activeStrokeWidth: effect.activeStrokeWidth,
        );
      case EffectType.expanding:
        return ExpandingDotsEffect(
          spacing: spacing,
          radius: radius,
          dotWidth: dotWidth,
          dotHeight: dotHeight,
          paintStyle: paintStyle,
          strokeWidth: strokeWidth,
          dotColor: _dotColor,
          activeDotColor: _activeDotColor,
          expansionFactor: effect.expansionFactor,
        );
      case EffectType.jumping:
        return JumpingDotEffect(
          spacing: spacing,
          radius: radius,
          dotWidth: dotWidth,
          dotHeight: dotHeight,
          paintStyle: paintStyle,
          strokeWidth: strokeWidth,
          dotColor: _dotColor,
          activeDotColor: _activeDotColor,
          elevation: effect.elevation,
        );
      case EffectType.scale:
        return ScaleEffect(
          spacing: spacing,
          radius: radius,
          dotWidth: dotWidth,
          dotHeight: dotHeight,
          paintStyle: paintStyle,
          strokeWidth: strokeWidth,
          dotColor: _dotColor,
          activeDotColor: _activeDotColor,
          activePaintStyle: effect.activePaintStyle,
          activeStrokeWidth: effect.activeStrokeWidth,
          scale: effect.scale,
        );
      case EffectType.scrolling:
        return ScrollingDotsEffect(
          spacing: spacing,
          radius: radius,
          dotWidth: dotWidth,
          dotHeight: dotHeight,
          paintStyle: paintStyle,
          strokeWidth: strokeWidth,
          dotColor: _dotColor,
          activeDotColor: _activeDotColor,
          fixedCenter: effect.fixedCenter,
          activeDotScale: effect.activeDotScale,
          activeStrokeWidth: effect.activeStrokeWidth,
          maxVisibleDots: effect.maxVisibleDots,
        );
      case EffectType.slide:
        return SlideEffect(
          spacing: spacing,
          radius: radius,
          dotWidth: dotWidth,
          dotHeight: dotHeight,
          paintStyle: paintStyle,
          strokeWidth: strokeWidth,
          dotColor: _dotColor,
          activeDotColor: _activeDotColor,
        );
      case EffectType.swap:
        return SwapEffect(
          spacing: spacing,
          radius: radius,
          dotWidth: dotWidth,
          dotHeight: dotHeight,
          paintStyle: paintStyle,
          strokeWidth: strokeWidth,
          dotColor: _dotColor,
          activeDotColor: _activeDotColor,
        );
      case EffectType.worm:
        return WormEffect(
          spacing: spacing,
          radius: radius,
          dotWidth: dotWidth,
          dotHeight: dotHeight,
          paintStyle: paintStyle,
          strokeWidth: strokeWidth,
          dotColor: _dotColor,
          activeDotColor: _activeDotColor,
        );
      default:
        return WormEffect(
          spacing: spacing,
          radius: radius,
          dotWidth: dotWidth,
          dotHeight: dotHeight,
          paintStyle: paintStyle,
          strokeWidth: strokeWidth,
          dotColor: _dotColor,
          activeDotColor: _activeDotColor,
        );
    }
  }
}

class Effect {
  final EffectType effectType;
  final double activeStrokeWidth;
  final double expansionFactor;
  final double elevation;
  final PaintingStyle activePaintStyle;
  final double scale;
  final bool fixedCenter;
  final double activeDotScale;
  final int maxVisibleDots;

  const Effect.worm()
      : this.effectType = EffectType.worm,
        this.activeStrokeWidth = null,
        this.expansionFactor = null,
        this.activeDotScale = null,
        this.elevation = null,
        this.activePaintStyle = null,
        this.scale = null,
        this.fixedCenter = null,
        this.maxVisibleDots = null;

  const Effect.colorTransition({
    this.activeStrokeWidth = 1.5,
  })  : this.effectType = EffectType.colorTransition,
        this.expansionFactor = null,
        this.activeDotScale = null,
        this.elevation = null,
        this.activePaintStyle = null,
        this.scale = null,
        this.fixedCenter = null,
        this.maxVisibleDots = null;

  const Effect.expanding({
    this.expansionFactor = 3,
  })  : this.effectType = EffectType.expanding,
        this.activeStrokeWidth = null,
        this.activeDotScale = null,
        this.elevation = null,
        this.activePaintStyle = null,
        this.scale = null,
        this.fixedCenter = null,
        this.maxVisibleDots = null;

  const Effect.jumping({
    this.elevation = 15,
  })  : this.effectType = EffectType.jumping,
        this.expansionFactor = null,
        this.activeDotScale = null,
        this.activeStrokeWidth = null,
        this.activePaintStyle = null,
        this.scale = null,
        this.fixedCenter = null,
        this.maxVisibleDots = null;

  const Effect.scale({
    this.activePaintStyle = PaintingStyle.fill,
    this.activeStrokeWidth = 1,
    this.scale = 1.4,
  })  : this.effectType = EffectType.scale,
        this.expansionFactor = null,
        this.activeDotScale = null,
        this.elevation = null,
        this.fixedCenter = null,
        this.maxVisibleDots = null;

  const Effect.scrolling({
    this.fixedCenter = true,
    this.activeDotScale = 1.3,
    this.activeStrokeWidth = 1.5,
    this.maxVisibleDots = 5,
  })  : this.effectType = EffectType.scrolling,
        this.expansionFactor = null,
        this.elevation = null,
        this.activePaintStyle = null,
        this.scale = null;
}
