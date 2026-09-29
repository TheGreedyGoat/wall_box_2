import 'package:wall_box_2/data/database/repository.dart';
import 'package:wall_box_2/data/database/tables/incomplete_blocks_table.dart';
import 'package:wall_box_2/logic/models/logs/wall_box_transaction_block/wall_box_transaction_block.dart';

/// Repository for log- transaction blocks that are spit between log files
class IncompleteBlocksRepo extends Repository<WallBoxTransactionBlock> {
  /// Repository for log- transaction blocks that are spit between log files
  IncompleteBlocksRepo()
    : super(
        primaryKeyColumns: [
          IncompleteBlocksColumns.source,
        ],
        // No UI will probably care about this
        onchanged: () {},
      );

  @override
  TransactionBlockJsonConverter get converter =>
      TransactionBlockJsonConverter();

  @override
  String get tableName => IncompleteBlocksTable.tableName;

  /// Searches for matching ta-block parts in the database
  ///
  /// If a part is found, they get merged and the saved part is deleted.
  ///
  /// If the passed block is still incomplete at the end, it gets saved to the database
  Future<WallBoxTransactionBlock> findMergables(
    WallBoxTransactionBlock block,
  ) async {
    if (block.isCompleted) return block;
    final sameDevice =
        (await query(
              where:
                  '''
                ${IncompleteBlocksColumns.device_id} = ?
              ''',
              whereArgs: [block.deviceID],
            ))
            .map(
              (json) => converter.fromJson(json),
            )
            .toList();
    if (block.start == null) {
      // filter for tagID
      // In the rare case of a pure mv file there is no tag id, wich reaaally sucks
      final matchingTag = block.tagID != null
          ? sameDevice.where(
              (dbBlock) {
                // has no stop                  // has no or matching tagID
                return dbBlock.stop == null &&
                    (dbBlock.tagID == null || dbBlock.tagID == block.tagID);
              },
            )
          : sameDevice;
      final matchingDate = matchingTag.where(
        (dbBlock) {
          try {
            return dbBlock.lastDate.difference(block.firstDate) <=
                Duration(minutes: 16);
          } catch (e) {
            // print(dbBlock.mvLines);
            // print('line 61');
            return false;
          }
        },
      ).toList();
      if (matchingDate.length == 1) {
        final foundMatch = matchingDate[0];
        // merge those mofos

        block = WallBoxTransactionBlock(
          start: foundMatch.start,
          mvLines: [...foundMatch.mvLines, ...block.mvLines],
          deviceID: block.deviceID,
          stop: block.stop,
        );
        await deleteByPrimaries(foundMatch);
      }
      if (block.stop == null) {
        // filter for tagID
        // In the rare case of a pure mv file there is no tag id, wich reaaally sucks
        final matchingTag = block.tagID != null
            ? sameDevice.where(
                (dbBlock) {
                  // has no stop                  // has no or matching tagID
                  return dbBlock.start == null &&
                      (dbBlock.tagID == null || dbBlock.tagID == block.tagID);
                },
              )
            : sameDevice;

        final matchingDate = matchingTag.where(
          (dbBlock) {
            try {
              return block.lastDate.difference(dbBlock.firstDate) <=
                  Duration(minutes: 16);
            } catch (_) {
              print('line 98');
              return false;
            }
          },
        ).toList();
        if (matchingDate.length == 1) {
          final foundMatch = matchingDate[0];
          // merge those mofos

          block = WallBoxTransactionBlock(
            start: block.start,
            mvLines: [...block.mvLines, ...foundMatch.mvLines],
            deviceID: block.deviceID,
            stop: foundMatch.stop,
          );

          await deleteByPrimaries(foundMatch);
        }
      }
    }
    if (!block.isCompleted) {
      await insert(block);
    }
    return block;
  }
}
