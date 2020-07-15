// import 'package:totem_rank_demo/models/entities/Rank.dart';
import 'package:totem_rank_demo/models/entities/Rank.dart';
import 'package:totem_rank_demo/models/entities/User.dart';

  List<Map<String, dynamic>> _ranksPreview = const [
    {
      'id': 1,
      'name': 'Cars',
      'dateTime': 1594643160980,
      'records': [
        {
          'name': 'First',
          'id': 11,
        },
        {
          'name': 'irst',
          'id': 12,
        },
        {
          'name': 'rst',
          'id': 13,
        },
        {
          'name': 'st',
          'id': 14,
        },
        {
          'name': 't',
          'id': 15,
        },
      ],
    },
    {
      'id': 2,
      'name': 'Cats',
      'dateTime': 1594643160980,
      'records': [
        {
          'name': 'Mew',
          'id': 11,
        },
        {
          'name': 'Murr',
          'id': 12,
        },
        {
          'name': 'Mou',
          'id': 13,
        },
        {
          'name': 'Urrr',
          'id': 15,
        },
      ],
    },
    {
      'id': 3,
      'name': 'Films',
      'dateTime': 1594643160980,
      'records': [
        {
          'name': 'First',
          'id': 11,
        },
        {
          'name': 'irst',
          'id': 12,
        },
        {
          'name': 'rst',
          'id': 13,
        },
        {
          'name': 'st',
          'id': 14,
        },
        {
          'name': 't',
          'id': 15,
        },
      ],    },
    {
      'id': 4,
      'name': 'List of products',
      'dateTime': 1594643160980,
      'records': [
        {
          'name': 'First',
          'id': 11,
        },
        {
          'name': 'irst',
          'id': 12,
        },
        {
          'name': 'rst',
          'id': 13,
        },
        {
          'name': 'st',
          'id': 14,
        },
        {
          'name': 't',
          'id': 15,
        },
      ],
    },
    {
      'id': 5,
      'name': 'Guard',
      'dateTime': 1594643160980,
      'records': [
        {
          'name': 'First',
          'id': 11,
        },
        {
          'name': 'irst',
          'id': 12,
        },
        {
          'name': 'rst',
          'id': 13,
        },
        {
          'name': 'st',
          'id': 14,
        },
        {
          'name': 't',
          'id': 15,
        },
      ],
    },
    {
      'id': 6,
      'name': 'Oh stop it you',
      'dateTime': 1594643160980,
      'records': [
        {
          'name': 'First',
          'id': 11,
        },
        {
          'name': 'irst',
          'id': 12,
        },
        {
          'name': 'rst',
          'id': 13,
        },
        {
          'name': 'st',
          'id': 14,
        },
        {
          'name': 't',
          'id': 15,
        },
      ],
    },
  ];
class UserService {

  User _user = User(
    name: 'Sveta K',
    ranks: _ranksPreview.map((e) => Rank.fromMap(e)).toList(),
  );

  List<Map> get ranks {
    return user.ranks.map((item) => {
      'id': item.id,
      'name': item.name,
    }).toList();
  }

  User get user {
    return _user;
  }




}