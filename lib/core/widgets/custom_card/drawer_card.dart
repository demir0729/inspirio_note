import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../product/constant/size_constant.dart';

class DrawerCard extends StatelessWidget {
  const DrawerCard({
    super.key,
    required this.onTap,
    required this.title,
    required this.iconPath,
  });
  final void Function() onTap;
  final String title;
  final String iconPath;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      color: Theme.of(context).secondaryHeaderColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3)),
      child: InkWell(
          onTap: onTap,
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: SizeConstant(context).height03,
            ),
            height: SizeConstant(context).height7,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        fontSize: SizeConstant(context).height019,
                      ),
                ),
                SvgPicture.asset(
                  iconPath,
                  width: SizeConstant(context).width06,
                ),
              ],
            ),
          )),
    );
  }
}
