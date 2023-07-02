import 'package:flutter/material.dart';
import 'package:my_notes/product/extension/string_extension.dart';
import 'package:my_notes/product/lang/locale_keys.g.dart';
import '../../../../product/constant/size_constant.dart';
import '../../model/add_note_provider.dart';
import 'package:provider/provider.dart';

class TitleTextfield extends StatefulWidget {
  const TitleTextfield({super.key});

  @override
  State<TitleTextfield> createState() => _TitleTextfieldState();
}

class _TitleTextfieldState extends State<TitleTextfield> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: SizeConstant(context).height07,
      width: SizeConstant(context).width9,
      child: TextField(
        onTap: () {
          context.read<AddViewProvider>().properties(context, 'null');
        },
        cursorWidth: 3,
        cursorRadius: const Radius.circular(5),
        cursorColor: Theme.of(context).textTheme.titleLarge?.color,
        style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontSize: SizeConstant(context).width05,
            ),
        onSubmitted: (value) {
          context.read<AddViewProvider>().saveAndCloseTextfield(context);
        },
        controller: context.watch<AddViewProvider>().titleController,
        focusNode: context.watch<AddViewProvider>().titleFocusNode,
        decoration: InputDecoration(
          hintText: LocaleKeys.addTitle.locale,
          hintStyle: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontSize: SizeConstant(context).width05,
              ),
          contentPadding: EdgeInsets.zero,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
        ),
      ),
    );
  }
}
