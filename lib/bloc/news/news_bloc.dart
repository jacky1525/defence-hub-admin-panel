import 'package:bloc/bloc.dart';
import 'package:defence_hub_admin_panel/features/authentication/data/auth_repository.dart';
import 'package:defence_hub_admin_panel/models/news_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
part 'news_event.dart';
part 'news_state.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  final AuthRepository authRepository;

  NewsBloc(this.authRepository)
      : super(const NewsState(newsList: <NewsModel>[])) {
    on<FetchNewsEvent>(_getNews);
  }

  Future<void> _getNews(FetchNewsEvent event, Emitter<NewsState> emit) async {
    final newsStream = authRepository.getNews();
    
    await emit.forEach<List<NewsModel>>(
      newsStream,
      onData: (newsList) {
        return NewsState(newsList: newsList);
      },
      onError: (error, stackTrace) {
        debugPrint("Error fetching news: $error");
        return state;
      },
    );
  }

  Future<void> _getSelectedNews(FetchNewsEvent event, Emitter<NewsState> emit) async {
    
  }

}