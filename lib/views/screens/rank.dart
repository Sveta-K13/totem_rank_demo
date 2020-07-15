import 'package:flutter/material.dart';
import 'package:totem_rank_demo/models/entities/Rank.dart';
import 'package:totem_rank_demo/views/ui/rank_card.dart';

class RankPage extends StatefulWidget {
  RankPage({Key key, this.ranks = const []}) : super(key: key);
  final List<Rank> ranks;


  @override
  _RankPageState createState() => _RankPageState();
}

class _RankPageState extends State<RankPage> {

  List<Widget> getCards() {
    return widget.ranks.map(
      (rank) => 
      Container(
        padding: EdgeInsets.all(30),
        // width: 50,
        child: 
        RankCard(
          key: Key(rank.id.toString()),
          rank: rank,
        ),

      ),
    ).toList();
  }

  String getPageName() {
    return '${widget.ranks[0]?.name} ${widget.ranks.length > 1 ? 'lists' : ''}' ;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(getPageName()),
      ),
      body: SafeArea(
        child: PageView(
          children: getCards(),
        ),
      )
    );
  }
}
