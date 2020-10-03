import 'package:arch_sample/core/view_state.dart';
import 'package:arch_sample/environments/app_config.dart';
import 'package:arch_sample/pages/home/presentation/home_cubit.dart';
import 'package:arch_sample/pages/home/presentation/home_view_state.dart';
import 'package:flutter/material.dart';
import 'package:cubit/cubit.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final appConfig = AppConfig.of(context);

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(appConfig.appName),
      ),
      body: CubitConsumer<HomeCubit, HomeViewState>(
        builder: (context, state) {
          switch (state.state) {
            case ViewState.LOADING:
              return const Center(child: CircularProgressIndicator());
              break;
            default:
              return Container(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    state.hasData
                        ? Text('Hello ${state.sampleData.fullName}')
                        : const SizedBox.shrink(),
                    FlatButton(
                      color: Theme.of(context).accentColor,
                      onPressed: () {
                        context.cubit<HomeCubit>().getSampleData();
                      },
                      child: const Text(
                        'Get Sample Data',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    )
                  ],
                ),
              );
              break;
          }
        },
        listenWhen: (p, n) => n.state == ViewState.ERROR,
        listener: (_, state) {
          _scaffoldKey.currentState.showSnackBar(
            const SnackBar(
              content: Text('Whoosh!!... Something is wrong!'),
            ),
          );
        },
      ),
    );
  }
}
