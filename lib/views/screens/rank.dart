import 'package:flutter/material.dart';
import 'package:states_rebuilder/states_rebuilder.dart';
import 'package:totem_rank_demo/services/UserService.dart';
import 'package:totem_rank_demo/models/entities/Rank.dart';
import 'package:totem_rank_demo/views/screens/create.dart';
import 'package:totem_rank_demo/views/ui/rank_card.dart';

class RankPage extends StatefulWidget {
  RankPage({Key key, this.ranksId = const []}) : super(key: key);
  final List<int> ranksId;

  @override
  _RankPageState createState() => _RankPageState();
}

class _RankPageState extends State<RankPage> {
  bool isOwnCard;
  List<Rank> ranks = [];

  @override
  void initState() {
    super.initState();
    isOwnCard = widget.ranksId.length == 1;
  }

  Widget getCard(rank) {
    return Container(
      padding: EdgeInsets.all(30),
      height: 100,
      constraints: BoxConstraints.loose(Size(100, 100)),
      child: RankCard(
        key: Key(rank.id.toString()),
        rank: rank,
      ),
    );
  }

  String getPageName() {
    if (ranks.length == 0) return '';
    final title =
        ranks.length == 1 ? ranks[0]?.name : '"${ranks[0]?.name}" lists';
    return title;
  }

  void onEdit(rank) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CreatePage(rank: rank)),
    );
  }

  void onDelete(userService, rank) async {
    await showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Do you want to delete this rank?'),
          content: const Text('You couldn`t undo this action'),
          actions: <Widget>[
            FlatButton(
              child: Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.pop(context);
                userService.setState((s) => s.deleteRank(rank));
              },
            ),
            FlatButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
    //
  }

  @override
  Widget build(BuildContext context) {
    return StateBuilder<UserService>(
        observe: () => RM.get<UserService>(),
        builder: (_, userService) {
          // TODO cut trick
          if (widget.ranksId.length > 1) {
            ranks = userService.state.user.ranks;
          } else {
            ranks = userService.state.user.ranks
                .where((element) => widget.ranksId.contains(element.id))
                .toList();
          }
          return Scaffold(
              appBar: AppBar(
                title: Text(getPageName()),
                actions: <Widget>[
                  if (isOwnCard)
                    IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () => onEdit(ranks[0])),
                  if (isOwnCard)
                    IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () => onDelete(userService, ranks[0]))
                ],
              ),
              body: SafeArea(
                child: PageView.builder(
                    itemCount: ranks.length,
                    itemBuilder: (context, index) {
                      return getCard(ranks[index]);
                    }),
              ));
        });
  }
}
