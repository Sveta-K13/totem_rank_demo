import 'package:flutter/material.dart';
import 'package:totem_rank_demo/models/entities/Rank.dart';

class RankCard extends StatelessWidget {

  final Rank rank;
  final bool isPreview;

  RankCard({
    Key key,
    this.rank,
    this.isPreview = false,
  }) : super(key: key);

  List<Widget> buildRecords() {
    List records = isPreview ? rank.records.sublist(0, 3) : rank.records;
    List<Widget> content = records.map((e) =>
      ListTile(
        leading: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: Color(e.name.hashCode * e.name.hashCode * e.name.hashCode),
            borderRadius: BorderRadius.circular(40)
          ),
          child: Center(
            child: Text(
              e.name[0],
            ),
          )
        ),
        title: Text(e.name),
      )
    ).toList();
    int diff = rank.records.length - records.length;

    return [
      ...content,
      if (isPreview && diff > 0) Text('and $diff more'),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          SizedBox(height: 20),
          Text(rank.name),
          ... buildRecords(),
          SizedBox(height: 20),
        ],
      )
    );
  }
}
