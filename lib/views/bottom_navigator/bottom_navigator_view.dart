import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pickle_ball/utils/assets_utils.dart';
import 'package:pickle_ball/utils/color_utils.dart';
import 'package:pickle_ball/views/bottom_navigator/notifier/bottom_navigation_notifier.dart';
import 'package:pickle_ball/views/find_tournament/find_tournament_view.dart';
import 'package:pickle_ball/views/home/home_view.dart';
import 'package:pickle_ball/views/news/news_view.dart';
import 'package:pickle_ball/views/profile/profile_view.dart';
import '../../common/base_state_delegate/base_state_delegate.dart';

class BottomNavigationView extends ConsumerStatefulWidget {
  const BottomNavigationView({super.key});

  @override
  BaseStateDelegate<BottomNavigationView, BottomNavigationNotifier>
      createState() => _BottomNavigationViewState();
}

class _BottomNavigationViewState
    extends BaseStateDelegate<BottomNavigationView, BottomNavigationNotifier> {
  final PageController _pageController = PageController(initialPage: 0);

  @override
  void initNotifier() {
    notifier = ref.read(bottomNavigationNotifierProvider.notifier);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Consumer(
          builder: (context, ref, child) {
            ref.watch(
              bottomNavigationNotifierProvider.select(
                (value) => value.currentIndex,
              ),
            );
            return PageView(
              physics: const NeverScrollableScrollPhysics(),
              controller: _pageController,
              children: const [
                HomeView(),
                // CreateTournamentView(),
                NewsView(),
                FindTournamentView(),
                ProfileView(),
              ],
            );
          },
        ),
      ),
      bottomNavigationBar: Container(
        color: ColorUtils.primaryBackgroundColor,
        child: BottomAppBar(
          clipBehavior: Clip.antiAliasWithSaveLayer,
          padding: const EdgeInsets.all(0),
          shape: AutomaticNotchedShape(
            const RoundedRectangleBorder(),
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
          ),
          child: Consumer(
            builder: (context, ref, child) {
              final index = ref.watch(
                bottomNavigationNotifierProvider.select(
                  (value) => value.currentIndex,
                ),
              );
              return BottomNavigationBar(
                items: <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                    icon: SvgPicture.asset(
                      AssetUtils.home,
                      colorFilter: ColorFilter.mode(
                        ColorUtils.primaryColor,
                        BlendMode.srcIn,
                      ),
                    ),
                    activeIcon: SvgPicture.asset(
                      AssetUtils.homeActive,
                      colorFilter: ColorFilter.mode(
                        ColorUtils.primaryColor,
                        BlendMode.srcIn,
                      ),
                    ),
                    label: "home",
                  ),
                  // BottomNavigationBarItem(
                  //   icon: SvgPicture.asset(
                  //     AssetUtils.create,
                  //     colorFilter: ColorFilter.mode(
                  //       ColorUtils.primaryColor,
                  //       BlendMode.srcIn,
                  //     ),
                  //   ),
                  //   activeIcon: SvgPicture.asset(
                  //     AssetUtils.createActive,
                  //     colorFilter: ColorFilter.mode(
                  //       ColorUtils.primaryColor,
                  //       BlendMode.srcIn,
                  //     ),
                  //   ),
                  //   label: "Create",
                  // ),
                  BottomNavigationBarItem(
                    icon: SvgPicture.asset(
                      AssetUtils.news,
                      colorFilter: ColorFilter.mode(
                        ColorUtils.primaryColor,
                        BlendMode.srcIn,
                      ),
                    ),
                    activeIcon: SvgPicture.asset(
                      AssetUtils.newsActive,
                      colorFilter: ColorFilter.mode(
                        ColorUtils.primaryColor,
                        BlendMode.srcIn,
                      ),
                    ),
                    label: "news",
                  ),
                  BottomNavigationBarItem(
                    icon: SvgPicture.asset(
                      AssetUtils.search,
                      colorFilter: ColorFilter.mode(
                        ColorUtils.primaryColor,
                        BlendMode.srcIn,
                      ),
                    ),
                    activeIcon: SvgPicture.asset(
                      AssetUtils.searchActive,
                      colorFilter: ColorFilter.mode(
                        ColorUtils.primaryColor,
                        BlendMode.srcIn,
                      ),
                    ),
                    label: "Search",
                  ),
                  BottomNavigationBarItem(
                    icon: SvgPicture.asset(
                      AssetUtils.profile,
                      colorFilter: ColorFilter.mode(
                        ColorUtils.primaryColor,
                        BlendMode.srcIn,
                      ),
                    ),
                    activeIcon: SvgPicture.asset(
                      AssetUtils.profileActive,
                      colorFilter: ColorFilter.mode(
                        ColorUtils.primaryColor,
                        BlendMode.srcIn,
                      ),
                    ),
                    label: "profile",
                  ),
                ],
                backgroundColor: ColorUtils.whiteColor,
                selectedItemColor: ColorUtils.primaryColor,
                unselectedItemColor: ColorUtils.primaryColor,
                showSelectedLabels: false,
                showUnselectedLabels: false,
                currentIndex: index,
                type: BottomNavigationBarType.fixed,
                onTap: (value) => {
                  _pageController.jumpToPage(value),
                  notifier.setCurrentIndex(value),
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
