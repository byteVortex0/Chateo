import 'dart:developer';

import 'package:chateo/core/extensions/context_extension.dart';
import 'package:chateo/core/extensions/date_extension.dart';
import 'package:flutter/material.dart';

import '../../../../Auth/loginPersonalInfo/data/models/personal_info_model.dart';
import '../../../add_story/data/model/story_model.dart';

class LinearAndName extends StatelessWidget {
  const LinearAndName({
    super.key,
    required this.stories,
    required this.currentIndex,
    required this.currentStory,
    required this.controller,
    required this.personalInfo,
  });

  final List<StoryData> stories;
  final int currentIndex;
  final StoryData currentStory;
  final AnimationController controller;
  final PersonalInfoModel personalInfo;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children:
              stories.asMap().entries.map((entry) {
                final index = entry.key;
                return Expanded(
                  child: Padding(
                    padding: EdgeInsetsDirectional.only(end: 3),
                    child:
                        index == currentIndex
                            ? AnimatedBuilder(
                              animation: controller,
                              builder:
                                  (context, child) => LinearProgressIndicator(
                                    backgroundColor: Colors.white,
                                    color: Colors.grey,
                                    value: controller.value,
                                  ),
                            )
                            : LinearProgressIndicator(
                              backgroundColor:
                                  currentIndex > index
                                      ? Colors.grey
                                      : Colors.white,
                              color: Colors.grey,
                              value: currentIndex == index ? 1 : 0,
                            ),
                  ),
                );
              }).toList(),
        ),

        const SizedBox(height: 10),
        Row(
          children: [
            IconButton(
              onPressed: () {
                context.pop();
              },
              icon: const Icon(Icons.arrow_back, color: Colors.white),
            ),
            const SizedBox(width: 10),
            GestureDetector(
              onTap: () {
                log('Profile picture tapped');
              },
              child: CircleAvatar(
                radius: 25,
                backgroundImage: NetworkImage(personalInfo.imageUrl),
              ),
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${personalInfo.firstName} ${personalInfo.lastName}',
                  style: const TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),
                //TODO: Add a function to get the time of the story
                Text(
                  currentStory.createdAt.toReadableTime,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
