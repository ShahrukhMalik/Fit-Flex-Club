import 'package:drift/drift.dart';
import 'package:fit_flex_club/src/core/db/fit_flex_local_db.dart';
import 'package:fit_flex_club/src/features/broadcast/data/datasources/local/tables/announcements_table.dart';
import 'package:fit_flex_club/src/features/broadcast/data/datasources/local/tables/comments_table.dart';
import 'package:fit_flex_club/src/features/broadcast/data/datasources/local/tables/reactions_table.dart';
import 'package:injectable/injectable.dart';
part 'broadcast_dao.g.dart';

@injectable
@DriftAccessor(tables: [Announcements, Comments, Reactions])
class BroadcastDao extends DatabaseAccessor<AppDatabase>
    with _$BroadcastDaoMixin {
  BroadcastDao(super.db);

  // Create a new announcement
  Future<void> createAnnouncement(Insertable<Announcement> announcement) async {
    await into(announcements).insert(announcement);
  }

  Future<void> batchInsertAnnouncements(
      List<Insertable<Announcement>> announcementsList) async {
    await batch((batch) {
      batch.insertAll(
        announcements,
        announcementsList,
        mode: InsertMode.insertOrReplace,
      );
    });
  }

  // Delete an announcement and its related comments and reactions
  Future<void> deleteAnnouncement(String announcementId) async {
    await (delete(reactions)
          ..where((tbl) => tbl.announcementId.equals(announcementId)))
        .go();
    await (delete(comments)
          ..where((tbl) => tbl.announcementId.equals(announcementId)))
        .go();
    await (delete(announcements)..where((tbl) => tbl.id.equals(announcementId)))
        .go();
  }

  // Edit an existing announcement
  Future<void> editAnnouncement(Insertable<Announcement> announcement) async {
    await update(announcements).replace(announcement);
  }

  Stream<List<Announcement>> watchAnnouncements() {
    return (select(announcements)
          ..orderBy([
            (t) =>
                OrderingTerm(expression: t.createdAt, mode: OrderingMode.desc)
          ]))
        .watch();
  }

  // Add a comment to an announcement
  Future<void> addComment(Insertable<Comment> comment) async {
    await into(comments).insert(
      comment,
      mode: InsertMode.insertOrReplace,
    );
  }

  Future<void> batchInsertComments(
      List<Insertable<Comment>> commentsList) async {
    await batch((batch) {
      batch.insertAll(
        comments,
        commentsList,
        mode: InsertMode.insertOrReplace,
      );
    });
  }

  // Update a comment
  Future<void> updateComment(Insertable<Comment> comment) async {
    await update(comments).replace(comment);
  }

  // Add a reaction to an announcement
  Future<void> addReaction(Insertable<Reaction> reaction) async {
    await into(reactions).insert(
      reaction,
      mode: InsertMode.insertOrReplace,
    );
  }

  Future<void> batchInsertReactions(
      List<Insertable<Reaction>> reactionsList) async {
    await batch((batch) {
      batch.insertAll(
        reactions,
        reactionsList,
        mode: InsertMode.insertOrReplace,
      );
    });
  }

  // Update a reaction
  Future<void> updateReaction(Insertable<Reaction> reaction) async {
    await update(reactions).replace(reaction);
  }

  // Optionally: Get all comments or reactions for a specific announcement
  Stream<List<Comment>> watchCommentsForAnnouncement(String announcementId) {
    return (select(comments)
          ..where((tbl) => tbl.announcementId.equals(announcementId)))
        .watch();
  }

  Future<List<Reaction>> watchReactionsForAnnouncement(String announcementId) {
    return (select(reactions)
          ..where((tbl) => tbl.announcementId.equals(announcementId)))
        .get();
  }
}
