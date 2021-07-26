import 'package:flutter/material.dart';

// ! TODO: FINALIZAR COMPONENTE

// ! VER: https://pub.dev/packages/layout
/* // ! VER
	ResizableWidget (ask): https://stackoverflow.com/questions/60924384/creating-resizable-view-that-resizes-when-pinch-or-drag-from-corners-and-sides-i
	ResizableWidget (plugin): https://pub.dev/packages/resizable_widget

  Ver sobre: https://www.syncfusion.com/flutter-widgets

  ! https://stackoverflow.com/questions/50986350/flutter-navigation-for-part-of-screen (flutter navigator inside widget)

  ! https://pub.dev/packages/curved_drawer (curved drawer)

  ! https://pub.dev/packages/show_drawer (show drawer)

  https://pub.dev/packages/flutter_inner_drawer

  Google {
    flutter create a changenotifier
    flutter create controller to manager statement
  }
*/

enum MainScreen { screen1, screen2 }
class OwMultiScreen extends StatefulWidget {
  /// The controller that will be used to manipulate the multi screen
  final MultiScreenController controller;

  final MainScreen mainScreen;
  /// The builder of the first screen (left screen)
  final Widget Function(BuildContext) buildMainScreen; // @required
  /// The builder of the second screen (right screen)
  /// 
  /// It can not be used Navigator.pop to back from the second page to the first, it will 
  /// be needed to use controller.backToFirstPage()
  final Widget Function(BuildContext) buildSecundaryScreen;
  /// Compare to the screen width to define if it is single or multi screen
  final double sizeSeparator;
  /// Defines if both screens is resizable
  final bool isResizable;
  /// Background color of the resizable widget (if [isResizable] = true)
  /// 
  /// By default, the color is Theme.of(context).scaffoldBackgroundColor
  final Color resizableWidgetBackgroundColor;
  /// The two bar's color of the resizable widget (if [isResizable] = true)
  /// 
  /// By default, the color is Theme.of(context).textTheme.headline1.color
  final Color resizableIconColor;

  final Axis direction;

  /// The width of the resizable widget

  const OwMultiScreen({
    Key key,
    @required this.controller,
    this.mainScreen = MainScreen.screen1,
    @required this.buildMainScreen,
    @required this.buildSecundaryScreen,
    this.sizeSeparator = 800,
    this.isResizable = true,
    this.resizableWidgetBackgroundColor,
    this.resizableIconColor,
    this.direction = Axis.vertical,
  }): assert(controller != null),
      super(key: key);
  

  @override
  _OwMultiScreenState createState() => _OwMultiScreenState(
    controller,
    mainScreen,
    buildMainScreen,
    buildSecundaryScreen,
    sizeSeparator,
    isResizable,
    resizableWidgetBackgroundColor,
    resizableIconColor,
    direction,
  );
}

class _OwMultiScreenState extends State<OwMultiScreen> {
  final MultiScreenController controller;
  final MainScreen mainScreen;
  final Widget Function(BuildContext) buildMainScreen;
  final Widget Function(BuildContext) buildSecundaryScreen;
  final double separatorSize;
  final bool isResizable;
  final Color resizableWidgetBackgroundColor;
  final Color resizableIconColor;
  final Axis direction;

  _OwMultiScreenState(
    this.controller,
    this.mainScreen,
    this.buildMainScreen, 
    this.buildSecundaryScreen,
    this.separatorSize,
    this.isResizable,
    this.resizableWidgetBackgroundColor,
    this.resizableIconColor,
    this.direction,
  );



  // ! Erro: Quando sai da tela (botão voltar do chrome) e entra de novo, se tentar chamar uma nova tela na tela 2, gera exceção

  // Variables
  double _resizableWidgetSize = 8;
  bool _firstExec = true;
  MouseCursor _resizableCursor;

  var keyOne = GlobalKey<NavigatorState>();
  var keyTwo = GlobalKey<NavigatorState>();
  var keyBoth = GlobalKey<NavigatorState>();

  bool showResizableWidget;

  @override
  void initState() { 
    super.initState();

    // controller.updateStateF = () => setState(() {});
    controller.isResizing = false;
    if(mainScreen == MainScreen.screen1) {
      controller.setNavKey1 = keyOne;
      controller.setNavKey2 = keyTwo;
    } else {
      controller.setNavKey1 = keyTwo;
      controller.setNavKey2 = keyOne;
    }
    controller._navKeyBoth = keyBoth;

    if(direction == Axis.horizontal) {
      _resizableCursor = SystemMouseCursors.resizeColumn;
    } else {
      _resizableCursor = SystemMouseCursors.resizeRow;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height, // ! Ver se precisa
      width: MediaQuery.of(context).size.width, // ! Ver se precisa
      child: Navigator(
        key: keyBoth,
        onGenerateRoute: (routeSettings) {
          return MaterialPageRoute(
            builder: (context) {
              return AnimatedBuilder(
                animation: controller,
                builder: (context, widget) {
                  _execOnBuilder();
                  return _bothScreens();
                },
              );
            },
          );
        },
      ),
    );
  }

  Widget _bothScreens() {
    return Stack(
      children: [
        direction == Axis.horizontal
          ? Row(children: [
            _screen1(),
            _screen2(),
          ])
          : Column(children: [
            _screen1(),
            _screen2(),
          ]),
        _resizableWidget(),
      ],
    );
  }

  Widget _screen1() {
    print("controller.mainScreenSize: ${controller.mainScreenSize}");
    return Container(
      width: direction == Axis.horizontal
        ? controller.mainScreenSize
        : null,
      height: direction == Axis.vertical
        ? controller.mainScreenSize
        : null,
      padding: controller._showResizableWidget
        ? direction == Axis.horizontal
          ? EdgeInsets.only(right: _resizableWidgetSize / 2)
          : EdgeInsets.only(bottom: _resizableWidgetSize / 2)
        : null,
      child: Navigator(
        key: keyOne,
        onGenerateRoute: (routeSettings) {
          return MaterialPageRoute(
            builder: (context) {
              if(mainScreen == MainScreen.screen1) {
                return buildMainScreen?.call(context) ?? const SizedBox();
              } else {
                return buildSecundaryScreen?.call(context) ?? const SizedBox();
              }
            },
          );
        },
      ),
    );
  }

  Widget _screen2() {
    print("controller.secundaryScreenSize: ${controller.secundaryScreenSize}");
    return Container(
      width: direction == Axis.horizontal
        ? controller.secundaryScreenSize
        : null,
      height: direction == Axis.vertical
        ? controller.secundaryScreenSize
        : null,
      padding: controller._showResizableWidget
        ? direction == Axis.horizontal
          ? EdgeInsets.only(left: _resizableWidgetSize / 2)
          : EdgeInsets.only(top: _resizableWidgetSize / 2)
        : null,
      child: Navigator(
        key: keyTwo,
        onGenerateRoute: (routeSettings) {
          return MaterialPageRoute(
            builder: (context) {
              if(mainScreen == MainScreen.screen1) {
                return buildSecundaryScreen?.call(context) ?? const SizedBox();
              } else {
                return buildMainScreen?.call(context) ?? const SizedBox();
              }
            }
          );
        },
      ),
    );
  }

  Widget _resizableWidget() {
    return controller._showResizableWidget
      ? Positioned(
        left: direction == Axis.horizontal
          ? _getResizableWidgetPosition()
          : null,
        top: direction == Axis.vertical
          ? _getResizableWidgetPosition()
          : null,
        child: Container(
          height: direction == Axis.horizontal
            ? MediaQuery.of(context).size.height
            : _resizableWidgetSize,
          width: direction == Axis.vertical
            ? MediaQuery.of(context).size.width
            : _resizableWidgetSize,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Theme.of(context).textTheme.bodyText1.color.withOpacity(0.2),
                spreadRadius: 1,
              ),
            ],
          ),
          child: MouseRegion(
            cursor: controller.isResizing
              ? _resizableCursor
              : MouseCursor.defer,
            child: Container(
              color: resizableWidgetBackgroundColor ?? Theme.of(context).scaffoldBackgroundColor,
              child: direction == Axis.horizontal
                ? Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _resizableIcon(),
                  ],
                )
                : Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _resizableIcon(),
                  ],
                ),
            ),
          ),
        ),
      )
      : const SizedBox();
  }

  Widget _resizableIcon() {
    Widget barIcon = Container(
      width: direction == Axis.horizontal ? 1 : null,
      height: direction == Axis.vertical ? 1 : null,
      color: resizableIconColor ?? Theme.of(context).textTheme.headline1.color,
    );
    
    return Container(
      child: MouseRegion(
        cursor: _resizableCursor,
        child: Draggable(
          child: Container(
            color: Colors.transparent,
            padding: direction == Axis.horizontal
              ? const EdgeInsets.symmetric(horizontal: 2)
              : const EdgeInsets.symmetric(vertical: 2),
            height: direction == Axis.horizontal ? 20 : _resizableWidgetSize,
            width: direction == Axis.vertical ? 20 : _resizableWidgetSize,
            child: direction == Axis.horizontal
              ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  barIcon,
                  barIcon,
                ],
              )
              : Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  barIcon,
                  barIcon,
                ],
              ),
          ), 
          feedback: const SizedBox(),
          onDragUpdate: (dragUpdateDetails) {
            controller.resizeOnDrag(dragUpdateDetails);
          },
          onDragStarted: () {
            controller.isResizing = true;
          },
          onDragEnd: (d) {
            controller.isResizing = false;
          },
        ),
      ),
    );
  }

  double _getResizableWidgetPosition() {
    double position = controller.mainScreenSize - (_resizableWidgetSize / 2);
    if(position < 0) {
      position = 0;
    } else if(position > controller._getTotalSize() - _resizableWidgetSize) {
      position = controller._getTotalSize() - _resizableWidgetSize;
    }
    return position;
  }

  void _execOnBuilder() {
    controller?.buildListener?.call();

    if(_firstExec) {
      controller.startCall(separatorSize, _resizableWidgetSize, context, isResizable, direction);
      _firstExec = false;
    }

    // ! Pra não bugar, e deixar as porcentagens certas (tela1 + tela2 = 1 (sem que o resizableWidget pegue uma parte)), pode tentar 2 coisas:
    // * 1: totalSize = totalSize - _resizableWidgetSize;
    // * 2: Usar um Stack com uma linha (tendo as 2 telas) e por cima, o resizable
    controller.alwaysCalc();
  }
}

    // _firstScreenWidth = _getFirstPageWidth();
    // if(_firstScreenWidth < 0) { // This is to fix the 4 pixels overflow when 'minSizeOfEachScreen' = 0 and: 'firstPageSizePercent' = 0 (left overflow) or 1 (right overflow)
    //   _firstScreenWidth = 0;
    // } else if(_firstScreenWidth > _sizeScreen - _resizableWidgetSize) {
    //   _firstScreenWidth = _sizeScreen - _resizableWidgetSize;
    // }
    // _secondScreenWidth = _getSecondPageWidth();


enum DefinedScreen { main, secundary }
class MultiScreenController extends ChangeNotifier {
  MultiScreenController({
    this.mainScreenStartPercent = 0.3,
    this.mainScreenStartSize,
    this.keepScreenSizeWhileResizeWindow,
    this.mainScreenMinSize = 0,
    this.secundaryScreenMinSize = 0,
    bool hideSecundaryScreenWhenShowingBoth = false,
    bool focusOnSecundaryScreen = false,
  }): assert(mainScreenStartPercent != null || mainScreenStartSize != null),
      _hideSecundaryScreenWhenShowingBoth = hideSecundaryScreenWhenShowingBoth,
      _focusOnSecundaryScreen = focusOnSecundaryScreen;

  GlobalKey _navKeyBoth;
  get getNavKeyBoth => this._navKeyBoth;
  set setNavKeyBoth(GlobalKey navKeyBoth) {
    if(this._navKeyBoth == null) {
      this._navKeyBoth = navKeyBoth;
    }
  }

  GlobalKey _navKey1;
  get getNavKey1 => this._navKey1;
  set setNavKey1(GlobalKey navKey1) {
    if(this._navKey1 == null) {
      this._navKey1 = navKey1;
    }
  }

  GlobalKey _navKey2;
  get getNavKey2 => this._navKey2;
  set setNavKey2(GlobalKey navKey2) {
    if(this._navKey2 == null) {
      this._navKey2 = navKey2;
    }
  }

  NavigatorState _pageNavigator(
    GlobalKey key, 
    {bool pop = false, 
    bool backToStartScreen = false, 
    bool updateState = true
  }) {
    NavigatorState navigatorState = key.currentState;

    if(backToStartScreen) {
      navigatorState.popUntil((route) => route.isFirst);
      // if(key == _navKey2) {
      //   focusOnSecundaryScreen = true;
      // }
    } else if(pop && navigatorState.canPop()) {
      navigatorState.pop();
      // if(key == _navKey2) {
      //   focusOnSecundaryScreen = false;
      // }
    }

    if(updateState) {
      this.updateState();
    }

    return navigatorState; 
  }

  NavigatorState mainNavigator(
    {bool pop = false, 
    bool backToStartScreen = false,
    bool updateState = true,
  }) {
    return _pageNavigator(_navKey1, pop: pop, backToStartScreen: backToStartScreen, updateState: updateState);
  }

  NavigatorState secundaryNavigator({
    bool pop = false, 
    bool backToStartScreen = false, 
    bool updateState = true,
    bool focusOnSecundaryScreen,
    bool hideSecundaryScreenWhenShowingBoth = false,
  }) {
    if(hideSecundaryScreenWhenShowingBoth != null) {
      this._hideSecundaryScreenWhenShowingBoth = hideSecundaryScreenWhenShowingBoth;
    }
    if(backToStartScreen || focusOnSecundaryScreen != null) {
      this._focusOnSecundaryScreen = focusOnSecundaryScreen ?? false;
    }
    return _pageNavigator(_navKey2, pop: pop, backToStartScreen: backToStartScreen);
  }

  NavigatorState pageNavigatorBoth(
    {bool pop = false, 
    bool updateState = true,
  }) {
    return _pageNavigator(_navKeyBoth, pop: pop, updateState: updateState);
  }

  /// Defines the initial value to the first screen width
      // ! assert(
      //   startFirstPageWithWidth == null ? true : startFirstPageWithWidth <= sizeSeparator - 4, // 4 due to the 
      //   "'startFirstPageWithWidth' <= 'sizeSeparator' - 4 is not true",
      // ),
  final double mainScreenStartSize;
  /// Use the percentage of the screen width to define the first screen width
  final double mainScreenStartPercent;
  bool _hideSecundaryScreenWhenShowingBoth;
  get hideSecundaryScreenWhenShowingBoth => this._hideSecundaryScreenWhenShowingBoth;
  set hideSecundaryScreenWhenShowingBoth(bool value) {
    this._hideSecundaryScreenWhenShowingBoth = value;
    this.updateState();
  }
  bool _focusOnSecundaryScreen;
  get focusOnSecundaryScreen => this._focusOnSecundaryScreen;
  set focusOnSecundaryScreen(bool value) {
    this._focusOnSecundaryScreen = value;
    this.updateState();
  }
  // void changeFocus() => focusOnSecundaryScreen = !focusOnSecundaryScreen;

  double mainScreenPercent;
  double secundaryScreenPercent;
  double mainScreenSize;
  double secundaryScreenSize;

  double totalScreenSize;

  final DefinedScreen keepScreenSizeWhileResizeWindow;

  // ! assert(sizeSeparator >= 2 * minSizeOfEachScreen),
  final double mainScreenMinSize;
  final double secundaryScreenMinSize;

  // ! Ao inicializar
  double _separatorSize;
  double _resizableWidgetSize;
  Axis _direction;
  bool _isResizable;
  bool _showResizableWidget;
  void startCall(double separatorSize, double resizableWidgetSize, BuildContext context, bool isResizable, Axis direction) {
    this.context = context;
    this._separatorSize = separatorSize;
    this._resizableWidgetSize = resizableWidgetSize;
    this._isResizable = isResizable;
    this._direction = direction;
    
    double totalSize = _getTotalSize();
    
    if(mainScreenStartSize != null) {
      mainScreenPercent = (mainScreenStartSize + (resizableWidgetSize / 2)) / totalSize;
    } else {
      mainScreenPercent = mainScreenStartPercent;
    }

    if(mainScreenPercent > 1) {
      mainScreenPercent = 1;
    }
  }

  double _getTotalSize() {
    Size size = MediaQuery.of(this.context).size;
    if(this._direction == Axis.horizontal) {
      return size.width;
    } else {
      return size.height;
    }
  }

  double _mainScreenPercentTemp;
  double _mainScreenSizeTemp;
  void alwaysCalc() {
    // final stopwatch = Stopwatch()..start();
    // print("alwaysCalc: START");
    double totalSize = _getTotalSize();

    if(totalSize < _separatorSize) {
      this.isShowingBothScreens = false;

      if(_mainScreenPercentTemp == null) {
        _mainScreenPercentTemp = mainScreenPercent;
        // _mainScreenSizeTemp = mainScreenSize; // ! Verificar nesse caso (se for fixo o Size quando dimencionar)
      }

      if(focusOnSecundaryScreen) {
        mainScreenSize = 0;
        mainScreenPercent = 0;
        secundaryScreenSize = totalSize;
        secundaryScreenPercent = 1;
      } else {
        mainScreenSize = totalSize;
        mainScreenPercent = 1;
        secundaryScreenSize = 0;
        secundaryScreenPercent = 0;
      }
    } else {
      this.isShowingBothScreens = true;

      if(hideSecundaryScreenWhenShowingBoth) {
        if(_mainScreenPercentTemp == null) {
          _mainScreenPercentTemp = mainScreenPercent;
          // _mainScreenSizeTemp = mainScreenSize; // ! Verificar nesse caso (se for fixo o Size quando dimencionar)
        }
        
        mainScreenSize = totalSize;
        mainScreenPercent = 1;
        secundaryScreenSize = 0;
        secundaryScreenPercent = 0;
      } else {
        if(_mainScreenPercentTemp != null) {
          mainScreenPercent = _mainScreenPercentTemp;
          // secundaryScreenPercent = 1 - mainScreenPercent;
          _mainScreenPercentTemp = null;
        }

        if(keepScreenSizeWhileResizeWindow == DefinedScreen.main) {
          if(mainScreenSize == null) { // ! Ver se isso resolve
            mainScreenSize = mainScreenStartSize ?? mainScreenStartPercent * totalSize;
          }
          mainScreenPercent = mainScreenSize / totalSize;
          secundaryScreenPercent = 1 - mainScreenPercent;
          secundaryScreenSize = secundaryScreenPercent * totalSize;
        } else if(keepScreenSizeWhileResizeWindow == DefinedScreen.secundary) {
          if(secundaryScreenSize == null) { // ! Ver se isso tá certo
            secundaryScreenSize = totalSize - mainScreenStartSize ?? (1 - mainScreenStartPercent) * totalSize;
          }
          secundaryScreenPercent = secundaryScreenSize / totalSize;
          mainScreenPercent = 1 - secundaryScreenPercent;
          mainScreenSize = mainScreenPercent * totalSize;
        } else {
          mainScreenSize = mainScreenPercent * totalSize;
          secundaryScreenPercent = 1 - mainScreenPercent;
          secundaryScreenSize = secundaryScreenPercent * totalSize;
        }
      }
    }

    _checkWhetherResizableWidgetIsShown();
    
    // print("alwaysCalc: END");
    // print('doSomething() executed in ${stopwatch.elapsed}');
  }

  void _checkWhetherResizableWidgetIsShown() {
    if(!_isResizable || !isShowingBothScreens || hideSecundaryScreenWhenShowingBoth) {
      _showResizableWidget = false;
    } else {
      _showResizableWidget = true;
    }
  }

  // Só vai ocultar o resizableWidget se: !isResizable || !isShowingBothScreens || hideSecundaryScreenWhenShowingBoth
  void resizeOnDrag(DragUpdateDetails dragUpdateDetails) {
    double totalSize = _getTotalSize();
    double position;
    if(_direction == Axis.horizontal) {
      position = dragUpdateDetails.localPosition.dx;
    } else {
      position = dragUpdateDetails.localPosition.dy;
    }

    if(position >= 0 && position <= _resizableWidgetSize) { // ! Talvez, usar (resizableWidgetSize / 2) pra não dar teleport quando arrastar devagar e minSize = 0
      mainScreenPercent = 0;
    } else if(position >= (totalSize - _resizableWidgetSize) && position <= totalSize) {
      mainScreenPercent = 1;
    } else if(position >= (mainScreenMinSize + (_resizableWidgetSize / 2)) && position <= (totalSize - secundaryScreenMinSize - (_resizableWidgetSize / 2))) {
      mainScreenPercent = position / totalSize;
    }
    // if(mainScreenSize % 1 == 0)
    updateState(); // ! Talvez, colocar aquele Ticker que o Jacob mostrou
  }

  

  // bool _isSecondScreenEmpty;
  // bool get isSecondScreenEmpty => this._isSecondScreenEmpty;
  // set isSecondScreenEmpty(bool value) => this._isSecondScreenEmpty = value;

  /// This function is to rebuild the own second screen when needed (it is not used on 
  /// the MultiScreen widget)
  /// 
  /// It can be called on the first page when rebuild the second page
  void Function() rebuildCall;

  /// This function is called with the MultiScreen's builder
  void Function() buildListener;

  /// Check if the user is resizing the MultiScreen widget (it not check the window 
  /// resizing, just the middle resizable widget)
  bool _isResizing;
  bool get isResizing => this._isResizing;
  set isResizing(bool value) {
    this._isResizing = value;
    this.updateState();
  }

  /// Check if there is enough space to show both screens at the same time
  bool isShowingBothScreens;

  /// The context of the MuiltiScreen widget
  BuildContext context;
  
  /// Defined automatically, do not change
  // void Function() _updateStateF;
  // set updateStateF(void Function() value) { // ! setUpdateState
  //   if(this._updateStateF == null) {
  //     this._updateStateF = value;
  //   }
  // }
  void updateState() {
    print("notifyListeners");
    // _updateStateF();
    notifyListeners();
  }
}
