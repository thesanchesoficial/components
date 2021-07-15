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
  final Widget Function(BuildContext) buildFirstScreen; // @required
  /// The builder of the second screen (right screen)
  /// 
  /// It can not be used Navigator.pop to back from the second page to the first, it will 
  /// be needed to use controller.backToFirstPage()
  final Widget Function(BuildContext) buildSecondScreen; // @required
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
  final double widthSeparator;
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
    @required this.buildFirstScreen,
    @required this.buildSecondScreen,
    this.emptySecondScreen,
    this.firstPageWidthPercent = 0.3,
    this.startFirstPageWithWidth,
    this.minSizeOfEachScreen = 50,
    this.widthSeparator = 800,
    this.isResizable = true,
    this.resizableWidgetBackgroundColor,
    this.resizableTwoBarsColor,
  }): assert(widthSeparator >= 2 * minSizeOfEachScreen),
      assert(controller != null),
      assert(
        startFirstPageWithWidth == null ? true : startFirstPageWithWidth <= widthSeparator - 4, // 4 due to the 
        "'startFirstPageWithWidth' <= 'widthSeparator' - 4 is not true",
      ),
      super(key: key);
  

  @override
  _OwMultiScreenState createState() => _OwMultiScreenState(
    controller,
    buildFirstScreen,
    buildSecondScreen,
    emptySecondScreen,
    firstPageWidthPercent,
    startFirstPageWithWidth,
    minSizeOfEachScreen,
    widthSeparator,
    isResizable,
    resizableWidgetBackgroundColor,
    resizableTwoBarsColor,
  );
}

class _OwMultiScreenState extends State<OwMultiScreen> {
  final MultiScreenController controller;
  final Widget Function(BuildContext) buildFirstScreen; // = (context) => Screen1Test();
  final Widget Function(BuildContext) buildSecondScreen; // = (context) => Screen2Test(); // key: UniqueKey(), // Usado pra ao mudar de index, resetar o "Incremento" (sem precisar do controller) (erro: rebuilda quando redimenciona a janela)

  final Widget emptySecondScreen;
  double firstPageWidthPercent;
  final double startFirstPageWithWidth;
  final double minSizeOfEachScreen;
  final double widthSeparator;
  final bool isResizable;
  final Color resizableWidgetBackgroundColor;
  final Color resizableTwoBarsColor;

  // double firstPageFixedWidth;

  // ! Erro: Quando sai da tela (botão voltar do chrome) e entra de novo, se tentar chamar uma nova tela na tela 2, gera exceção

  // Variables
  double _resizableWidgetWidth = 0;
  double _widthScreen = 0;
  double _firstScreenWidth = 0;
  double _secondScreenWidth = 0;

  double _firstPageResizableWidth;
  double _secondPageResizableWidth;

  bool _firstExec = true;

  var keyOne = GlobalKey<NavigatorState>();
  var keyTwo = GlobalKey<NavigatorState>();

  _OwMultiScreenState(
    this.controller,
    this.buildFirstScreen, 
    this.buildSecondScreen,
    this.emptySecondScreen,
    this.firstPageWidthPercent,
    this.startFirstPageWithWidth,
    this.minSizeOfEachScreen,
    this.widthSeparator,
    this.isResizable,
    this.resizableWidgetBackgroundColor,
    this.resizableTwoBarsColor,
  );

  @override
  void initState() { 
    super.initState();

    controller.updateStateF = () => setState(() {});
    controller.isResizing = false;

    controller.setKeyOne = keyOne;
    controller.setKeyTwo = keyTwo;

    controller.emptySecondScreenWidget = emptySecondScreen ?? const SizedBox();

    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {

      // keyOne.currentState.push(MaterialPageRoute(
      //   builder: (context) => const SizedBox(),
      // ));
      
      // keyOne.currentState.push(MaterialPageRoute(
      //   builder: (context) => buildFirstScreen(context) ?? const SizedBox(),
      // ));

      keyTwo.currentState.push(MaterialPageRoute(
        builder: (context) => WillPopScope(
          child: emptySecondScreen ?? const SizedBox(),
          onWillPop: () async {
            print("pop (emptySecondScreen)");
            return false;
          },
        ),
      ));

      // keyTwo.currentState.pushAndRemoveUntil(
      //   MaterialPageRoute(
      //     builder: (context) => WillPopScope(
      //       child: emptySecondScreen ?? const SizedBox(),
      //       onWillPop: () async {
      //         print("pop (emptySecondScreen)");
      //         return false;
      //       },
      //     ),
      //   ), 
      //   (route) => false,
      // );
    });
  }

  // @override
  // void dispose() { 
  //   keyOne.currentState.dispose();
  //   keyTwo.currentState.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    _execOnBuilder();

    return WillPopScope(
      onWillPop: () async => !await keyOne.currentState.maybePop(),
      child: Container(
        child: Row(
          children: [
            Container(
              width: _firstScreenWidth,
              child: _screen1(),
            ),
            isResizable && controller.isShowingBothScreens && !(controller?.isSecondScreenEmpty() == true && emptySecondScreen == null)
              ? _resizableWidget()
              : const SizedBox(),
            Container(
              width: _secondScreenWidth,
              child: _screen2(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _screen1() {
    return Navigator(
      key: keyOne,
      onGenerateRoute: (routeSettings) {
        return MaterialPageRoute(
          builder: (context) {
            // return FlatButton(
            //   onPressed: () {
            //     keyTwo.currentState.push(MaterialPageRoute(builder: (context) => Scaffold(
            //       appBar: AppBar(),
            //       body: Center(child: Text("21732")),
            //     )));
            //   }, 
            //   child: Text("->"),
            // );
            return buildFirstScreen(context);
          }
        );
      },
    );
  }

  Widget _screen2() {
    return Navigator(
      key: keyTwo,
      onGenerateRoute: (routeSettings) {
        return MaterialPageRoute(
          builder: (context) {
            return WillPopScope(
              child: emptySecondScreen ?? const SizedBox(),
              onWillPop: () async {
                print("try pop screen 2");
                return false;
              },
            );
            // return controller.isSecondScreenEmpty()
            //   ? emptySecondScreen ?? const SizedBox()
            //   : buildSecondScreen(context);
          }
        );
      },
    );
  }

  Widget _resizableWidget() { // ! Colocar sombra
    return MouseRegion(
      cursor: false //controller.isResizing // ! Corrigir, tá falando que é null, não sei como
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
                      onDragUpdate: (d) {
                        if(
                          d.localPosition.dx >= minSizeOfEachScreen + (_resizableWidgetWidth / 2) && 
                          d.localPosition.dx < _widthScreen - minSizeOfEachScreen - (_resizableWidgetWidth / 2) + 1
                        ) {
                          firstPageWidthPercent = d.localPosition.dx / _widthScreen;
                          controller.updateState();
                        }
                      },
                      onDragStarted: () {
                        controller.isResizing = true;
                        controller.updateState();
                      },
                      onDragEnd: (d) {
                        controller.isResizing = false;
                        controller.updateState();
                      },
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _resizableIcon() {
    Widget verticalBar = Container(
      width: 1,
      color: resizableTwoBarsColor ?? Theme.of(context).textTheme.headline1.color,
    );

    return Container(
      color: Colors.transparent,
      padding: const EdgeInsets.symmetric(horizontal: 2),
      width: _resizableWidgetWidth,
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

  void _execOnBuilder() { // ! Melhorar lógica
    controller?.buildListener?.call();

    _widthScreen = MediaQuery.of(context).size.width; // ! Passar pro controller

    _initExecOnBuilder();

    // if(controller?.context == null) {
    //   controller.context = context;
    // }

    if(_widthScreen < widthSeparator) {
      controller.isShowingBothScreens = false;
    } else {
      controller.isShowingBothScreens = true;
    }

    if(
      controller.isShowingBothScreens && 
      isResizable && 
      (!controller.isSecondScreenEmpty() || emptySecondScreen != null)
    ) {
      _resizableWidgetWidth = 8;
    } else {
      _resizableWidgetWidth = 0;
    }

    if(
      _widthScreen * firstPageWidthPercent >= minSizeOfEachScreen && 
      _widthScreen * (1 - firstPageWidthPercent) < _widthScreen - minSizeOfEachScreen
    ) {
      if(_firstPageResizableWidth == null && startFirstPageWithWidth != null) {
        _firstPageResizableWidth = startFirstPageWithWidth;
      } else {
        _firstPageResizableWidth = _widthScreen * firstPageWidthPercent;
      }
      _secondPageResizableWidth = _widthScreen * (1 - firstPageWidthPercent);
    }

    if(_firstPageResizableWidth == null || _secondPageResizableWidth == null) {
      _firstPageResizableWidth = minSizeOfEachScreen;
      _secondPageResizableWidth = _widthScreen * (1 - firstPageWidthPercent);
    }

    _firstScreenWidth = _getFirstPageWidth();
    if(_firstScreenWidth < 0) { // This is to fix the 4 pixels overflow when 'minSizeOfEachScreen' = 0 and: 'firstPageWidthPercent' = 0 (left overflow) or 1 (right overflow)
      _firstScreenWidth = 0;
    } else if(_firstScreenWidth > _widthScreen - _resizableWidgetWidth) {
      _firstScreenWidth = _widthScreen - _resizableWidgetWidth;
    }
    _secondScreenWidth = _getSecondPageWidth();

    controller.firstPageWidth = _firstScreenWidth;
    controller.secondPageWidth = _secondScreenWidth;
  }

  void _initExecOnBuilder() {
    if(_firstExec) {
      controller.context = context; // ! Tentar colocar no initState

      if(startFirstPageWithWidth != null) {
        firstPageWidthPercent = startFirstPageWithWidth / _widthScreen;
      }

      _firstExec = false;
    }
  }

  double _getFirstPageWidth() {
    if(!controller.isShowingBothScreens) {
      if(controller.isSecondScreenEmpty()) {
        return _widthScreen;
      } else {
        return 0;
      }
    } else {
      if(controller.isSecondScreenEmpty() == true && emptySecondScreen == null) {
        return _widthScreen;
      } else if(isResizable) {
        return _firstPageResizableWidth - (_resizableWidgetWidth / 2);
      } else {
        return startFirstPageWithWidth ?? _firstPageResizableWidth; //firstPageFixedWidth ?? firstPageResizableWidth;
      }
    }
  }

  double _getSecondPageWidth() {
    if(controller?.isSecondScreenEmpty() == true && emptySecondScreen == null) {
      return 0;
    } else if(controller.isShowingBothScreens && isResizable) {
      return _widthScreen - _firstScreenWidth - _resizableWidgetWidth;
    } else {
      return _widthScreen - _firstScreenWidth;
    }
  }
}




class MultiScreenController { // ! Dá pra colocar o dx do resizable aqui, assim, teria como ver e alterar depois de ter buildado a tela
  GlobalKey _keyOne;
  get getKeyOne => this._keyOne;
  set setKeyOne(GlobalKey keyOne) {
    if(this._keyOne == null) {
      this._keyOne = keyOne;
    }
  }

  GlobalKey _keyTwo;
  get getKeyTwo => this._keyTwo;
  set setKeyTwo(GlobalKey keyTwo) {
    if(this._keyTwo == null) {
      this._keyTwo = keyTwo;
    }
  }

  Widget _emptySecondScreenWidget;
  get emptySecondScreenWidget => this._emptySecondScreenWidget;
  set emptySecondScreenWidget(Widget emptySecondScreenWidget) {
    if(this._emptySecondScreenWidget == null) {
      this._emptySecondScreenWidget = emptySecondScreenWidget;
    }
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
  set isResizing(bool value) => this._isResizing = isResizing;
  
  /// Defined automatically, do not change
  void Function() _updateStateF;
  set updateStateF(void Function() value) { // ! setUpdateState
    if(this._updateStateF == null) {
      this._updateStateF = value;
    }
  }
  void updateState() {
    _updateStateF();
  }

  /// Do not change
  dynamic _secondPageData;
  /// Get the data of the second page
  dynamic get secondPageData => this._secondPageData;
  /// Do not change
  set secondPageData(dynamic value) {
    if(value != this._secondPageData) {
      this._secondPageData = value;
      this.updateState?.call();
    }
  }

  /// Check if there is enough space to show both screens at the same time
  bool isShowingBothScreens;

  /// The context of the MuiltiScreen widget
  BuildContext context;

  /// The width of the first page (single or multi screen)
  double firstPageWidth;

  /// The width of the second page (single or multi screen)
  double secondPageWidth;

  /// Get the total page width (single or multi screen)
  double getPageWidth() { // Fazer um getWidth pra screen 1 e 2
    if(context == null) return null;
    return MediaQuery.of(context).size.width;
  }

  /// Clear the data of the second screen
  void clearData() {
    secondPageData = null;
  }

  /// Check if the second screen is showing up
  bool isSecondScreenEmpty() => this._secondPageData == null;

  /// Use this function to 'pop' the second page/screen
  void backToFirstPage([bool pop = true]) { // ! Talvez usar navigator pushAndRemoveUntil
    // if(pop) {
    //   this.secondPageNavigator().pop();
    // }
    this.clearData?.call();
    this.updateState?.call();
  }


  

  NavigatorState firstPageNavigator() {

  }

  NavigatorState secondPageNavigator({bool pop = false, bool backToEmptySecondScreen = false}) {
    NavigatorState navigatorState = _keyTwo.currentState;
    print("this.isSecondScreenEmpty(): ${this.isSecondScreenEmpty()}");
    print("secondPageData: $secondPageData");
    print("canPop: ${navigatorState.canPop()}");
    // if(pop && this.secondPageData != null) {
    //   this.backToFirstPage(false);
    // }
    if(pop && navigatorState.canPop()) { // ! Tentar isso (não testado ainda)
      // this.backToFirstPage();
      navigatorState.pop();
    }

    if(backToEmptySecondScreen) {
      navigatorState.pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) {
          return this.emptySecondScreenWidget;
        }),
        (route) => false,
      );
    }

    return navigatorState; 
  }

  void secondPagePop() {
    NavigatorState navigatorState = _keyTwo.currentState;
    if(navigatorState.canPop()) {
      navigatorState.pop();
    }
  }
}
