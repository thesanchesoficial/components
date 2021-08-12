import 'package:flutter/material.dart';

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
  final Widget Function(BuildContext context) buildFirstScreen; // @required
  /// The builder of the second screen (right screen)
  /// 
  /// It can not be used Navigator.pop to back from the second page to the first, it will 
  /// be needed to use controller.backToFirstPage()
  final Widget Function(BuildContext context) buildSecondScreen; // @required
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

  

  // Variables
  double _resizableWidgetWidth;
  double _widthScreen = 0;
  double _firstScreenWidth = 0;
  double _secondScreenWidth = 0;

  double _firstPageResizableWidth;
  double _secondPageResizableWidth;

  bool _firstExec = true;

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
  }

  @override
  Widget build(BuildContext context) {
    _execOnBuilder();

    return Container(
      child: Row(
        children: [
          Container(
            width: _firstScreenWidth,
            child: _screen1(),
          ),
          isResizable && controller.isShowingBothScreens && !(controller?.isSecondScreenEmpty() == true && emptySecondScreen == null)
            ? MouseRegion(
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
                              child: _resizableWidget(), 
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
            )
            : const SizedBox(),
          Container(
            width: _secondScreenWidth,
            child: _screen2(),
          ),
        ],
      ),
    );
  }

  Widget _screen1() {
    return buildFirstScreen(context);
  }

  Widget _screen2() {
    return controller.isSecondScreenEmpty()
      ? emptySecondScreen
      : buildSecondScreen(context);
  }

  Widget _resizableWidget() {
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





// class Screen1Test extends StatefulWidget {
//   const Screen1Test({
//     Key key,
//   }) : super(key: key);

//   @override
//   _Screen1TestState createState() => _Screen1TestState();
// }

// class _Screen1TestState extends State<Screen1Test> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: !controller.isShowingBothScreens
//         ? AppBar(title: Text("First Page"))
//         : null,
//       body: Container(
//         color: Colors.black12,
//         child: ListView.builder(
//           itemCount: 100,
//           itemBuilder: (context, i) {
//             return ListTile(
//               title: Text("i: $i"),
//               onTap: () {
//                 controller.secondPageData = i;
//                 controller.rebuildCall?.call();
//               },
//             );
//           },
//         ),
//       ),
//     );
//   }
// }






// class Screen2Test extends StatefulWidget {
//   const Screen2Test({
//     Key key,
//   }) : super(key: key);
  
//   @override
//   _Screen2TestState createState() => _Screen2TestState();
// }

// class _Screen2TestState extends State<Screen2Test> { // ! Testar: Colocar aquele mixin que mantem o estado
//   int add = 0;

//   // @override
// 	// bool get wantKeepAlive => true;

//   @override
//   void initState() { 
//     super.initState();
//     add = 0;

//     controller.rebuildCall = () => add = 0;

//     // controller.addListener(() {
//     //   print("addListenerRebuild");
//     // });
//   }
  
//   @override
//   Widget build(BuildContext context) {
//     // super.build(context);

//     return Scaffold(
//       appBar: !controller.isShowingBothScreens
//         ? AppBar(
//           title: Text("Second Page"),
//           leading: IconButton(
//             icon: Icon(Icons.arrow_back_ios_new),
//             onPressed: () {
//               controller.backToFirstPage();
//             },
//           ),
//         )
//         : null,
//       body: Container(
//         color: Colors.blue,
//         child: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.spaceAround,
//             children: [
//               FlatButton(onPressed: () {controller.backToFirstPage();}, child: Icon(Icons.arrow_back_ios)),
//               Text("Data: ${controller.secondPageData}"),
//               Text("Increment: $add"),
//               FlatButton(onPressed: () {setState(() {add++;});}, child: Icon(Icons.add)),
//               // FlatButton(onPressed: () {controller.notifyListener();}, child: Text("NotifyListener")),
//               FlatButton(onPressed: () {
//                 controller.rebuildCall();
//                 setState(() {});
//               }, child: Text("Rebuild")),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }




class MultiScreenController { // ! Dá pra colocar o dx do resizable aqui, assim, teria como ver e alterar depois de ter buildado a tela
  /// This function is to rebuild the own second screen when needed (it is not used on 
  /// the MultiScreen widget)
  /// 
  /// It can be called on the first page when rebuild the second page
  void Function() rebuildCall;

  /// This function is called with the MultiScreen's builder
  void Function() buildListener;

  /// Check if the user is resizing the MultiScreen widget (it not check the window 
  /// resizing, just the middle resizable widget)
  bool isResizing;
  
  /// Defined automatically, do not change
  void Function() _updateStateF;
  set updateStateF(void Function() value) {
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
  bool isSecondScreenEmpty() => secondPageData == null;

  /// Use this function to 'pop' the second page/screen
  void backToFirstPage() {
    this.clearData?.call();
    this.updateState?.call();
  }
}
