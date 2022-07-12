import 'package:flutter/material.dart';

class OwPageListView extends StatefulWidget { // ! APAGAR (usar OwGrid)
  final ScrollController controller;
  final List<dynamic> list;
  final Widget Function(BuildContext context, int index) itemBuilder;
  final Widget Function(BuildContext context, int index) separatorBuilder;
  final Future<bool> Function() loadMore;
  final bool useStackLoading;
  final Widget circularProgressIndicator;
  final int maxQuantity;
  final EdgeInsetsGeometry padding;
  final ScrollPhysics physics;
  // margin
  const OwPageListView({
    Key key,
    @required this.controller,
    @required this.itemBuilder,
    @required this.list,
    this.padding,
    this.physics = const BouncingScrollPhysics(),
    this.separatorBuilder,
    this.loadMore,
    this.useStackLoading = false,
    this.circularProgressIndicator = const CircularProgressIndicator(),
    this.maxQuantity,
  }) : super(key: key);

  @override
  _OwPageListViewState createState() => _OwPageListViewState();
}

class _OwPageListViewState extends State<OwPageListView> {
  final _listViewController = ScrollController();
  double _loadingWidgetHeight = 80;
  bool _showLoading = false;
  bool _showTryAgain = false;

  @override
  void initState() {
    super.initState();
    widget.controller?.addListener(() async {
      if(widget.loadMore != null && _showTryAgain != true && (widget.maxQuantity == null || widget.list.length < widget.maxQuantity)) {
        if(widget.controller.offset >= widget.controller.position.maxScrollExtent) { //  && !widget.controller.position.outOfRange
          if(!_showLoading) {
            _showLoading = true;
            _showTryAgain = false;
            setState(() {});
            if(!widget.useStackLoading) {
              // widget.controller.animateTo(widget.controller.position.maxScrollExtent + loadingWidgetHeight, duration: const Duration(milliseconds: 500), curve: Curves.easeIn);
              widget.controller.jumpTo(widget.controller.position.maxScrollExtent + _loadingWidgetHeight);
            }
            var result = await widget.loadMore();
            _showLoading = false;
            _showTryAgain = result == false; // Se for falso, exibir botão de tentar novamente
          }
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // return _listView();
    /*
    return NotificationListener<ScrollNotification>(
      onNotification: (sn) {
        print("sn: $sn");
        print(sn.metrics.pixels == sn.metrics.maxScrollExtent);
      },
      child: ,
    );
    */
    return SingleChildScrollView(
      controller: widget.controller,
      physics: widget.physics,
      child: Container(
        padding: widget.padding,
        child: widget.useStackLoading
          ? Stack(
            alignment: Alignment.bottomCenter,
            children: [
              _listView(),
              Positioned(
                bottom: 10,
                child: _loading(),
              ),
            ],
          )
          : Column(
            children: [
              _listView(),
              _loading(),
            ],
          ),
      ),
    );
  }

  Widget _listView() {
    return widget.separatorBuilder == null
      ? ListView.builder(
        controller: _listViewController,
        itemCount: widget.list.length,
        shrinkWrap: true,
        itemBuilder: widget.itemBuilder,
      )
      : ListView.separated(
        controller: _listViewController,
        itemCount: widget.list.length,
        shrinkWrap: true,
        itemBuilder: widget.itemBuilder,
        separatorBuilder: widget.separatorBuilder,
      );
  }

  Widget _loading() {
    return _showLoading
      ? LayoutBuilder(builder: (context, constraint) {
        // loadingWidgetHeight = constraint.minHeight; // Não tá funcionando
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: widget.circularProgressIndicator,
        );
      })
      : const SizedBox();
  }
}
