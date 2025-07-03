import 'package:firebase_authentication_app/core/utils/constants/assets_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class OtherAuthOptionsWidget extends StatelessWidget {
  final bool isAbsorbing;
  final Function()? onGoogleTap;
  final Function()? onFaceBookTap;
  final Function()? onTwitterTap;
  const OtherAuthOptionsWidget({
    super.key,
    this.isAbsorbing = false,
    this.onGoogleTap,
    this.onFaceBookTap,
    this.onTwitterTap,
  });

  @override
  Widget build(BuildContext context) {
    return AbsorbPointer(
      absorbing: isAbsorbing,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          InkWell(
            borderRadius: BorderRadius.circular(25),
            onTap: onGoogleTap,
            child: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: SvgPicture.asset(
                AssetsConstants.googleIcon,
                height: 30,
                width: 30,
              ),
            ),
          ),
          InkWell(
            borderRadius: BorderRadius.circular(25),
            onTap: onFaceBookTap,
            child: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: Image.asset(
                AssetsConstants.facebookImage,
                height: 30,
                width: 30,
              ),
            ),
          ),

          InkWell(
            borderRadius: BorderRadius.circular(25),
            onTap: onTwitterTap,
            child: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: Image.asset(
                AssetsConstants.twitterImage,
                height: 30,
                width: 30,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
