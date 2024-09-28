import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ItemHeaderTournamentWidget extends StatelessWidget {
  const ItemHeaderTournamentWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: CustomRectClipper(),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 60.w),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [
              Color(0xffE2234D),
              Color(0xff87000A),
            ],
          ),
        ),
        child: const Text(
          'TOURNAMENT',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontSize: 20),
        ),
      ),
    );
  }
}

class CustomRectClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.moveTo(40, 0);
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height - 40);
    path.lineTo(size.width - 40, size.height);
    path.lineTo(0, size.height);
    path.lineTo(0, 40);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomRectClipper oldClipper) => false;
}
