import 'package:flutter/material.dart';
import 'package:states_rebuilder/states_rebuilder.dart';
import 'package:totem_rank_demo/models/entities/User.dart';
import 'package:totem_rank_demo/services/UserService.dart';
import 'package:totem_rank_demo/views/screens/create.dart';
import 'package:totem_rank_demo/views/screens/rank.dart';
import 'package:totem_rank_demo/views/ui/rank_card.dart';
import 'package:totem_rank_demo/utils/extensions.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void _createNew() async {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CreatePage()),
    );
  }

  void onCardPress(rank) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => RankPage(ranksId: [rank.id])),
    );
  }

  void onMoreSamePress(rank) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => RankPage(ranksId: [1, 2, 3])), // TODO cut trick
    );
  }

  Widget buildContent(user) {
    return ListView(
      children: <Widget>[
        SizedBox(height: 20),
        ListTile(
          leading: CircleAvatar(
            minRadius: 40,
            maxRadius: 40,
          ),
          title: Text(user.name),
          subtitle: Text('${user.ranks.length} ranks'),
        ),
        Divider(
          height: 40,
          thickness: 3.0,
          color: Colors.grey[200],
        ),
        Column(
          children: user.ranks
              .map<Widget>((e) => RankCard(
                    key: Key(e.id.toString()),
                    rank: e,
                    isPreview: true,
                    onPress: () => onCardPress(e),
                    onMorePress: () => onMoreSamePress(e),
                  ))
              .toList(),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return StateBuilder<UserService>(
        initState: (context, model) => model.setState((s) => s.loadUserData()),
        observe: () => RM.get<UserService>(),
        builder: (_, userService) {
          if (userService.state.user == null) {
            return Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }
          return Scaffold(
            appBar: AppBar(
              title:
                  Text('${userService.state.user?.name?.capitalize()}`s ranks'),
            ),
            body: buildContent(userService.state.user),
            floatingActionButton: FloatingActionButton(
              onPressed: _createNew,
              tooltip: 'Create',
              child: Icon(Icons.add),
            ),
          );
        });
  }
}
