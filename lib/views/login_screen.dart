import 'package:flutter/material.dart';
import 'package:itenders/views/register.dart';

class LoginScreen3 extends StatefulWidget {
  @override
  _LoginScreen3State createState() => new _LoginScreen3State();
}

class _LoginScreen3State extends State<LoginScreen3>
    with TickerProviderStateMixin {

  //The code is commented because instead of manual scrolling with animation,
  //Now PageView is being used

  double scrollPercent = 0.0;
  Offset startDrag;
  double startDragPercentScroll;
  double dragDirection; // -1 for left, +1 for right

  AnimationController controller_minus1To0;
  AnimationController controller_0To1;
  CurvedAnimation anim_minus1To0;
  CurvedAnimation anim_0To1;

  final numCards = 3;

  void _onHorizontalDragStart(DragStartDetails details) {
    startDrag = details.globalPosition;
    startDragPercentScroll = scrollPercent;
  }

  void _onHorizontalDragUpdate(DragUpdateDetails details) {
    final currDrag = details.globalPosition;
    final dragDistance = currDrag.dx - startDrag.dx;
    if (dragDistance > 0) {
      dragDirection = 1.0;
    } else {
      dragDirection = -1.0;
    }
    final singleCardDragPercent = dragDistance / context.size.width;

    setState(() {
      scrollPercent =
          (startDragPercentScroll + (-singleCardDragPercent / numCards))
              .clamp(0.0 - (1 / numCards), (1 / numCards));
      print(scrollPercent);
    });
  }

  void _onHorizontalDragEnd(DragEndDetails details) {
    if (scrollPercent > 0.1666) {
      print("FIRST CASE");
      controller_0To1.forward(from: scrollPercent * numCards);
    } else if (scrollPercent < 0.1666 &&
        scrollPercent > -0.1666 &&
        dragDirection == -1.0) {
      print("SECOND CASE");
      controller_0To1.reverse(from: scrollPercent * numCards);
    } else if (scrollPercent < 0.1666 &&
        scrollPercent > -0.1666 &&
        dragDirection == 1.0) {
      print("THIRD CASE");
      controller_minus1To0.forward(from: scrollPercent * numCards);
    } else if (scrollPercent < -0.1666) {
      print("LAST CASE");
      controller_minus1To0.reverse(from: scrollPercent * numCards);
    }

    setState(() {
      startDrag = null;
      startDragPercentScroll = null;
    });
  }


  @override
  void initState() {
    super.initState();

    //The code is commented because instead of manual scrolling with animation,
    //Now PageView is being used


    controller_minus1To0 = new AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
      lowerBound: -1.0,
      upperBound: 0.0,
    );
    controller_0To1 = new AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
      lowerBound: 0.0,
      upperBound: 1.0,
    );

    anim_minus1To0 = new CurvedAnimation(
      parent: controller_minus1To0,
      curve: Interval(0.10, 0.90, curve: Curves.bounceInOut),
    );
    anim_0To1 = new CurvedAnimation(
      parent: controller_0To1,
      curve: Interval(0.10, 0.90, curve: Curves.bounceInOut),
    );

    anim_0To1.addListener(() {
      scrollPercent = controller_0To1.value / numCards;
//      print(scrollPercent);
      setState(() {});
    });

    anim_minus1To0.addListener(() {
      scrollPercent = controller_minus1To0.value / numCards;
//      print(scrollPercent);
      setState(() {});
    });

  }

  Widget HomePage() {
    return new Container(
      height: MediaQuery.of(context).size.height,

      child: new Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all( 50.0),
            child:
              Image(image: AssetImage('assets/images/itenders_logo.png')),

          ),
          Container(
            padding: EdgeInsets.only(top: 20.0),
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Awesome",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                  ),
                ),
                Text(
                  "App",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          new Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.only(left: 30.0, right: 30.0, top: 150.0),
            alignment: Alignment.center,
            child: new Row(
              children: <Widget>[
                new Expanded(
                  child: new OutlineButton(
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(30.0)),
                    color: Colors.redAccent,
                    highlightedBorderColor: Colors.white,
                    onPressed: () => gotoSignup(),
                    child: new Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 20.0,
                        horizontal: 20.0,
                      ),
                      child: new Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          new Expanded(
                            child: Text(
                              "SIGN UP",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          new Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.only(left: 30.0, right: 30.0, top: 30.0),
            alignment: Alignment.center,
            child: new Row(
              children: <Widget>[
                new Expanded(
                  child: new FlatButton(
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(30.0)),
                    color: Colors.white,
                    onPressed: () => gotoLogin(),
                    child: new Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 20.0,
                        horizontal: 20.0,
                      ),
                      child: new Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          new Expanded(
                            child: Text(
                              "LOGIN",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.redAccent,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget LoginPage() {
LoginPage();
  }

  Widget SignupPage() {
RegisterPage();
  }

  gotoLogin() {
    //controller_0To1.forward(from: 0.0);
    _controller.animateToPage(
      0,
      duration: Duration(milliseconds: 800),
      curve: Curves.bounceOut,
    );
  }

  gotoSignup() {
    //controller_minus1To0.reverse(from: 0.0);
    _controller.animateToPage(
      2,
      duration: Duration(milliseconds: 800),
      curve: Curves.bounceOut,
    );
  }

  PageController _controller = new PageController(initialPage: 1, viewportFraction: 1.0);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height,
//      child: new GestureDetector(
//        onHorizontalDragStart: _onHorizontalDragStart,
//        onHorizontalDragUpdate: _onHorizontalDragUpdate,
//        onHorizontalDragEnd: _onHorizontalDragEnd,
//        behavior: HitTestBehavior.translucent,
//        child: Stack(
//          children: <Widget>[
//            new FractionalTranslation(
//              translation: Offset(-1 - (scrollPercent / (1 / numCards)), 0.0),
//              child: SignupPage(),
//            ),
//            new FractionalTranslation(
//              translation: Offset(0 - (scrollPercent / (1 / numCards)), 0.0),
//              child: HomePage(),
//            ),
//            new FractionalTranslation(
//              translation: Offset(1 - (scrollPercent / (1 / numCards)), 0.0),
//              child: LoginPage(),
//            ),
//          ],
//        ),
//      ),
        child: PageView(
          controller: _controller,
          physics: new AlwaysScrollableScrollPhysics(),
          children: <Widget>[LoginPage(), HomePage(), SignupPage()],
          scrollDirection: Axis.horizontal,
        ));
  }
}
