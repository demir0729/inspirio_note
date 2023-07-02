import 'package:flutter/material.dart';
import 'package:my_notes/product/extension/string_extension.dart';
import '../../../../product/constant/size_constant.dart';
import '../../model/add_note_provider.dart';
import 'package:provider/provider.dart';

class TitleTextRich extends StatelessWidget {
  const TitleTextRich({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return SizedBox(
      height:SizeConstant(context).height07,
      width:SizeConstant(context).width9,
      child: GestureDetector(
        onTap: () {
          context.read<AddViewProvider>().openAndEditTextfield();
        },
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              context
                  .watch<AddViewProvider>()
                  .noteTitle
                  .toEditingTitleShort(width),
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontSize: SizeConstant(context).width05,
                  ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Icon(
                size: SizeConstant(context).width05,
                Icons.edit_note_outlined,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
