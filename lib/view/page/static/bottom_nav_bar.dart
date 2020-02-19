import 'package:flutter/material.dart';

class BottomNavBar extends StatefulWidget {
  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        // ClipPath(
        //   clipper: MyClipper(),
        // child:
        Material(
          elevation: 5,
          child: Container(
            height: 50,
            color: Color(0xff088da5).withOpacity(0.4),
            padding: EdgeInsets.only(top: 3),
            // child: ClipPath(
            //   clipper: MyClipper(),
            child: Container(
              padding: EdgeInsets.only(top: 13),
              height: 60,
              // color: Color(0xff088da5),
              color: Color(0xff0e2f44),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  SizedBox(
                    width: 10,
                  ),
                  GestureDetector(
                      onTap: () {},
                      child: Container(
                          height: 30,
                          child: Text(
                            "PEREKAMAN",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ))),
                  SizedBox(
                    width: 60,
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                        height: 30,
                        child: Text(
                          "PEMUTAKHIRAN",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        )),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                ],
              ),
            ),
            // ),
            // ),
          ),
        )
      ],
    );
  }
}

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();

    path.lineTo(0, size.height - 350);
    path.lineTo(size.height, size.width + 1000000);
    path.lineTo(size.width, 0);
    path.quadraticBezierTo(size.width / 7, size.height * 0.5, 0, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
