import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kkw_blog/src/dependency_injection.dart';
import 'package:kkw_blog/src/domain/models/classification_type.dart';
import 'package:kkw_blog/src/domain/models/post.dart';
import 'package:kkw_blog/src/domain/repositories/supabase_stroage_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'main_notifier.freezed.dart';
part 'main_notifier.g.dart';

@riverpod
class MainNotifier extends _$MainNotifier {
  late final SupabaseStorageRepository _supabaseStorageRepository;

  @override
  MainNotifierState build() {
    _supabaseStorageRepository = instance<SupabaseStorageRepository>();

    return MainNotifierState.empty();
  }

  void update(ClassificationType type) => state = state.copyWith(type: type);
}

@freezed
class MainNotifierState with _$MainNotifierState {
  MainNotifierState._();

  const factory MainNotifierState({
    required ClassificationType type,
    required List<Post> posts,
  }) = _MainNotifierState;

  factory MainNotifierState.empty() => const MainNotifierState(
        type: AllType(0),
        posts: [],
      );
}
