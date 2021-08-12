import 'package:flutter/material.dart';

// ignore: must_be_immutable
class OwAdaptativeGrid extends StatelessWidget {
  /// Creates a grid of widgets from list
  final List<Widget> children; // List<Widget>?

  /// Creates a grid of widgets building each widget
  ///
  /// The first [int] is the child index. The second [int] is the crossed line index
  final Widget Function(
          BuildContext context, int childIndex, int crossedLineIndex)
      itemBuilder; // Widget Function(BuildContext context, int childIndex, int crossedLineIndex)?

  /// The total number of children
  final int itemCount;

  /// Layout of the grid
  ///
  /// Sample: [100, 500] => Under 100, there will be 1 child to the crossed line. Between 100 and 500, there will be 2
  /// children. Over 500, there will be 3 children
  ///
  /// You can also use the same number twice to skip more than 1 child by case
  ///
  /// Sample: [100, 500, 500] => Under 100 (first case), there will be 1 child to the crossed line. Between 100 and 500
  /// (second case), there will be 2 children. The third case will be the same of the fourth case, which means that over 500,
  /// there will be 4 children per crossed line
  final List<double> layout; // List<double>?

  /// Cross alignment of the grid
  final WrapCrossAlignment wrapCrossAlignment;

  /// Main alignment of the grid
  final MainAxisAlignment mainAxisAlignment;

  /// Main direction of the grid
  final Axis direction;

  /// Whether the children are centered or not
  final bool centeredChild;

  /// Empty space to inscribe inside the grid. The [children], if any, is placed inside this padding.
  final EdgeInsetsGeometry padding;

  /// Main direction spacing (spacing between the crossed lines)
  final double runSpacing;

  /// Cross direction spacing (spacing between the axis direction's children)
  final double spacing;

  /// The widget that will fill the grid empty spaces
  final Widget emptyPlaces;

  /// Creates a [ScrollView] uses a single child layout
  /// model
  ///
  /// If the [scrollController] is not null, the [shrinkWrap] will be automaticaly set as true
  final bool shrinkWrap;
  final bool _shrinkWrap;

  /// ScrollView controller. Just used if [shrinkWrap] is true
  final ScrollController scrollController; // ScrollController?

  /// The physics of the scroll if [shrinkWrap] is true
  final ScrollPhysics scrollPhysics; // ScrollPhysics?

  /// Defines the style layout of each case of [layout].
  ///
  /// Sample: [[], null, [1], [1, null, 2]] => First case (under the first int of [layout]) and second case: will not be affected.
  /// Third case: will have on the first crossed line only 1 child, the others cross lines will not be affected. The fourth case
  /// will have on the first row only 1 child, the second row will not be affected, and the third row will have 2 children
  final List<List<int>> styleOfEachLayout; // List<List<int?>?>?

  /// The maximum quantity of children
  final int maxLength; // int?

  /// The maximum quantity of crossed lines
  final int maxCrossedLineLength;

  OwAdaptativeGrid({
    Key key,
    @required this.children,
    this.layout,
    this.wrapCrossAlignment = WrapCrossAlignment.center,
    this.mainAxisAlignment = MainAxisAlignment.spaceBetween,
    this.direction = Axis.horizontal,
    this.centeredChild = true,
    this.padding,
    this.runSpacing = 0,
    this.spacing = 0,
    this.emptyPlaces = const SizedBox(),
    this.scrollController,
    this.scrollPhysics,
    this.styleOfEachLayout,
    this.maxLength,
    this.maxCrossedLineLength,
    this.shrinkWrap,
  })  : this.itemBuilder = null,
        this.itemCount = null,
        this._shrinkWrap = shrinkWrap ?? scrollController == null,
        super(key: key);

  OwAdaptativeGrid.builder({
    Key key,
    @required this.itemCount,
    @required this.itemBuilder,
    this.layout,
    this.wrapCrossAlignment = WrapCrossAlignment.center,
    this.mainAxisAlignment = MainAxisAlignment.spaceBetween,
    this.direction = Axis.horizontal,
    this.centeredChild = true,
    this.padding,
    this.runSpacing = 0,
    this.spacing = 0,
    this.emptyPlaces = const SizedBox(),
    this.scrollController,
    this.scrollPhysics,
    this.styleOfEachLayout,
    this.maxLength,
    this.maxCrossedLineLength,
    this.shrinkWrap,
  })  : this.children = null,
        this._shrinkWrap = shrinkWrap ?? scrollController == null,
        assert(itemBuilder != null && itemCount != null),
        assert(itemCount >= 0),
        super(key: key);

  int childIndex = 0;
  @override
  Widget build(BuildContext context) {
    return _shrinkWrap
        ? _grid()
        : SingleChildScrollView(
            controller: scrollController,
            child: _grid(),
            physics: scrollPhysics,
          );
  }

  Widget _grid() {
    return Container(
      padding: padding,
      child: LayoutBuilder(
        builder: (context, constraint) {
          int childrenPerCrossedLine = _getCrossedLineLength(
            context,
            constraint,
          );
          int generateLength = children == null ? itemCount : children.length;
          generateLength = (generateLength / childrenPerCrossedLine).ceil();
          if (maxCrossedLineLength != null) {
            if (generateLength > maxCrossedLineLength) {
              generateLength = maxCrossedLineLength;
            }
          }
          return Wrap(
            crossAxisAlignment: wrapCrossAlignment,
            direction: direction,
            runSpacing: runSpacing,
            children: List.generate(
              generateLength,
              (crossedLineIndex) => _crossDirectionLine(
                crossedLineIndex,
                childrenPerCrossedLine,
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _crossDirectionLine(int crossedLineIndex, int length) {
    if (direction == Axis.horizontal) {
      return Row(
        mainAxisAlignment: mainAxisAlignment,
        children: _crossChildList(crossedLineIndex, length),
      );
    } else {
      return Column(
        mainAxisAlignment: mainAxisAlignment,
        children: _crossChildList(crossedLineIndex, length),
      );
    }
  }

  List<Widget> _crossChildList(int crossedLineIndex, int length) {
    length = _getLengthByLayoutCase(crossedLineIndex, length);
    return List.generate(
      length + (length - 1), // (length - 1) is to get the spacing
      (inCrossedLineIndex) {
        if (inCrossedLineIndex % 2 == 1) {
          return direction == Axis.horizontal
              ? SizedBox(width: spacing)
              : SizedBox(height: spacing);
        } else if (centeredChild) {
          return Expanded(
            child: Center(
              child: _getSingleChild(crossedLineIndex, length),
            ),
          );
        } else {
          return _getSingleChild(crossedLineIndex, length);
        }
      },
    );
  }

  Widget _getSingleChild(int crossedLineIndex, int crossedLineLength) {
    int length = itemCount ?? children.length;
    if (maxLength != null && length > maxLength) {
      length = maxLength;
    }
    return Builder(builder: (context) {
      if (children == null) {
        return childIndex + 1 > length
            ? emptyPlaces
            : itemBuilder(context, childIndex++, crossedLineIndex);
      } else {
        return childIndex + 1 > length ? emptyPlaces : children[childIndex++];
      }
    });
  }

  int _getCrossedLineLength(
    BuildContext context,
    BoxConstraints constraint,
  ) {
    int quantity = 1;
    if (layout != null && layout.isNotEmpty) {
      double size;
      if (direction == Axis.horizontal) {
        size = constraint.maxWidth != double.infinity
            ? constraint.maxWidth
            : MediaQuery.of(context).size.width;
      } else {
        size = constraint.maxHeight != double.infinity
            ? constraint.maxHeight
            : MediaQuery.of(context).size.height;
      }

      for (var e in layout) {
        if (size <= e) {
          quantity = layout.indexOf(e) + 1;
          break;
        }
        if (e == layout.last) {
          quantity = layout.length + 1;
        }
      }
      return quantity;
    }
    return quantity;
  }

  int _getLengthByLayoutCase(int crossedLineIndex, int length) {
    if (layout != null && layout.isNotEmpty) {
      if (styleOfEachLayout != null && styleOfEachLayout.isNotEmpty) {
        if (styleOfEachLayout.length >= length) {
          List<int> style = styleOfEachLayout[length - 1] ?? [];
          if (style.length > crossedLineIndex) {
            length = style[crossedLineIndex] ?? length;
          }
        }
      }
    }
    return length;
  }

  /// Use this function to auto generate a [layout]
  static List<double> generateLayout(
    double widgetMaxSize, {
    double spacing = 0,
    double totalPadding = 0,
    int length = 16,
  }) {
    List<double> result = [];
    for (int i = 0; i < length; i++) {
      double value = ((i + 1) * widgetMaxSize) + (i * spacing) + totalPadding;
      result.add(value);
    }
    return result;
  }
}
