import 'package:flutter/material.dart';

import '../../../../Auth/loginPersonalInfo/data/models/personal_info_model.dart';
import '../../../add_story/data/model/story_model.dart';
import 'linear_and_name.dart';

class PicAndTextStory extends StatefulWidget {
  const PicAndTextStory({
    super.key,
    required this.stories,
    required this.currentIndex,
    required this.controller,
    required this.personalInfo,
  });

  final List<StoryData> stories;
  final int currentIndex;
  final AnimationController controller;
  final PersonalInfoModel personalInfo;

  @override
  State<PicAndTextStory> createState() => _PicAndTextStoryState();
}

class _PicAndTextStoryState extends State<PicAndTextStory> {
  @override
  Widget build(BuildContext context) {
    final currentStory = widget.stories[widget.currentIndex];
    final hasImage =
        currentStory.imageUrl != null && currentStory.imageUrl!.isNotEmpty;
    final hasText =
        currentStory.caption != null && currentStory.caption!.isNotEmpty;
    return Stack(
      children: [
        if (hasImage && hasText)
          Stack(
            children: [
              Positioned.fill(child: Image.network(currentStory.imageUrl!)),
              Positioned(
                bottom: 60,
                left: 0,
                right: 0,
                child: Text(
                  currentStory.caption!,
                  style: const TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        if (hasImage && !hasText)
          Positioned.fill(child: Image.network(currentStory.imageUrl!)),
        if (!hasImage && hasText)
          Container(
            height: double.infinity,
            width: double.infinity,
            color: Colors.transparent,
            alignment: Alignment.center,
            child: Text(
              currentStory.caption!,
              style: const TextStyle(
                fontSize: 24,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

        LinearAndName(
          stories: widget.stories,
          currentIndex: widget.currentIndex,
          currentStory: currentStory,
          controller: widget.controller,
          personalInfo: widget.personalInfo,
        ),
      ],
    );
  }
}
