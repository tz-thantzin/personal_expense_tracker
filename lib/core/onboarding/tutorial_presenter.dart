import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

import '../extensions/context_extension.dart';

export 'package:tutorial_coach_mark/tutorial_coach_mark.dart'
    show ContentAlign, ShapeLightFocus;

class TutorialStep {
  const TutorialStep({
    required this.targetKey,
    required this.title,
    required this.description,
    this.align = ContentAlign.bottom,
    this.shape = ShapeLightFocus.RRect,
  });

  final GlobalKey targetKey;
  final String title;
  final String description;
  final ContentAlign align;
  final ShapeLightFocus shape;
}

void presentTutorial({
  required BuildContext context,
  required List<TutorialStep> steps,
  required VoidCallback onComplete,
}) {
  if (steps.isEmpty) {
    onComplete();
    return;
  }

  final targets = <TargetFocus>[];
  for (var i = 0; i < steps.length; i++) {
    final step = steps[i];
    targets.add(
      TargetFocus(
        identify: 'tutorial_step_$i',
        keyTarget: step.targetKey,
        shape: step.shape,
        radius: 8,
        contents: [
          TargetContent(
            align: step.align,
            builder: (_, controller) => _TutorialBubble(
              title: step.title,
              description: step.description,
            ),
          ),
        ],
      ),
    );
  }

  TutorialCoachMark(
    targets: targets,
    colorShadow: Colors.black,
    opacityShadow: 0.82,
    paddingFocus: 6,
    textSkip: context.localization.tutorialSkip,
    textStyleSkip: TextStyle(
      color: Colors.white,
      fontSize: 14.sp,
      fontWeight: FontWeight.w700,
    ),
    onFinish: onComplete,
    onSkip: () {
      onComplete();
      return true;
    },
  ).show(context: context);
}

class _TutorialBubble extends StatelessWidget {
  const _TutorialBubble({required this.title, required this.description});

  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.sp,
              fontWeight: FontWeight.w800,
            ),
          ),
          SizedBox(height: 6.h),
          Text(
            description,
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.85),
              fontSize: 14.sp,
              height: 1.35,
            ),
          ),
        ],
      ),
    );
  }
}
