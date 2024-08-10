import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:suitmedia/features/second_screen/provider/user_name_provider.dart';
import 'package:suitmedia/helpers/widgets/custom_appbar.dart';
import 'package:suitmedia/features/third_screen/providers/user_provider.dart';

class ThirdScreen extends StatefulWidget {
  const ThirdScreen({super.key});

  @override
  _ThirdScreenState createState() => _ThirdScreenState();
}

class _ThirdScreenState extends State<ThirdScreen> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
    _fetchUsers();
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _fetchUsers({bool loadMore = false}) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    await userProvider.getUserData(loadMore: loadMore);
  }

  void _onScroll() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      _fetchUsers(loadMore: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);

    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Third Screen',
      ),
      body: RefreshIndicator(
        onRefresh: () => _fetchUsers(),
        child: userProvider.loading && userProvider.users.isEmpty
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : userProvider.users.isEmpty
                ? const Center(
                    child: Text('Data Kosong'),
                  )
                : Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 10.0),
                    child: ListView.builder(
                      controller: _scrollController,
                      itemCount: userProvider.users.length +
                          (userProvider.hasMore ? 1 : 0),
                      itemBuilder: (context, index) {
                        if (index >= userProvider.users.length) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        final user = userProvider.users[index];
                        return Column(
                          children: [
                            ListTile(
                              leading: CircleAvatar(
                                radius: 29,
                                backgroundImage:
                                    NetworkImage(user.avatar ?? ''),
                              ),
                              title: Text('${user.firstName} ${user.lastName}'),
                              subtitle: Text(user.email ?? ''),
                              onTap: () {
                                Provider.of<UserNameProvider>(context,
                                        listen: false)
                                    .setSelectedUserName(
                                        '${user.firstName} ${user.lastName}');
                                context.pop();
                              },
                            ),
                            const Divider(
                              thickness: BorderSide.strokeAlignCenter,
                            ),
                          ],
                        );
                      },
                    ),
                  ),
      ),
    );
  }
}
