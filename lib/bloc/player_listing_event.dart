import 'package:bloc_pattern/model/nations.dart';
import 'package:flutter/material.dart';

abstract class PlayerListingEvent{}

class CountrySelectedEvent extends PlayerListingEvent{
  final NationModel nationModel;
  CountrySelectedEvent({@required this.nationModel}) : assert(nationModel!=null);
}
class SearchTextChangedEvent extends PlayerListingEvent {
  final String searchTerm;
  SearchTextChangedEvent({@required this.searchTerm}) : assert(searchTerm != null);
}