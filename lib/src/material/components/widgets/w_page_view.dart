import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:loop_page_view/loop_page_view.dart';
import 'package:page_view_indicators/page_view_indicators.dart';
import 'package:carousel_slider/carousel_slider.dart';

export 'package:loop_page_view/loop_page_view.dart';

enum PageIndicator {
  none,
  top,
  bottom,
  stackTop,
  stackBottom,
}

enum IndicatorDotTouch {
  none,
  goToPage,
  goToOnlyCheckedPage,
}

// ! Deixar passar um filho pro pageIndicator (como por exemplo, exibir as miniaturas das imagens)
// ! Criar um Builder
// ! Colocar opção pra desabilitar rolagem (quando dá zoom em uma imagem e arrasta pro lado (no zoom), vai pra próxima imagem)
// ! Adicionar (tela inicial venver): 

// Maybe add this too: https://pub.dev/packages/expandable_page_view
class OwPageView extends StatefulWidget {
  final double height;
  final bool pageSnapping; // It scrolls automatically to the center of the widget
  final PageController controller;
  final List<Widget> children;
  final ScrollPhysics physics;
  final bool reverse;
  final PageIndicator pageIndicator;
  final EdgeInsetsGeometry padding;
  final double indicatorWidgetSpacing;
  final Gradient stackGradient;
  final bool centeredChildren;

  final LoopPageController loopController;
  final bool loop;

  final CarouselController carouselController;
  final bool carousel;
  final bool infiniteScroll;
  final Duration autoPlayInterval;
  final bool autoPlay;
  final Duration autoPlayAnimationDuration;
  final Curve autoPlayCurve;
  final int initialCarouselPage;
  final double aspectRatio;

  /// Define the action while touch the step dot (if not 'none', needs a controller)
  final IndicatorDotTouch stepPageDotTouch;
  final bool stepPageIndicator;
  final double dotSize;
  final double selectedDotSize;
  final Color dotBorderColor;
  final double dotBorderWidth;
  final double dotSpacing;
  final Color selectedDotBorderColor;
  final Color selectedDotColor;
  final Color dotColor;
  final ValueChanged<int> onDotIndicatorSelected;
  final Widget previousStep;
  final Widget selectedStep;
  final Widget nextStep;

  const OwPageView({
    Key key,
    @required this.children,
    @required this.height,
    this.pageSnapping = true,
    this.controller,
    this.reverse = false,
    this.physics = const BouncingScrollPhysics(),
    this.pageIndicator = PageIndicator.stackBottom,
    this.padding,
    this.dotSize = 16,
    this.selectedDotSize = 18,
    this.dotBorderColor,
    this.dotBorderWidth = 0,
    this.dotSpacing = 8,
    this.selectedDotBorderColor,
    this.selectedDotColor,
    this.dotColor,
    this.indicatorWidgetSpacing = 10,
    this.stackGradient,
    this.centeredChildren = true,
    this.stepPageDotTouch = IndicatorDotTouch.goToPage,
    this.stepPageIndicator = false,
    this.previousStep,
    this.selectedStep,
    this.nextStep,
    this.onDotIndicatorSelected,
  })  : this.loop = false,
        this.loopController = null,
        this.carousel = false,
        this.infiniteScroll = null,
        this.autoPlayInterval = null,
        this.autoPlay = null,
        this.autoPlayAnimationDuration = null,
        this.autoPlayCurve = null,
        this.carouselController = null,
        this.initialCarouselPage = null,
        this.aspectRatio = null,
        super(key: key);

  const OwPageView.loop({
    Key key,
    @required this.children,
    @required this.height,
    this.pageSnapping = true,
    this.loopController,
    this.reverse = false,
    this.physics = const BouncingScrollPhysics(),
    this.pageIndicator = PageIndicator.stackBottom,
    this.padding,
    this.dotSize = 12,
    this.selectedDotSize = 14,
    this.dotBorderColor,
    this.dotBorderWidth = 0,
    this.dotSpacing = 8,
    this.selectedDotBorderColor,
    this.selectedDotColor,
    this.dotColor,
    this.indicatorWidgetSpacing = 10,
    this.stackGradient,
    this.centeredChildren = true,
    this.onDotIndicatorSelected,
  })  : this.controller = null,
        this.loop = true,
        this.stepPageIndicator = false,
        this.stepPageDotTouch = IndicatorDotTouch.none,
        this.previousStep = null,
        this.selectedStep = null,
        this.nextStep = null,
        this.carousel = false,
        this.infiniteScroll = null,
        this.autoPlayInterval = null,
        this.autoPlay = null,
        this.autoPlayAnimationDuration = null,
        this.autoPlayCurve = null,
        this.carouselController = null,
        this.initialCarouselPage = null,
        this.aspectRatio = null,
        super(key: key);

  const OwPageView.carousel({
    Key key,
    @required this.children,
    @required this.height,
    this.carouselController,
    this.pageSnapping = true,
    this.reverse = false,
    this.physics = const BouncingScrollPhysics(),
    this.pageIndicator = PageIndicator.stackBottom,
    this.padding,
    this.dotSize = 12,
    this.selectedDotSize = 14,
    this.dotBorderColor,
    this.dotBorderWidth = 0,
    this.dotSpacing = 8,
    this.selectedDotBorderColor,
    this.selectedDotColor,
    this.dotColor,
    this.indicatorWidgetSpacing = 10,
    this.stackGradient,
    this.centeredChildren = true,
    this.onDotIndicatorSelected,
    this.infiniteScroll = true,
    this.autoPlayInterval = const Duration(seconds: 5),
    this.autoPlay = true,
    this.autoPlayAnimationDuration = const Duration(milliseconds: 800),
    this.autoPlayCurve = Curves.fastOutSlowIn,
    this.initialCarouselPage = 0,
    this.aspectRatio = 1.64,
  })  : this.controller = null,
        this.loop = false,
        this.stepPageIndicator = false,
        this.stepPageDotTouch = IndicatorDotTouch.none,
        this.previousStep = null,
        this.selectedStep = null,
        this.nextStep = null,
        this.carousel = true,
        this.loopController = null,
        super(key: key);

  @override
  _OwPageViewState createState() => _OwPageViewState();
}

class _OwPageViewState extends State<OwPageView> {

  ValueNotifier<int> _currentPageNotifier;

  @override
  Widget build(BuildContext context) {
    _currentPageNotifier = _initializeCurrentPageNotifier();
    
    return Container(
      key: widget.key,
      padding: widget.padding,
      height: widget.height,
      child: _containerChild(),
    );
  }

  Widget _containerChild() {  
    if(widget.pageIndicator == PageIndicator.none) {
      return _pageView();
    } else if(
      widget.pageIndicator == PageIndicator.stackBottom ||
      widget.pageIndicator == PageIndicator.stackTop
    ) {
      return Stack(
        children: [
          _pageView(),
          IgnorePointer(
            child: Container(
              decoration: BoxDecoration(
                gradient: widget.stackGradient,
              ),
            ),
          ),
          Align(
            alignment: widget.pageIndicator == PageIndicator.stackBottom
              ? Alignment.bottomCenter
              : Alignment.topCenter,
            child: Padding(
              padding: EdgeInsets.symmetric(
                vertical: widget.indicatorWidgetSpacing,
              ),
              child: _pageIndicator(),
            ),
          ),
        ],
      );
    } else {
      Widget _spaceBetween = SizedBox(height: widget.indicatorWidgetSpacing);
      // List<Widget> _columnChildren = [
      //   Expanded(child: _pageView()),
      //   _spaceBetween,
      //   _pageIndicator(),
      // ];
      return Column(
        children: widget.pageIndicator == PageIndicator.top
          ? [
            _pageIndicator(),
            _spaceBetween,
            Expanded(child: _pageView()),
          ]
          : [
            Expanded(child: _pageView()),
            _spaceBetween,
            _pageIndicator(),
          ],
      );
    }
  }

  Widget _pageView() {
    List<Widget> _children = widget.centeredChildren
      ? _centeredWidgets()
      : widget.children;
    
    if(widget.loop) {
      return LoopPageView.builder(
        reverse: widget.reverse,
        controller: widget.loopController,
        physics: widget.physics,
        dragStartBehavior: DragStartBehavior.down,
        pageSnapping: widget.pageSnapping,
        allowImplicitScrolling: true,
        itemCount: _children.length,
        itemBuilder: (context, index) {
          return _children[index];
        },
        onPageChanged: (index) {
          _currentPageNotifier.value = index;
        },
      );
    } else if(widget.carousel) {
      return CarouselSlider(
        items: _children,
        carouselController: widget.carouselController,
        options: CarouselOptions(
          height: widget.height,
          aspectRatio: widget.aspectRatio,
          initialPage: widget.initialCarouselPage,
          enableInfiniteScroll: widget.infiniteScroll,
          reverse: widget.reverse,
          autoPlay: widget.autoPlay,
          autoPlayInterval: widget.autoPlayInterval,
          autoPlayAnimationDuration: widget.autoPlayAnimationDuration,
          autoPlayCurve: widget.autoPlayCurve,
          // enlargeCenterPage: true,
          scrollDirection: Axis.horizontal,
          onPageChanged: (index, reason) {
            _currentPageNotifier.value = index;
          }
        )
      );
    } else {
      return PageView.builder(
        controller: widget.controller,
        reverse: widget.reverse,
        physics: widget.physics,
        dragStartBehavior: DragStartBehavior.down,
        pageSnapping: widget.pageSnapping,
        allowImplicitScrolling: true,
        itemCount: _children.length,
        itemBuilder: (context, index) {
          return _children[index];
        },
        onPageChanged: (index) {
          _currentPageNotifier.value = index;
        },
      );
    }
  }

  Widget _pageIndicator() {
    Duration _jumpDuration = Duration(milliseconds: 500);
    Curve _jumpCurve = Curves.easeInOut;

    return widget.stepPageIndicator
      ? StepPageIndicator(
        itemCount: widget.children.length,
        currentPageNotifier: _currentPageNotifier,
        size: widget.dotSize,
        stepColor: widget.dotColor,
        previousStep: widget.previousStep,
        selectedStep: widget.selectedStep,
        nextStep: widget.nextStep,
        stepSpacing: widget.dotSpacing,
        onPageSelected: (index) {
          if(widget.onDotIndicatorSelected != null) {
            widget.onDotIndicatorSelected(index);
          }
          
          if(widget.stepPageDotTouch != IndicatorDotTouch.none) {
            bool _goToPage = false;
            if(widget.stepPageDotTouch == IndicatorDotTouch.goToPage) {
              _goToPage = true;
            } else if(_currentPageNotifier.value > index) {
              _goToPage = true;
            }

            if(_goToPage) {
              widget.controller?.animateToPage(
                index,
                duration: _jumpDuration,
                curve: _jumpCurve,
              );
              widget.loopController?.animateToPage(
                index,
                duration: _jumpDuration,
                curve: _jumpCurve,
              );
            }
          }
        },
      )
      : CirclePageIndicator(
        itemCount: widget.children.length,
        currentPageNotifier: _currentPageNotifier,
        size: widget.dotSize,
        selectedSize: widget.selectedDotSize,
        borderColor: widget.dotBorderColor,
        borderWidth: widget.dotBorderWidth,
        dotSpacing: widget.dotSpacing,
        dotColor: widget.dotColor,
        selectedBorderColor: widget.selectedDotBorderColor,
        selectedDotColor: widget.selectedDotColor,
        onPageSelected: (index) {
          if(widget.onDotIndicatorSelected != null) {
            widget.onDotIndicatorSelected(index);
          }
          
          if(
            widget.stepPageDotTouch == IndicatorDotTouch.goToOnlyCheckedPage ||
            widget.stepPageDotTouch == IndicatorDotTouch.goToPage
          ) {
            widget.controller?.animateToPage(
              index,
              duration: _jumpDuration,
              curve: _jumpCurve,
            );
            widget.loopController?.animateToPage(
              index,
              duration: _jumpDuration,
              curve: _jumpCurve,
            );
          }
        },
      );
  }

  List<Widget> _centeredWidgets() {
    List<Widget> _children = [];
    widget.children?.forEach((element) {
      _children.add(Center(child: element));
    });
    return _children;
  }

  
  ValueNotifier<int> _initializeCurrentPageNotifier() {
    return ValueNotifier<int>(
      widget.controller?.initialPage ?? widget.loopController?.initialScrollOffset?.toInt() ?? 0,
    );
  }
}



