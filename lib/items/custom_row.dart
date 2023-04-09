import 'package:flutter/material.dart';

class CustomRow extends StatefulWidget {
  final IconData leftIcon;
  final IconData rightIcon;
  final int number;

  const CustomRow({Key? key, required this.leftIcon, required this.rightIcon, required this.number})
      : super(key: key);

  @override
  _CustomRowState createState() => _CustomRowState();
}

class _CustomRowState extends State<CustomRow> with SingleTickerProviderStateMixin {
  bool _expanded = true;
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 300),
  );
  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.easeInOut,
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _expanded = !_expanded;
        });
        if (_expanded) {
          _controller.forward();
        } else {
          _controller.reverse();
        }
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        height: _expanded ? 80 : 60,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(widget.leftIcon),
            SizedBox(width: 8),
            AnimatedSize(
              duration: const Duration(milliseconds: 300),
              // vsync: this,
              child: SizedBox(
                width: _expanded ? MediaQuery.of(context).size.width / 2 : 0,
                child: Text(
                  '${widget.number}',
                  style: TextStyle(fontSize: 24),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            SizedBox(width: 8),
            Icon(widget.rightIcon),
          ],
        ),
      ),
    );
  }
}
