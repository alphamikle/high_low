import 'package:flutter/cupertino.dart';
import 'package:yalo_locale/lib.dart';

class LocalizationWrapper {
  LocalizationWrapper({
    required BuildContext context,
  }) : _context = context;

  final BuildContext _context;

  LocalizationMessages get loc => Messages.of(_context);
}
