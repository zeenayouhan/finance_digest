import 'package:json_annotation/json_annotation.dart';

part 'news_item.g.dart';

@JsonSerializable(explicitToJson: true)
class NewsItem {
  NewsItem({
    required this.category,
    required this.datetime,
    required this.headline,
    required this.id,
    required this.image,
    required this.related,
    required this.source,
    required this.summary,
    required this.url,
  });

  @JsonKey(name: 'category')
  final String category;

  @JsonKey(name: 'datetime')
  final int datetime;

  @JsonKey(name: 'headline')
  final String headline;

  @JsonKey(name: 'id')
  final int id;

  @JsonKey(name: 'image')
  final String image;

  @JsonKey(name: 'related')
  final String related;

  @JsonKey(name: 'source')
  final String source;

  @JsonKey(name: 'summary')
  final String summary;

  @JsonKey(name: 'url')
  final String url;

  // Factory constructor to generate a `NewsItem` from a JSON map
  factory NewsItem.fromJson(Map<String, dynamic> json) =>
      _$NewsItemFromJson(json);

  // Method to convert a `NewsItem` instance to a JSON map
  Map<String, dynamic> toJson() => _$NewsItemToJson(this);
}
