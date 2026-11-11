import '../../domain/entities/help_page.dart';
import '../../domain/repositories/help_center_repository.dart';
import '../datasources/help_center_remote_data_source.dart';

class HelpCenterRepositoryImpl implements HelpCenterRepository {
  HelpCenterRepositoryImpl(this._remote);

  final HelpCenterRemoteDataSource _remote;

  @override
  Future<List<HelpPage>> pages() => _remote.pages();

  @override
  Future<HelpPage> page(String slug) => _remote.page(slug);
}
