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

  List<Widget> getCards(userService) {
    return ranks
        .map(
          (rank) => SizedBox(
            height: 300,
            child: Container(
              padding: EdgeInsets.all(30),
              child: RankCard(
                key: Key(rank.id.toString()),
                rank: rank,
              ),
            ),
          ),
        )
        .toList();
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
                        onPressed: () => onEdit(ranks[0]))
                ],
              ),
              body: SafeArea(
                child: PageView(
                  children: getCards(userService),
                ),
              ));
        });
  }
}
