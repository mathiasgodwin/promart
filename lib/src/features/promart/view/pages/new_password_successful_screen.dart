import 'package:animated_check/animated_check.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:promart/src/features/promart/view/view.dart';

class NewPaswordSuccessful extends StatefulWidget {
  const NewPaswordSuccessful({Key? key}) : super(key: key);

  @override
  _NewPaswordSuccessfulState createState() => _NewPaswordSuccessfulState();

  static Route route() {
    return MaterialPageRoute<void>(
        builder: (_) => const NewPaswordSuccessful());
  }
}

class _NewPaswordSuccessfulState extends State<NewPaswordSuccessful>
    with SingleTickerProviderStateMixin {
  AnimationController? _animationController;
  Animation<double>? _animation;
  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    _animation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _animationController!,
        curve: Curves.easeInOutCirc,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        _animationController!.forward();
      }
    });
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 200, left: 25, right: 25),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            GFAvatar(
              size: 80,
              backgroundColor: Colors.green,
              child: AnimatedCheck(
                progress: _animation!,
                size: 150,
                color: Colors.white,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            const Text(
              'Your password has been updated!',
              style: TextStyle(fontWeight: FontWeight.w400, fontSize: 15),
            ),
            const SizedBox(
              height: 30,
            ),
            GFButton(
                fullWidthButton: true,
                color: Colors.purple,
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => const LoginScreen()));
                },
                text: 'LOGIN',
                size: 60)
          ],
        ),
      ),
    );
  }
}
