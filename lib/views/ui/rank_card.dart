import 'package:flutter/material.dart';
import 'package:totem_rank_demo/models/entities/Rank.dart';

class RankCard extends StatelessWidget {

  final Rank rank;
  final bool isPreview;
  final Function onPress;
  final Function onMorePress;
  

  RankCard({
    Key key,
    this.rank,
    this.isPreview = false,
    this.onPress,
    this.onMorePress,
  }) : super(key: key);

  List<Widget> buildRecords(context) {
    List records = isPreview ? rank.records.sublist(0, 3) : rank.records;
    var i = 1;
    List<Widget> content = records.map((e) =>
      ListTile(
        leading: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            SizedBox(
              width: 30,
              child: Text(
                '${i++}.',
                style: Theme.of(context).textTheme.bodyText1.copyWith(
                      fontSize: 18,
                      color: Colors.grey,
                    ),
              ),
            ),
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Color(e.name.hashCode * e.name.hashCode * e.name.hashCode),
                borderRadius: BorderRadius.circular(40)
              ),
              child: Center(
                child: Text(
                  e.name[0].toUpperCase(),
                  style: Theme.of(context).textTheme.headline6,
                ),
              )
            ),
          ],
        ),
        title: Text(
          e.name,
        ),
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
    return InkWell(
    onTap: onPress,
      child: Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 20),
            if (isPreview) Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(width: 10),
                IconButton(
                  icon: Icon(Icons.more),
                  onPressed: onMorePress,
                ),
                Expanded(
                  child: 
                Text(
                  rank.name,
                  textAlign: TextAlign.left,
                  style: Theme.of(context).textTheme.bodyText1.copyWith(
                    fontSize: 18,
                  ),
                ),
                ),
              ]
            ),
            ...buildRecords(context),
            SizedBox(height: 20),
          ],
        )
      ),
    );
  }
}
