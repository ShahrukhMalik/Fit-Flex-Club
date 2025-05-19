import 'package:fit_flex_club/src/features/broadcast/domain/entities/comment_entity.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class CommentsSheet extends StatelessWidget {
  final List<Comment> comments;
  final TextEditingController _commentController = TextEditingController();
  final void Function(String content) onSend;

  CommentsSheet({
    super.key,
    required this.comments,
    required this.onSend,
  });

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    return Padding(
      padding: mediaQuery.viewInsets,
      child: Container(
        height: mediaQuery.size.height * 0.75,
        padding: const EdgeInsets.all(16),
        margin: EdgeInsets.only(bottom: 100),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: IconButton.filled(
                onPressed: context.pop,
                icon: Icon(
                  Icons.close,
                ),
              ),
            ),
            // List of comments
            Expanded(
              child: comments.isEmpty
                  ? Center(child: Text("No comments yet."))
                  : ListView.builder(
                      itemCount: comments.length,
                      itemBuilder: (context, index) {
                        final comment = comments[index];
                        return ListTile(
                          leading: CircleAvatar(
                            child: Text(comment.userName[0].toUpperCase()),
                          ),
                          title: Text(
                            comment.userName,
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(comment.content),
                              const SizedBox(height: 4),
                              Text(
                                DateFormat('hh:mm a • MMM dd')
                                    .format(comment.timestamp),
                                style:
                                    TextStyle(fontSize: 12, color: Colors.grey),
                              ),
                            ],
                          ),
                          contentPadding:
                              const EdgeInsets.symmetric(vertical: 8),
                        );
                      },
                    ),
            ),
            // const SizedBox(height: 16),
            // TextField to add comment
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _commentController,
                    onSubmitted: (value) {
                      final content = _commentController.text.trim();
                      if (content.isNotEmpty) {
                        onSend(content);
                        _commentController.clear();
                      }
                    },
                    decoration: InputDecoration(
                      hintText: 'Add a comment...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 12),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () {
                    final content = _commentController.text.trim();
                    if (content.isNotEmpty) {
                      onSend(content);
                      _commentController.clear();
                    }
                  },
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
