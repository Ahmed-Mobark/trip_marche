import '../entities/help_page.dart';

abstract class HelpCenterRepository {
  Future<List<HelpPage>> pages();
  Future<HelpPage> page(String slug);
}
