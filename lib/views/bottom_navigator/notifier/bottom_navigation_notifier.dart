import 'package:pickle_ball/views/bottom_navigator/state/bottom_navigation_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'bottom_navigation_notifier.g.dart';

@riverpod
class BottomNavigationNotifier extends _$BottomNavigationNotifier {
  @override
  BottomNavigationState build() =>  const BottomNavigationState();

  void setCurrentIndex(int index) {
    state = state.copyWith(currentIndex: index);
  }
}
