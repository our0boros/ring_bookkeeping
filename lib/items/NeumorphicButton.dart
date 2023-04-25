// import 'package:flutter/material.dart';
import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NeumorphicButton extends StatefulWidget {
  bool value;
  final Color buttonColor;
  final Widget child;
  final Function onChanged;
  final double height;
  final double width;
  final BorderRadius borderRadius;

  final Color darkShadowColor;
  final Color lightShadowColor;
  NeumorphicButton({
    Key? key,
    required this.value,
    this.buttonColor = const Color(0xffE9E5E5),
    this.child = const Text(""),
    required this.onChanged,
    this.height = 50,
    this.width = 100,
    this.borderRadius = const BorderRadius.all(Radius.circular(12)),
    this.darkShadowColor = const Color(0x3a282828),
    this.lightShadowColor = const Color(0x3affffff),
  }) : super(key: key);

  @override
  State<NeumorphicButton> createState() => _NeumorphicButtonState();
}

class _NeumorphicButtonState extends State<NeumorphicButton> {

  bool _value = true;
  late Widget _child;
  late double _height;
  late double _width;
  late BorderRadius _borderRadius;

  @override
  void initState() {
    super.initState();

    _value = widget.value;
    _child = widget.child;

    _height = widget.height;
    _width = widget.width;
    _borderRadius = widget.borderRadius;

  }

  @override
  void didUpdateWidget(NeumorphicButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.value != _value) {
      _value = widget.value;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: () {
          setState(() {
            _value = !_value;
          });
          widget.onChanged.call(_value);
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          height: _height,
          width: _width,
          decoration: BoxDecoration(
            borderRadius: _borderRadius,
            color: widget.buttonColor,
            boxShadow: _value
                ?
            [
              BoxShadow(
                color: widget.lightShadowColor,
                offset: Offset(8, 8),
                blurRadius: 8,
                spreadRadius: 1,
                inset: true,
              ),
              BoxShadow(
                color: widget.darkShadowColor,
                offset: Offset(-8, -8),
                blurRadius: 8,
                spreadRadius: 1,
                inset: true,
              ),
            ]
                :
            [
              BoxShadow(
                color: widget.darkShadowColor,
                offset: Offset(8, 8),
                blurRadius: 8,
                spreadRadius: 0,
              ),
              BoxShadow(
                color: widget.lightShadowColor,
                offset: Offset(-4, -4),
                blurRadius: 4,
                spreadRadius: 0,
              ),
            ]

          ),
          child: Center(
            child: widget.child,
          ),
        ),
      ),
    );
  }
}
