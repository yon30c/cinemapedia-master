import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:html/parser.dart' as parser;
import 'package:html/dom.dart';

import '../models/anime.dart';
import '../models/data_player.dart';
import '../models/pre_anime.dart';

const String url = 'https://jkanime.net/';

final dio = Dio(BaseOptions(baseUrl: url));

final animesProvider = FutureProvider((ref) => getRecentAnime());
final animeProvider = FutureProvider.family((ref, String url) => getAnime(url));


Future<List<Anime>> getRecentAnime([int page = 1]) async {
  final res = await dio.get('');

  final document = parser.parse(res.data);

  final List<Element> animes = document.querySelectorAll('.bloqq');

  List<Anime> getAnimes(List<Element> animesRes) {
    List<Anime> animesList = [];

    for (var anime in animesRes) {
      animesList.add(Anime(
          cap: anime.querySelector('h6')!.text,
          title: anime.querySelector('h5')!.text,
          url: anime.attributes['href']!,
          imageUrl: anime.querySelector('img')!.attributes['src']!));
    }

    return animesList;
  }

  return getAnimes(animes);
}

Future<List<PlayerData>> getAnime(String url) async {
  final res = await Dio().get(url);

  final Document document = parser.parse(res.data);

  final videoBox = document.getElementById('video_box')!.innerHtml;

  print(videoBox);

  final scripts = document.querySelectorAll('script');

  final player = document.querySelector('.col-lg-12');

  List<PlayerData> playerData = [];

  for (var i = 0; i < player!.querySelectorAll('a').length; i++) {
    final title = player.querySelectorAll('a');
    final videoUrl = scripts[12].text.substring(30).trimLeft().split(';');
    final vidUrl = videoUrl[i].trim().substring(11);

    playerData
        .add(PlayerData(title: title[i].text, dataPlayer: vidUrl));
  }

  return playerData;
}

