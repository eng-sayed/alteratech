import 'package:alteratech/core/utils/responsive.dart';
import 'package:alteratech/core/utils/utiles.dart';
import 'package:alteratech/presentation/components/my+text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/themes/colors.dart';
import 'dart:math' as math;

class AboutUs extends StatelessWidget {
  const AboutUs({Key? key}) : super(key: key);
  Future<void> loc() async {
    const url =
        'https://www.google.com/maps?ll=31.040422,31.366653&z=17&t=m&hl=en-US&gl=US&mapclient=embed&cid=8501512211049020545';
    if (await canLaunch(url)) {
      print('done');
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: NeoText(
        "About US".tr(),
        color: AppColors.white,
        size: 19,
      )),
      body: SingleChildScrollView(
          child: Container(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 10.h,
            ),
            CircleAvatar(
              backgroundColor: AppColors.white,
              backgroundImage: Image.asset("assets/images/logo.png").image,
              radius: 80.fs,
            ),
            // SizedBox(
            //   height: 20,
            // ),
            // NeoText(
            //   "About US".tr(),
            //   color: Colors.grey.shade700,
            //   size: 16.fs,
            // ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: NeoText(
                '''aboutusData'''.tr(),
                color: Colors.grey.shade700,
                maxLines: 50,
                align: TextAlign.justify,
                size: 18,
                fontWeight: FontWeight.w600,
              ),
            )
          ],
        ),
      )),
      floatingActionButton: ExpandableFab(
        children: [
          ActionButton(
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                        contentPadding: EdgeInsets.all(8),
                        title: NeoText(
                          'Call Us',
                          fontWeight: FontWeight.w600,
                          color: AppColors.primiry,
                          size: 22,
                          align: TextAlign.left,
                        ),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            InkWell(
                              onTap: () async {
                                if (await canLaunch('tel: 01009805896')) {
                                  print('done');
                                  await launch('tel: 01009805896');
                                } else {
                                  throw 'Could not launch tel: 01009805896';
                                }
                              },
                              child: NeoText(
                                '01009805896',
                                size: 20,
                                color: AppColors.secondary,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            InkWell(
                              onTap: () async {
                                if (await canLaunch('tel: 0502255436')) {
                                  print('done');
                                  await launch('tel: 0502255436');
                                } else {
                                  throw 'Could not launch tel: 0502255436';
                                }
                              },
                              child: NeoText(
                                '0502255436',
                                size: 20,
                                color: AppColors.secondary,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ));
            },
            icon: Icon(
              Icons.call,
              color: AppColors.white,
            ),
          ),
          ActionButton(
            onPressed: () => {loc()},
            icon: Icon(
              Icons.location_on_outlined,
              color: AppColors.white,
            ),
          ),
          ActionButton(
            onPressed: () async {
              const url = 'https://www.facebook.com/Alteratech.eg/';
              if (await canLaunch(url)) {
                print('done');
                await launch(url);
              } else {
                throw 'Could not launch $url';
              }
            },
            icon: Icon(
              Icons.facebook,
              color: AppColors.white,
            ),
          ),
          ActionButton(
            onPressed: () {
              Utiles().openwhatsapp(context);
            },
            icon: Icon(
              Icons.whatsapp,
              color: AppColors.white,
            ),
          ),
        ],
        distance: 112,
      ),
    );
  }
}

class CustomClipPath extends CustomClipper<Path> {
  var radius = 10.0;
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height);
    path.quadraticBezierTo(
        size.width / 2, size.height - 100, size.width, size.height);
    path.lineTo(size.width, 0);

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

@immutable
class ExpandableFab extends StatefulWidget {
  const ExpandableFab({
    Key? key,
    this.initialOpen,
    required this.distance,
    required this.children,
  }) : super(key: key);

  final bool? initialOpen;
  final double distance;
  final List<Widget> children;

  @override
  _ExpandableFabState createState() => _ExpandableFabState();
}

class _ExpandableFabState extends State<ExpandableFab>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _expandAnimation;
  bool _open = false;

  @override
  void initState() {
    super.initState();
    _open = widget.initialOpen ?? false;
    _controller = AnimationController(
      value: _open ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 250),
      vsync: this,
    );
    _expandAnimation = CurvedAnimation(
      curve: Curves.fastOutSlowIn,
      reverseCurve: Curves.easeOutQuad,
      parent: _controller,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggle() {
    setState(() {
      _open = !_open;
      if (_open) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Stack(
        alignment: Alignment.bottomRight,
        clipBehavior: Clip.none,
        children: [
          _buildTapToCloseFab(),
          ..._buildExpandingActionButtons(),
          _buildTapToOpenFab(),
        ],
      ),
    );
  }

  Widget _buildTapToCloseFab() {
    return SizedBox(
      width: 56.0,
      height: 56.0,
      child: Center(
        child: Material(
          shape: const CircleBorder(),
          clipBehavior: Clip.antiAlias,
          elevation: 4.0,
          child: InkWell(
            onTap: _toggle,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                Icons.close,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildExpandingActionButtons() {
    final children = <Widget>[];
    final count = widget.children.length;
    final step = 90.0 / (count - 1);
    for (var i = 0, angleInDegrees = 0.0;
        i < count;
        i++, angleInDegrees += step) {
      children.add(
        _ExpandingActionButton(
          directionInDegrees: angleInDegrees,
          maxDistance: widget.distance,
          progress: _expandAnimation,
          child: widget.children[i],
        ),
      );
    }
    return children;
  }

  Widget _buildTapToOpenFab() {
    return IgnorePointer(
      ignoring: _open,
      child: AnimatedContainer(
        transformAlignment: Alignment.center,
        transform: Matrix4.diagonal3Values(
          _open ? 0.7 : 1.0,
          _open ? 0.7 : 1.0,
          1.0,
        ),
        duration: const Duration(milliseconds: 250),
        curve: const Interval(0.0, 0.5, curve: Curves.easeOut),
        child: AnimatedOpacity(
          opacity: _open ? 0.0 : 1.0,
          curve: const Interval(0.25, 1.0, curve: Curves.easeInOut),
          duration: const Duration(milliseconds: 250),
          child: FloatingActionButton(
            onPressed: _toggle,
            child: Icon(
              Icons.contact_support_outlined,
              size: 25,
              color: AppColors.white,
            ),
          ),
        ),
      ),
    );
  }
}

@immutable
class _ExpandingActionButton extends StatelessWidget {
  const _ExpandingActionButton({
    Key? key,
    required this.directionInDegrees,
    required this.maxDistance,
    required this.progress,
    required this.child,
  }) : super(key: key);

  final double directionInDegrees;
  final double maxDistance;
  final Animation<double> progress;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: progress,
      builder: (context, child) {
        final offset = Offset.fromDirection(
          directionInDegrees * (math.pi / 180.0),
          progress.value * maxDistance,
        );
        return Positioned(
          right: 4.0 + offset.dx,
          bottom: 4.0 + offset.dy,
          child: Transform.rotate(
            angle: (1.0 - progress.value) * math.pi / 2,
            child: child!,
          ),
        );
      },
      child: FadeTransition(
        opacity: progress,
        child: child,
      ),
    );
  }
}

@immutable
class ActionButton extends StatelessWidget {
  const ActionButton({
    Key? key,
    this.onPressed,
    required this.icon,
  }) : super(key: key);

  final VoidCallback? onPressed;
  final Widget icon;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Material(
      shape: const CircleBorder(),
      clipBehavior: Clip.antiAlias,
      color: theme.colorScheme.secondary,
      elevation: 4.0,
      child: IconButton(
        onPressed: onPressed,
        icon: icon,
        color: theme.colorScheme.secondary,
      ),
    );
  }
}

class ContactDesignWidget extends StatelessWidget {
  IconData iconData;
  String data;
  Function taped;
  ContactDesignWidget(
      {required this.iconData, required this.data, required this.taped});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: GestureDetector(
        onDoubleTap: taped(),
        child: Container(
          height: 50.h,
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Icon(
                  iconData,
                  color: Colors.orange,
                  size: 30,
                ),
              ),
              SizedBox(
                width: 15,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 8),
                child: NeoText(
                  data,
                  // style: contact(),
                  // textOverflow: TextOverflow.ellipsis,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
