import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../Repository.dart';
import '../data.dart';

part 'bloc_home_event.dart';
part 'bloc_home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  Repository<Task> repository;
  HomeBloc({required this.repository}) : super(HomeInitial()) {
    on<HomeEvent>((event, emit) async {
      if(event is HomeStarted || event is HomeSearch){
        var searchTerm = '';
        if(event is HomeSearch){
          searchTerm = event.searchKey;
        }
        emit(HomeLoading());
        var res= await repository.getAllData(searchTerm);
        emit(HomeDataSuccess(data: res));
      };
      if(event is HomeDeleteAll){
        await repository.deleteAll();
        emit(HomeEmptyState());
      }


    });
  }
}
