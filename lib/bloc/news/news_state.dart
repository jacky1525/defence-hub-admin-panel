part of 'news_bloc.dart';

class NewsState extends Equatable {
  final List<NewsModel> newsList;

  const NewsState({List<NewsModel>? newsList})
      : newsList = newsList ?? const <NewsModel>[];

  @override
  List<Object?> get props => <Object?>[newsList];

  NewsState copyWith({List<NewsModel>? newsList}) {
    return NewsState(newsList: newsList ?? this.newsList);
  }
}
