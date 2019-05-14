import 'package:flutter/material.dart';

class MyDivider extends StatelessWidget {
  /// Creates a material design divider.
  ///
  /// The height must be positive.
  const MyDivider({
    Key key,
    this.height = 16.0,
    this.indent = 0.0,
    this.width = 1.0,
    this.endindent = 0.0,
    this.color
  }) : assert(height >= 0.0),
        super(key: key);


  /// The divider's height extent.
  ///
  /// The divider itself is always drawn as one device pixel thick horizontal
  /// line that is centered within the height specified by this value.
  ///
  /// A divider with a [height] of 0.0 is always drawn as a line with a height
  /// of exactly one device pixel, without any padding around it.
  final double height;
  final double endindent;

  /// The amount of empty space to the left of the divider.
  final double indent;

  final double width;

  /// The color to use when painting the line.
  ///
  /// Defaults to the current theme's divider color, given by
  /// [ThemeData.dividerColor].
  ///
  /// {@tool sample}
  ///
  /// ```dart
  /// Divider(
  ///   color: Colors.deepOrange,
  /// )
  /// ```
  /// {@end-tool}
  final Color color;

  /// Computes the [BorderSide] that represents a divider of the specified
  /// color, or, if there is no specified color, of the default
  /// [ThemeData.dividerColor] specified in the ambient [Theme].
  ///
  /// The `width` argument can be used to override the default width of the
  /// divider border, which is usually 0.0 (a hairline border).
  ///
  /// {@tool sample}
  ///
  /// This example uses this method to create a box that has a divider above and
  /// below it. This is sometimes useful with lists, for instance, to separate a
  /// scrollable section from the rest of the interface.
  ///
  /// ```dart
  /// DecoratedBox(
  ///   decoration: BoxDecoration(
  ///     border: Border(
  ///       top: Divider.createBorderSide(context),
  ///       bottom: Divider.createBorderSide(context),
  ///     ),
  ///   ),
  ///   // child: ...
  /// )
  /// ```
  /// {@end-tool}
  static BorderSide createBorderSide(BuildContext context, Color color, double width) {
    //assert(width != null);
    return BorderSide(
      color: color ?? Theme.of(context).dividerColor,
      width: width,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: Center(
        child: Container(
          height: 0.0,
          margin: EdgeInsetsDirectional.only(start: indent,end: endindent),
          decoration: BoxDecoration(
            border: Border(
              bottom: createBorderSide(context, color, width),
            ),
          ),
        ),
      ),
    );
  }
}