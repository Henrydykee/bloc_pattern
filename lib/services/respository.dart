

import 'package:bloc_pattern/model/model.dart';
import 'package:bloc_pattern/services/player_api_provider.dart';

class PlayerRepository {
  PlayerApiProvider _playerApiProvider = PlayerApiProvider();

  Future<List<Players>>fetchPlayersByCountry(String countryId) => _playerApiProvider.fetchPlayersByCountry(countryId);
  Future<List<Players>>fetchPlayersByName(String name) => _playerApiProvider.fetchPlayersByName(name);
}