// import 'package:flutter/material.dart';
// import 'package:story_view/story_view.dart';

// class OwStoryView extends StatelessWidget {
//   final StoryController controller;
//   final List<StoryItem> storyItems;
//   final bool repeat;
//   final Function onStoryShow;
//   final Function onComplete;

//   const OwStoryView({
//     this.controller,
//     this.storyItems,
//     this.repeat = true,
//     this.onStoryShow,
//     this.onComplete,
//   }) : super();

//   @override
//   Widget build(BuildContext context) {
//     return StoryView(
//       storyItems: storyItems,
//       controller: controller,
//       repeat: repeat,
//       onStoryShow: onStoryShow ?? (s) {print(s.toString());},
//       onComplete: onComplete ?? () {},
//       onVerticalSwipeComplete: (direction) {
//         if (direction == Direction.down) {
//           Navigator.pop(context);
//         }
//       }
//     );
//   }
// }