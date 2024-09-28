import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pickle_ball/common/widgets/text_form_field.dart';
import 'package:pickle_ball/utils/assets_utils.dart';
import 'package:pickle_ball/utils/color_utils.dart';
import 'package:pickle_ball/views/find_tournament/widgets/item_competition_format_widget.dart';
import 'package:pickle_ball/providers/campaign_provider.dart';
import 'package:pickle_ball/providers/comment_provider.dart';
import 'package:intl/intl.dart';

class CompetitionFormatView extends ConsumerStatefulWidget {
  final int campaignId;

  const CompetitionFormatView({super.key, required this.campaignId});

  @override
  ConsumerState<CompetitionFormatView> createState() =>
      _CompetitionFormatViewState();
}

class _CompetitionFormatViewState extends ConsumerState<CompetitionFormatView> {
  final TextEditingController _commentController = TextEditingController();

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    ref.read(commentProvider(widget.campaignId).notifier).fetchComments();
  }

  @override
  Widget build(BuildContext context) {
    final comments = ref.watch(commentProvider(widget.campaignId));

    return Scaffold(
      backgroundColor: ColorUtils.primaryBackgroundColor,
      body: Padding(
        padding: const EdgeInsets.only(left: 5, right: 5, bottom: 20).r,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Consumer(
                builder: (context, ref, child) {
                  final campaignAsyncValue =
                      ref.watch(campaignProvider(widget.campaignId));
                  return campaignAsyncValue.when(
                    data: (tournaments) {
                      return Wrap(
                        children: tournaments.map((tournament) {
                          return ItemCompetitionFormatWidget(
                            tournament: tournament,
                          );
                        }).toList(),
                      );
                    },
                    loading: () => const CircularProgressIndicator(),
                    error: (error, stack) =>
                        const Center(child: Text('Chưa có giải đấu nào')),
                  );
                },
              ),
              Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.insert_comment_outlined,
                          color: ColorUtils.blueColor,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Comments (${comments.length})',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: ColorUtils.greenColor,
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                    TextFormFieldCustomWidget(
                      controller: _commentController,
                      hint: 'Write down your comment',
                      maxLine: 5,
                      inputAction: TextInputAction.done,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (_commentController.text.isNotEmpty) {
                          ref
                              .read(commentProvider(widget.campaignId).notifier)
                              .addComment(_commentController.text);
                          _commentController.clear();
                        }
                      },
                      child: const Text('Post Comment'),
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: comments.length,
                      itemBuilder: (context, index) {
                        final comment = comments[index];
                        return ListTile(
                          leading: CircleAvatar(
                            backgroundImage: comment.imageUrl != null
                                ? NetworkImage(comment.imageUrl!)
                                : const AssetImage(AssetUtils.imgSignIn)
                                    as ImageProvider,
                          ),
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                comment.fullName ?? 'Anonymous',
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                DateFormat('dd/MM/yyyy HH:mm')
                                    .format(comment.createDate),
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                          subtitle: Text(
                            comment.commentText,
                            style: const TextStyle(
                              fontSize: 12,
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
