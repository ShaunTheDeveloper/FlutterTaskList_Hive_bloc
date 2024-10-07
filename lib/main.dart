import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'package:tamrin/HiveDatabase.dart';
import 'package:tamrin/LocalDatabase.dart';
import 'package:tamrin/RepositoryImpl.dart';
import 'package:tamrin/data.dart';
import 'package:tamrin/home/bloc_home_bloc.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(TaskAdapter());

  await Hive.openBox<Task>(HiveDatabase.boxName);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: ChangeNotifierProvider<RepositoryImpl>(
          create: (context) => RepositoryImpl(
              localDatabase: HiveDatabase(box: Hive.box(HiveDatabase.boxName))),
          child: BlocProvider<HomeBloc>(
            create: (context) =>
                HomeBloc(repository: context.read<RepositoryImpl>()),
            child: MainScreen(),
          )),
    );
  }
}

class MainScreen extends StatefulWidget {
  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: Text("My App"),
            actions: [Icon(Icons.delete)],
          ),
          body: Column(
            children: [
              TextField(
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "Search Item",
                ),
                onChanged: (searchTerm) {
                  context
                      .read<HomeBloc>()
                      .add(HomeSearch(searchKey: searchTerm));
                },
              ),
              Expanded(child:
                  Consumer<RepositoryImpl>(builder: (context, repo, child) {
                context.read<HomeBloc>().add(HomeStarted());
                return BlocBuilder<HomeBloc, HomeState>(
                  builder: (context, state) {
                    if (state is HomeLoading || state is HomeInitial) {
                      return LoadingScreen();
                    } else if (state is HomeDataSuccess) {
                      return HomeDataScreen(tasks: state.data);
                    } else if (state is HomeEmptyState) {
                      return HomeEmptyScreen();
                    } else if (state is HomeError) {
                      return Text(state.message);
                    } else {
                      throw Exception("");
                    }
                  },
                );
              }))
            ],
          )),
    );
  }
}

class HomeEmptyScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('The box is Empty'),
    );
  }
}

class HomeDataScreen extends StatelessWidget {
  List<Task> tasks;

  HomeDataScreen({super.key, required this.tasks});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: tasks.length,
      itemBuilder: (context, index) {
        return Text(tasks[index].content);
      },
    );
  }
}

class LoadingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}
