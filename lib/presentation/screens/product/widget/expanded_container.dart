import 'package:flutter/material.dart';

class ExpandedSection extends StatefulWidget {
  final Widget? firstChild;
  final Widget? secChild;
  ExpandedSection({this.firstChild, this.secChild});

  @override
  _ExpandedSectionState createState() => _ExpandedSectionState();
}

class _ExpandedSectionState extends State<ExpandedSection>
    with SingleTickerProviderStateMixin {
  AnimationController? _controller;
  Animation<double>? _animation;

  @override
  void initState() {
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _controller!,
      curve: Curves.fastLinearToSlowEaseIn,
    );
    super.initState();
  }

  _toggleContainer() {
    print(_animation!.status);
    if (_animation!.status != AnimationStatus.completed) {
      _controller!.forward();
    } else {
      _controller!.animateBack(0, duration: Duration(milliseconds: 500));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () => _toggleContainer(),
          child: widget.firstChild!,
        ),
        SizeTransition(
          sizeFactor: _animation!,
          axis: Axis.vertical,
          child: widget.secChild,
        ),
      ],
    );
  }
}
