import 'package:altkamul/app/questions/data/models/QuestionsModel.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SingleQuestionCard extends StatelessWidget {
  final Items item;

  SingleQuestionCard({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            CachedNetworkImage(
              width: 70,
              height: 70,
              imageUrl: "${item.owner!.profileImage}",
              placeholder: (context, url) =>
              const CircularProgressIndicator(),
              errorWidget: (context, url, error) => const Icon(
                Icons.error,
                color: Colors.red,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              "${item.owner!.displayName}",
              textAlign: TextAlign.center,
              overflow: TextOverflow.clip,
              style: const TextStyle(fontSize: 12),
            ),
            const SizedBox(
              height: 5,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "${item.title}",
                  textAlign: TextAlign.start,
                  overflow: TextOverflow.clip,
                  style: const TextStyle(
                      fontSize: 12, fontWeight: FontWeight.w500),
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Icon(
                      Icons.remove_red_eye_sharp,
                      size: 13,
                    ),
                    const SizedBox(
                      width: 3,
                    ),
                    Text(
                      "${item.viewCount}",
                      textAlign: TextAlign.start,
                      overflow: TextOverflow.clip,
                      style: const TextStyle(
                          fontSize: 12, fontWeight: FontWeight.w400),
                    ),
                    const SizedBox(
                      width: 3,
                    ),
                    const Text("|"),
                    const SizedBox(
                      width: 3,
                    ),
                    const Icon(
                      Icons.question_answer_outlined,
                      size: 13,
                    ),
                    const SizedBox(
                      width: 3,
                    ),
                    Text(
                      "${item.answerCount}",
                      textAlign: TextAlign.start,
                      overflow: TextOverflow.clip,
                      style: const TextStyle(
                          fontSize: 12, fontWeight: FontWeight.w400),
                    ),
                    const SizedBox(
                      width: 3,
                    ),
                    const Text("|"),
                    const SizedBox(
                      width: 3,
                    ),
                    const Icon(
                      Icons.score_rounded,
                      size: 13,
                    ),
                    const SizedBox(
                      width: 3,
                    ),
                    Text(
                      "${item.score}",
                      textAlign: TextAlign.start,
                      overflow: TextOverflow.clip,
                      style: const TextStyle(
                          fontSize: 12, fontWeight: FontWeight.w400),
                    ),
                  ],
                ),

                SizedBox(
                  height: 50,
                  child: ListView.builder(
                    itemBuilder: (context, index) {
                      return Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(5),
                            margin: const EdgeInsets.all(5),
                            child: Text(
                              item.tags![index],
                              style: const TextStyle(color: Colors.white),
                            ),
                            decoration: BoxDecoration(
                                color: Colors.blueAccent.withOpacity(0.7),
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(5))),
                          )
                        ],
                      );
                    },
                    itemCount: item.tags!.length,
                    scrollDirection: Axis.horizontal,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
