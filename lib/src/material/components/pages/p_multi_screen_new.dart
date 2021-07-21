import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

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

class OwMultiScreen extends StatefulWidget {
  /// The controller that will be used to manipulate the multi screen
  final MultiScreenController controller;
  /// The builder of the first screen (left screen)
  final Widget Function(BuildContext) buildScreen1; // @required
  /// The builder of the second screen (right screen)
  /// 
  /// It can not be used Navigator.pop to back from the second page to the first, it will 
  /// be needed to use controller.backToFirstPage()
  final Widget Function(BuildContext) buildScreen2; // @required
  /// Default second screen when controller.secondPageData is not defined
  /// 
  /// If it is null and there is not data to the second screen 
  /// (controller.secondPageData), the first screen will fill all the width
  final Widget emptySecondScreen;
  /// Use the percentage of the screen width to define the first screen width
  final double firstPageWidthPercent;
  /// Defines the initial value to the first screen width
  final double startFirstPageWithWidth;
  /// The minimum size of each of both screens
  final double minSizeOfEachScreen;
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
  final Color resizableTwoBarsColor;

  /// The width of the resizable widget

  const OwMultiScreen({
    Key key,
    @required this.controller,
    @required this.buildScreen1,
    @required this.buildScreen2,
    this.emptySecondScreen,
    this.firstPageWidthPercent = 0.3,
    this.startFirstPageWithWidth,
    this.minSizeOfEachScreen = 50,
    this.sizeSeparator = 800,
    this.isResizable = true,
    this.resizableWidgetBackgroundColor,
    this.resizableTwoBarsColor,
  }): assert(sizeSeparator >= 2 * minSizeOfEachScreen),
      assert(controller != null),
      assert(
        startFirstPageWithWidth == null ? true : startFirstPageWithWidth <= sizeSeparator - 4, // 4 due to the 
        "'startFirstPageWithWidth' <= 'sizeSeparator' - 4 is not true",
      ),
      super(key: key);
  

  @override
  _OwMultiScreenState createState() => _OwMultiScreenState(
    controller,
    buildScreen1,
    buildScreen2,
    sizeSeparator,
    isResizable,
    resizableWidgetBackgroundColor,
    resizableTwoBarsColor,
  );
}

class _OwMultiScreenState extends State<OwMultiScreen> {
  final MultiScreenController controller;
  final Widget Function(BuildContext) buildScreen1; // ! Mudar pra buildMainScreen
  final Widget Function(BuildContext) buildScreen2; // ! Mudar pra buildSecundaryScreen

  final double separatorSize;
  final bool isResizable;
  final Color resizableWidgetBackgroundColor;
  final Color resizableTwoBarsColor;

  _OwMultiScreenState(
    this.controller,
    this.buildScreen1, 
    this.buildScreen2,
    this.separatorSize,
    this.isResizable,
    this.resizableWidgetBackgroundColor,
    this.resizableTwoBarsColor,
  );


  final Axis direction = Axis.horizontal;

  // ! Erro: Quando sai da tela (botão voltar do chrome) e entra de novo, se tentar chamar uma nova tela na tela 2, gera exceção

  // Variables
  double _resizableWidgetSize = 8;

  bool _firstExec = true;

  var keyOne = GlobalKey<NavigatorState>();
  var keyTwo = GlobalKey<NavigatorState>();
  var keyBoth = GlobalKey<NavigatorState>();

  bool showResizableWidget;

  @override
  void initState() { 
    super.initState();

    // controller.updateStateF = () => setState(() {});
    controller.isResizing = false;

    controller.setNavKey1 = keyOne;
    controller.setNavKey2 = keyTwo;

    // SchedulerBinding.instance.addPostFrameCallback((timeStamp) {

    //   keyTwo.currentState.push(MaterialPageRoute(
    //     builder: (context) => buildScreen2(context) ?? const SizedBox(),
    //   ));

    //   // keyTwo.currentState.pushAndRemoveUntil(
    //   //   MaterialPageRoute(
    //   //     builder: (context) => WillPopScope(
    //   //       child: emptySecondScreen ?? const SizedBox(),
    //   //       onWillPop: () async {
    //   //         print("pop (emptySecondScreen)");
    //   //         return false;
    //   //       },
    //   //     ),
    //   //   ), 
    //   //   (route) => false,
    //   // );
    // });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, widget) {
        _execOnBuilder();
        return _bothScreens();
      },
    );
  }

  Widget _bothScreens() {
    return Stack(
      children: [
        Row(
          children: [
            _screen1(),
            _screen2(),
          ],
        ),
        _resizableWidget(),
      ],
    );
  }

  Widget _screen1() {
    return Container(
      width: controller.mainScreenSize,
      padding: controller._showResizableWidget
        ? EdgeInsets.only(right: _resizableWidgetSize / 2)
        : null,
      child: Navigator(
        key: keyOne,
        onGenerateRoute: (routeSettings) {
          return MaterialPageRoute(
            builder: (context) {
              return buildScreen1?.call(context) ?? const SizedBox();
            }
          );
        },
      ),
    );
  }

  Widget _screen2() {
    return Container(
      width: controller.secundaryScreenSize,
      padding: controller._showResizableWidget
        ? EdgeInsets.only(left: _resizableWidgetSize / 2)
        : null,
      child: Navigator(
        key: keyTwo,
        onGenerateRoute: (routeSettings) {
          return MaterialPageRoute(
            builder: (context) {
              return buildScreen2?.call(context) ?? const SizedBox();
            }
          );
        },
      ),
    );
  }

  Widget _resizableWidget() { // ! Colocar sombra
    double leftPadding = controller.mainScreenSize - (_resizableWidgetSize / 2);
    if(leftPadding < 0) {
      leftPadding = 0;
    } else if(leftPadding > controller._getTotalSize() - _resizableWidgetSize) {
      leftPadding = controller._getTotalSize() - _resizableWidgetSize;
    }

    return controller._showResizableWidget
      ? Padding(
        padding: EdgeInsets.only(left: leftPadding),
        child: Container(
          width: _resizableWidgetSize,
          child: MouseRegion(
            cursor: controller.isResizing
              ? SystemMouseCursors.resizeColumn
              : MouseCursor.defer,
            child: Container(
              color: resizableWidgetBackgroundColor ?? Theme.of(context).scaffoldBackgroundColor,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        child: MouseRegion(
                          cursor: SystemMouseCursors.resizeColumn,
                          child: Draggable(
                            child: _resizableIcon(), 
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
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      )
      : const SizedBox();
  }

  Widget _resizableIcon() {
    Widget verticalBar = Container(
      width: 1,
      color: resizableTwoBarsColor ?? Theme.of(context).textTheme.headline1.color,
    );

    return Container(
      color: Colors.transparent,
      padding: const EdgeInsets.symmetric(horizontal: 2),
      width: _resizableWidgetSize,
      height: 20,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          verticalBar,
          verticalBar,
        ],
      ),
    );
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


enum Screen { screen1, screen2 }
enum DefinedScreen { main, secundary }
class MultiScreenController extends ChangeNotifier {
  MultiScreenController({
    this.mainScreen = Screen.screen1,
    this.mainScreenStartPercent = 0.3,
    this.mainScreenStartSize,
    this.keepScreenSizeWhileResizeWindow,
    this.mainScreenMinSize = 0,
    this.secundaryScreenMinSize = 0,
    bool hideSecundaryScreenWhenShowingBoth = false,
    bool focusOnSecundaryScreen = false,
  }): assert(mainScreen != null),
      assert(mainScreenStartPercent != null || mainScreenStartSize != null),
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

  final Screen mainScreen;
  final double mainScreenStartSize;
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
