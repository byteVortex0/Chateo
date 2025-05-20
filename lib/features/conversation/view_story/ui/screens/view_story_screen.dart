import 'package:chateo/core/extensions/context_extension.dart';
import 'package:chateo/features/conversation/add_story/data/model/story_model.dart';
import 'package:chateo/features/conversation/view_story/ui/widgets/pic_and_text_story.dart';
import 'package:flutter/material.dart';

import '../../../../Auth/loginPersonalInfo/data/models/personal_info_model.dart';

class ViewStoryScreen extends StatefulWidget {
  const ViewStoryScreen({
    super.key,
    required this.allStories,
    required this.index,
  });

  final List<Map<String, dynamic>> allStories;
  final int index;

  @override
  State<ViewStoryScreen> createState() => _ViewStoryScreenState();
}

class _ViewStoryScreenState extends State<ViewStoryScreen>
    with TickerProviderStateMixin {
  late AnimationController _animatedController;
  int currentIndex = 0;

  double _dragOffset = 0.0;
  late StoryModel stories;
  late PersonalInfoModel personalInfo;
  late int index;

  @override
  void initState() {
    super.initState();
    _initAnimation();
    index = widget.index;
    stories = widget.allStories[index]['story'];
    personalInfo = widget.allStories[index]['personalInfo'];
  }

  void _initAnimation() {
    _animatedController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );

    Tween<double>(begin: 0, end: 1).animate(_animatedController)
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _goToNextStory();
        }
      });

    _startAnimation();
  }

  void _startAnimation() {
    setState(() {
      _dragOffset = 0.0;
    });
    _animatedController.reset();
    _animatedController.forward();
  }

  void _goToNextStory() {
    if (currentIndex < stories.storiesData.length - 1) {
      currentIndex++;
      _startAnimation();
    } else {
      if (index < widget.allStories.length - 1) {
        currentIndex = 0;
        index++;
        stories = widget.allStories[index]['story'];
        personalInfo = widget.allStories[index]['personalInfo'];
        // i want animation when i go to next user story
        _animatedController.reset();
        _animatedController.forward();
        _startAnimation();
      } else {
        context.pop();
      }
    }
    setState(() {});
  }

  @override
  void dispose() {
    _animatedController.dispose();
    super.dispose();
  }

  void previousStory() {
    if (currentIndex > 0) {
      currentIndex--;
      _startAnimation();
    } else {
      if (index > 1) {
        currentIndex = stories.storiesData.length - 1;
        index--;
        stories = widget.allStories[index]['story'];
        personalInfo = widget.allStories[index]['personalInfo'];
        _animatedController.reset();
        _animatedController.forward();
        _startAnimation();
      } else {
        context.pop();
      }
    }
  }

  void pauseStory() {
    _animatedController.stop();
  }

  void resumeStory() {
    _animatedController.forward();
  }

  void handleVerticalDrag(DragUpdateDetails details) {
    final dy = details.primaryDelta ?? 0;

    if (dy > 0) {
      _animatedController.stop();

      setState(() {
        _dragOffset += dy;
      });
    } else if (dy < 0) {
      _animatedController.forward();
    }
  }

  void handleVerticalDragEnd(DragEndDetails details, VoidCallback onExit) {
    final velocity = details.primaryVelocity;

    if (velocity != null) {
      if (velocity > 1000 || _dragOffset > 100) {
        onExit();
      } else {
        _startAnimation();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: GestureDetector(
          onTapDown: (details) {
            final width = MediaQuery.of(context).size.width;
            final dx = details.globalPosition.dx;

            if (dx < width / 3) {
              previousStory();
            } else if (dx > width / 3 * 2) {
              _goToNextStory();
            }
          },
          onLongPress: () {
            pauseStory();
            _animatedController.stop();
          },
          onLongPressUp: () {
            resumeStory();
          },
          onVerticalDragUpdate: handleVerticalDrag,
          onVerticalDragEnd:
              (details) => handleVerticalDragEnd(details, () {
                context.pop();
              }),
          child: AnimatedSlide(
            offset: Offset(0, _dragOffset / MediaQuery.of(context).size.height),
            duration: const Duration(milliseconds: 100),
            child: PicAndTextStory(
              stories: stories.storiesData,
              currentIndex: currentIndex,
              controller: _animatedController,
              personalInfo: personalInfo,
            ),
          ),
        ),
      ),
    );
  }
}
