import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tp_bloc_al1_remi_m/post_detail_screen/post_detail_screen.dart';
import 'package:tp_bloc_al1_remi_m/posts_screen/posts_screen.dart';
import 'package:tp_bloc_al1_remi_m/shared/blocs/posts_bloc/posts_bloc.dart';
import 'package:tp_bloc_al1_remi_m/shared/models/post.dart';
import 'package:tp_bloc_al1_remi_m/shared/services/local_posts_data_source/fake_local_products_data_source.dart';
import 'package:tp_bloc_al1_remi_m/shared/services/posts_data_source/fake_posts_data_source.dart';
import 'package:tp_bloc_al1_remi_m/shared/services/posts_repository/posts_repository.dart';



void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => PostsRepository(
        remoteDataSource: FakePostsDataSource(),
        localProductsDataSource: FakeLocalPostsDataSource(),
      ),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => PostsBloc(
              postsRepository: context.read<PostsRepository>(),
            ),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          routes: {
            '/': (context) => const PostsScreen(),
          },
          onGenerateRoute: (routeSettings) {
            Widget screen = Container(color: Colors.pink);
            final argument = routeSettings.arguments;
            switch (routeSettings.name) {
              case 'postDetail':
                if (argument is Post) {
                  screen = PostDetailScreen(post: argument);
                }
                break;
            }

            return MaterialPageRoute(builder: (context) => screen);
          },
        ),
      ),
    );
  }
}
