// import 'package:get_it/get_it.dart';
// import 'package:mehna_tech_project/home/data/datasource/home_remote_data_source.dart';
// import 'package:mehna_tech_project/home/data/repository/home_repository.dart';
// import 'package:mehna_tech_project/home/domain/repository/base_home_repository.dart';
// import 'package:mehna_tech_project/home/domain/useCases/get_categories.dart';
// import 'package:mehna_tech_project/home/domain/useCases/get_home_posts.dart';
// import 'package:mehna_tech_project/home/domain/useCases/get_promote_posts.dart';
// import 'package:mehna_tech_project/home/presentation/controller/home_bloc.dart';
//
// final sl=GetIt.instance;
//
// class ServicesLocator {
//   void init(){
//     ///bloc
//    // sl.registerFactory(() => HomeCubit();
//     ///useCases
//     sl.registerLazySingleton(() => GetHomePostsUseCase(sl()));
//     sl.registerLazySingleton(() => GetPromotePostsUseCase(sl()));
//     sl.registerLazySingleton(() => GetCategoriesUseCase(sl()));
//     ///Repository
//     sl.registerLazySingleton<BaseHomeRepository>(
//             () => HomeRepository(sl()));
//     ///data Source
//     sl.registerLazySingleton<BaseHomeRemoteDataSource>(
//             () => HomeRemoteDataSource());
//   }
// }
//
