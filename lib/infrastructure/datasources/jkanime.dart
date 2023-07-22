import 'dart:convert';

import 'package:cinemapedia/domain/datasources/anime_datasource.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:html/dom.dart';
import 'package:html/dom.dart' as dom;
import 'package:html/parser.dart';

import '../models/anime.dart';
import 'classes.dart';

const String url = 'https://jkanime.net/';

class JkAnimeDatasource extends AnimeDatasource {
  List<Data> episodesArray = [];

  final dio = Dio(BaseOptions(baseUrl: url));

  var moduleID = '234234823';

  quickData(link, image, title, field1, playLink) {
    return Data(image, title, 'Anime', field1, 'unknown', 'unknown', 'unknown',
        moduleID, false, link, playLink);
  }

  var emptyKeyValue = [KeyValue('', '')];

  @override
  Future<List<Data>> getNowPlaying({int page = 1}) async {
    final res = await dio.get('');

    final Document document = parse(res.data);

    var episodes = document.querySelectorAll('.bloqq');

    var episodesArray2 = [];
    for (var x = 0; x < episodes.length; x++) {
      final episode = episodes[x];
      dynamic image = episode.querySelector('img')!.attributes['src'];
      image = ModuleRequest(image, 'get', emptyKeyValue, null);
      final title = episode
          .querySelector('.anime__sidebar__comment__item__text')!
          .querySelector('h5')!
          .text;
      var ep = episode
          .querySelector('.anime__sidebar__comment__item__text')!
          .querySelector('h6')!
          .text;
      List links = episode.attributes['href']!.split('/');
      final playLink = episode.attributes['href']!;
      links.removeLast();
      links.removeLast();
      String link = '${links.join('/')}/';
      ModuleRequest finalLink = ModuleRequest(link, 'get', emptyKeyValue, null);
      var data = Data(image, title, 'Anime', playLink, ep, 'Ongoing',
          'EmptyValue', moduleID, false, finalLink, playLink);
      episodesArray.add(data);
      data = Data(image, title, ep, ep, ep, 'Ongoing', 'EmptyValue', moduleID,
          false, finalLink, playLink);
      episodesArray2.add(data);
    }

    return episodesArray;
  }

  @override
  Future<List<Data>> getPopular({int page = 1}) async {
    final res = await dio.get('');

    final Document document = parse(res.data);

    final lastAdded = document
        .querySelector('.trending__anime')!
        .querySelectorAll('.col-md-6');
    List<Data> lastAddedArray = [];
    for (var x = 0; x < lastAdded.length; x++) {
      // try {
      dynamic last = lastAdded[x];
      dynamic image = last.querySelector('.set-bg')!.attributes['data-setbg'];
      image = ModuleRequest(image, 'get', emptyKeyValue, null);
      final title = last.querySelector('h5')!.querySelector('a')!.text;
      var link = last.querySelector('a')!.attributes['href'];
      link = ModuleRequest(link, 'get', emptyKeyValue, null);
      final data = Data(image, title, 'Uknown', 'Anime', 'Ongoing', 'Unknown',
          '', moduleID, false, link, link.url);
      lastAddedArray.add(data);
      // } catch (e) {
      //   debugPrint(e.toString());
      // }
    }
    return lastAddedArray;
  }

  @override
  Future<List<Data>> getTopRate({int page = 1}) async {
    final res = await dio.get('');

    final Document document = parse(res.data);

    //  try {
    var top2 = document
        .querySelectorAll('.destacados')[1]
        .querySelectorAll('.col-lg-4, .col-6');
    List<Data> topArray = [];
    for (var x = 0; x < top2.length; x++) {
      // try {
      var topS = top2[x];
      dynamic image = topS.querySelector('.set-bg')!.attributes['data-setbg'];
      image = ModuleRequest(image, 'get', emptyKeyValue, null);
      final title = topS.querySelector('.tituloblanco')!.text;
      String link = topS.querySelector('a')!.attributes['href']!;

      ModuleRequest finalLink = ModuleRequest(link, 'get', emptyKeyValue, null);
      final data = Data(image, title, 'Uknown', 'Anime', 'Anime', 'Ongoing',
          'This is a description', moduleID, false, finalLink, link);
      topArray.add(data);
      // } catch (e) {
      //   debugPrint(e.toString());
      // }
    }
    // } catch (e) {
    //   debugPrint(e.toString());
    // }
    return topArray;
  }

  @override
  Future<List<Data>> getUpcoming({int page = 1}) async {
    final res = await dio.get('');

    final Document document = parse(res.data);

    List<Data> destacadosArray = [];

    final destacados = document.querySelectorAll('.hero__items');
    for (var x = 0; x < destacados.length; x++) {
      var destacado = destacados[x];
      dynamic image = destacado.attributes['data-setbg'];
      image = ModuleRequest(image, 'get', emptyKeyValue, null);
      final title = destacado.querySelector('h2')!.text;
      List links = destacado.querySelector('a')!.attributes['href']!.split('/');
      final playLink = destacado.querySelector('a')!.attributes['href']!;
      links.removeLast();
      links.removeLast();
      String link = '${links.join('/')}/';
      ModuleRequest finalLinks =
          ModuleRequest(link, 'get', emptyKeyValue, null);
      final data = Data(image, title, title, 'Anime', 'Ongoin', 'Uknown', '',
          moduleID, false, finalLinks, playLink);
      destacadosArray.add(data);
    }

    return destacadosArray;
  }

  @override
  Future<AnimeJK> getAnimeByUrl(String url) async {
    final dio = await Dio().get(url);

    String getStuff(List array, match) {
      String data = '';
      for (var x = 0; x < array.length; x++) {
        data = array[x].text;
        if (data.contains(match)) {
          return data.replaceAll(match, '').trim();
        }
      }
      return data;
    }

    final Document document = parse(dio.data);

    var emptyKeyValue = [KeyValue('', '')];
    String image = document
        .querySelector('.anime__details__pic')!
        .attributes['data-setbg']!;

    ModuleRequest finalImage =
        ModuleRequest(image, 'get', emptyKeyValue, emptyKeyValue);
    var title = document.querySelector('.anime__details__title')!.text.trim();
    var description = document
        .querySelector('.anime__details__text')!
        .querySelector('p')!
        .text;
    List<dom.Element> arrayData = document
        .querySelector('.anime__details__widget')!
        .querySelectorAll('li');
    String type = getStuff(arrayData, 'Tipo:');
    String state = getStuff(arrayData, 'Estado:');
    String episodes = '${getStuff(arrayData, 'Episodios:')} Episodes';
    String language = getStuff(arrayData, 'Idiomas:');
    List<String> genres = getStuff(arrayData, 'Genero:').split(', ');
    List<Chapter> chaptersArray = [];
    var chapters =
        document.querySelector('.anime__pagination')!.querySelectorAll('a');
    var last = chapters[chapters.length - 1].text.split(' - ')[1];

    print(episodes);

    final anime = AnimeJK(
        title: title,
        description: description,
        episodes: episodes,
        genres: genres,
        language: language,
        state: state,
        type: type,
        chapters: chaptersArray,
        url: url,
        imageUrl: image);

    return anime;
  }
}
