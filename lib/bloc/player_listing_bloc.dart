

import 'package:bloc_pattern/bloc/player_listing_event.dart';
import 'package:bloc_pattern/bloc/player_listing_state.dart';
import 'package:bloc_pattern/model/model.dart';
import 'package:bloc_pattern/services/respository.dart';
import 'package:rxdart/rxdart.dart';

import 'dart:async';
import 'package:bloc/bloc.dart';

class PlayerListingBloc extends Bloc<PlayerListingEvent, PlayerListingState> {
  final PlayerRepository playerRepository;
  PlayerListingBloc({this.playerRepository}) : assert(playerRepository != null);

  @override Stream<PlayerListingState> transformEvents(Stream<PlayerListingEvent> events, Stream<PlayerListingState> Function(PlayerListingEvent event) next) {
    // TODO: implement transformEvents
    return super.transformEvents(
      (events as Observable<PlayerListingEvent>).debounce(
              (_) => TimerStream(true, const Duration(seconds: 3)))
      ,next,
    );
  }

  @override
  void onTransition(Transition<PlayerListingEvent, PlayerListingState> transition) {
    super.onTransition(transition);
    print(transition);
  }
  @override
  PlayerListingState get initialState => PlayerUninitializedState();

  @override
  Stream<PlayerListingState> mapEventToState(PlayerListingEvent event) async* {
    yield PlayerFetchingState();
    List<Players> players;
    try {
      if (event is CountrySelectedEvent) {
        players = await playerRepository
            .fetchPlayersByCountry(event.nationModel.countryId);
      } else if (event is SearchTextChangedEvent) {
        print("Hitting service");
        players = await playerRepository.fetchPlayersByName(event.searchTerm);
      }
      if (players.length == 0) {
        yield PlayerEmptyState();
      } else {
        yield PlayerFetchedState(players: players);
      }
    } catch (_) {
      yield PlayerErrorState();
    }
  }
}