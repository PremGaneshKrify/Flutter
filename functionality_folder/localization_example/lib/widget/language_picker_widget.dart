// import 'package:flutter/material.dart';
// import 'package:localization_example/l10n/l10n.dart';
// import 'package:provider/provider.dart';

// import '../provider/locale_provider.dart';

// class LanguageWidget extends StatelessWidget {
//   const LanguageWidget({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final locale = Localizations.localeOf(context);
//     final flag = L10n.getFlag(locale.languageCode);

//     return Center(
//       child: Text(
//         flag!,
//         style: const TextStyle(fontSize: 60),
//       ),
//     );
//   }
// }

// class LanguagePickerWidget extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final provider = Provider.of<LocaleProvider>(context);
//     final locale = provider.locale ?? const Locale('en');

//     return DropdownButtonHideUnderline(
//       child: DropdownButton(
//         value: locale,
//         icon: Container(width: 12),
//         items: L10n.all.map(
//           (locale) {
//             final flag = L10n.getFlag(locale.languageCode);

//             return DropdownMenuItem(
//               value: locale,
//               onTap: () {
//                 final provider =
//                     Provider.of<LocaleProvider>(context, listen: false);

//                 provider.setLocale(locale);
//               },
//               child: Center(
//                 child: Text(
//                   flag!,
//                   style: const TextStyle(fontSize: 32),
//                 ),
//               ),
//             );
//           },
//         ).toList(),
//         onChanged: (_) {},
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../l10n/l10n.dart';
import '../provider/locale_provider.dart';

class LanguageWidget extends StatelessWidget {
  const LanguageWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final locale = Localizations.localeOf(context);
    final flag = L10n.getFlag(locale.languageCode);

    return Center(
      child: Text(
        flag!,
        style: const TextStyle(fontSize: 80),
      ),
    );
  }
}

class LanguagePickerWidget extends StatelessWidget {
  const LanguagePickerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<LocaleProvider>(context);
    final locale = provider.locale ?? const Locale('en');

    return DropdownButtonHideUnderline(
      child: DropdownButton(
        value: locale,
        icon: Container(width: 12),
        items: L10n.all.map(
          (locale) {
            final flag = L10n.getFlag(locale.languageCode);

            return DropdownMenuItem(
              value: locale,
              onTap: () {
                final provider =
                    Provider.of<LocaleProvider>(context, listen: false);

                provider.setLocale(locale);
              },
              child: Center(
                child: Text(
                  flag!,
                  style: const TextStyle(fontSize: 32),
                ),
              ),
            );
          },
        ).toList(),
        onChanged: (_) {},
      ),
    );
  }
}
