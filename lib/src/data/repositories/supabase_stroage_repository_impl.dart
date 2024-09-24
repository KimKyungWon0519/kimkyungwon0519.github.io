import 'package:flutter/foundation.dart';
import 'package:kkw_blog/src/data/data_sources/supabase_database_service.dart';
import 'package:kkw_blog/src/data/data_sources/supabase_storage_service.dart';
import 'package:kkw_blog/src/data/entities/posts_table_entity.dart';
import 'package:kkw_blog/src/domain/repositories/supabase_stroage_repository.dart';

class SupabaseStorageRepositoryImpl implements SupabaseStorageRepository {
  late final SupabaseDatabaseService _databaseService;
  late final SupabaseStorageService _storageService;

  SupabaseStorageRepositoryImpl({
    required SupabaseDatabaseService databaseService,
    required SupabaseStorageService stroageService,
  })  : _databaseService = databaseService,
        _storageService = stroageService;

  @override
  Future<void> getAllPostFiles() async {
    List<PostsTableEntity> postsTableData = await _databaseService
        .getAllPosts()
        .then((value) =>
            value.map((data) => PostsTableEntity.fromJson(data)).toList());

    Iterable<Future<String>> downloadComputes = postsTableData.map((data) =>
        compute(_downloadFile, {
          'service': _storageService,
          'path': '${data.path}/${data.fileName}'
        }));

    List<String> files = await Future.wait(downloadComputes);

    print(files);
  }

  static Future<String> _downloadFile(Map<String, dynamic> arg) {
    return (arg['service'] as SupabaseStorageService)
        .downloadFile(path: arg['path']);
  }
}
