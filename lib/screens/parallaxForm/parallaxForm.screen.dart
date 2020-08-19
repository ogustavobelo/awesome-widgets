import 'package:awesome_widgets/sharedWidgets/animatedRoundedButton/rounded.button.dart';
import 'package:awesome_widgets/sharedWidgets/show_animations/showup_animation.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class ParallaxFormScreen extends StatefulWidget {
  @override
  _ParallaxFormScreenState createState() => _ParallaxFormScreenState();
}

class _ParallaxFormScreenState extends State<ParallaxFormScreen>
    with TickerProviderStateMixin {
  final Color _primaryColor = Color(0xFF655b99);
  final Color _backgroundColor = Color(0xFFC7D4E2);

  AnimationController _controller;
  Animation<double> animation;

  bool openForm = false;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(vsync: this);

    animation = Tween<double>(begin: 0, end: 1)
        .chain(CurveTween(curve: Curves.ease))
        .animate(_controller)
          ..addListener(() {
            setState(() {});
          });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        if (openForm) {
          toCloseForm();
        }
      },
      child: Scaffold(
        backgroundColor: _backgroundColor,
        body: SingleChildScrollView(
          child: Container(
            width: size.width,
            height: size.height,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Lottie.asset("assets/animations/moon_parallax.json",
                    controller: _controller,
                    fit: BoxFit.fitWidth, onLoaded: (composition) {
                  _controller
                    ..duration = composition.duration
                    ..forward()
                    ..repeat(min: 0.0, max: 0.7);
                }),
                Positioned(
                  bottom: 10,
                  left: 0,
                  right: 0,
                  child: openForm
                      ? Container()
                      : ShowUp(
                          delay: 0,
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                AnimatedRoundedButton(
                                    text: "Sign In",
                                    color: _primaryColor,
                                    textColor: Colors.white,
                                    onPressed: () => toOpenForm()),
                                VerticalDivider(),
                                AnimatedRoundedButton(
                                    text: "Sign Up", onPressed: () {}),
                              ],
                            ),
                          ),
                        ),
                ),
                Positioned(
                    top: size.height * .3,
                    left: 0,
                    right: 0,
                    child: _controller.value < .8
                        ? Container()
                        : ShowUp(
                            delay: 100,
                            child: Container(
                                margin: EdgeInsets.all(24.0),
                                padding: EdgeInsets.all(24.0),
                                height: size.height * .3,
                                decoration: BoxDecoration(
                                  color: _primaryColor,
                                  borderRadius: BorderRadius.circular(24.0),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    TextFormField(
                                      style: TextStyle(color: Colors.white),
                                      decoration: InputDecoration(
                                          hintText: "Enter your email",
                                          hintStyle:
                                              TextStyle(color: _primaryColor),
                                          prefixIcon: Icon(Icons.person,
                                              color: _primaryColor),
                                          focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.purple),
                                              borderRadius:
                                                  BorderRadius.circular(24.0)),
                                          enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.purple),
                                              borderRadius:
                                                  BorderRadius.circular(24.0)),
                                          filled: true,
                                          fillColor:
                                              Colors.white.withOpacity(.5)),
                                    ),
                                    Divider(color: Colors.transparent),
                                    TextFormField(
                                      style: TextStyle(color: Colors.white),
                                      obscureText: true,
                                      decoration: InputDecoration(
                                          hintText: "Enter your password",
                                          hintStyle:
                                              TextStyle(color: _primaryColor),
                                          prefixIcon: Icon(Icons.vpn_key,
                                              color: _primaryColor),
                                          suffixIcon: Icon(Icons.remove_red_eye,
                                              color: _primaryColor),
                                          focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.purple),
                                              borderRadius:
                                                  BorderRadius.circular(24.0)),
                                          enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.purple),
                                              borderRadius:
                                                  BorderRadius.circular(24.0)),
                                          filled: true,
                                          fillColor:
                                              Colors.white.withOpacity(.5)),
                                    ),
                                    Divider(color: Colors.transparent),
                                    AnimatedRoundedButton(
                                        text: "Sign In",
                                        color: _backgroundColor,
                                        textColor: _primaryColor,
                                        onPressed: () {}),
                                  ],
                                )))),
                AnimatedPositioned(
                  duration: Duration(milliseconds: 750),
                  curve: Curves.ease,
                  right: 0,
                  top: _controller.value < .9 ? size.height : size.height * .5,
                  child: IgnorePointer(
                    child: Lottie.asset("assets/animations/astronaut.json",
                        width: size.width * .75,
                        height: size.width * .75,
                        fit: BoxFit.contain),
                  ),
                ),
                Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    child: AppBar(
                        backgroundColor: Colors.transparent, elevation: 0.0)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void toOpenForm() {
    setState(() {
      openForm = true;
    });
    _controller.animateTo(1.0,
        duration: Duration(seconds: 2), curve: Curves.ease);
  }

  void toCloseForm() async {
    await _controller.animateBack(.7,
        duration: Duration(seconds: 1), curve: Curves.ease);
    setState(() {
      openForm = false;
    });
    _controller.repeat(min: 0.0, max: 0.7);
  }
}
