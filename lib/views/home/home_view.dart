import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pickle_ball/views/home/widgets/body_home_widget.dart';
import 'package:pickle_ball/views/home/widgets/footer_home_widget.dart';

import 'widgets/header_home_widget.dart';

class HomeView extends ConsumerWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HeaderHomeWidget(),
            BodyHomeWidget(),
            FooterHomeWidget(),
          ],
        ),
      ),
    );
  }
}
