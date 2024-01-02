import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Localization"),
      ),
      body: Center(
        child: Column(
          children: [
            Text(
              'welcome'.tr(),
              style: TextStyle(fontSize: 25),
            ),
            ElevatedButton(
              onPressed: () {
                EasyLocalization.of(context)!.currentLocale == Locale('ar')
                    ? EasyLocalization.of(context)!.setLocale(Locale('en'))
                    : EasyLocalization.of(context)!.setLocale(Locale('ar'));
              },
              child: Text(
                "changeLang".tr(),
              ),
            )
          ],
        ),
      ),
    );
  }
}
