import 'package:flutter/material.dart';

class LoadingView extends StatelessWidget {
  const LoadingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: false,
      child: TweenAnimationBuilder(
        key: UniqueKey(),
        duration: const Duration(milliseconds: 200),
        tween: Tween<double>(
          begin: 0.0,
          end: 1.0,
        ),
        curve: Curves.easeInQuart,
        builder: (BuildContext context, double value, Widget? child) {
          return Opacity(
            opacity: .3,
            child: child,
          );
        },
        child: Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.black,
          child: Focus(
            focusNode: FocusNode(),
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          ),
        ),
      ),
    );
  }
}
