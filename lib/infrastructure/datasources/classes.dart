// Dart code continues here
class Data {
  final ModuleRequest image;
  final String title;
  final String description;
  final String field1;
  final String field2;
  final String field3;
  final String field4;
  final String moduleID;
  final bool isChapter;
  final ModuleRequest link;
  final String animeUrl;

  Data(
      this.image,
      this.title,
      this.description,
      this.field1,
      this.field2,
      this.field3,
      this.field4,
      this.moduleID,
      this.isChapter,
      this.link,
      this.animeUrl);
}

class PlayerData {
  final String title;
  final String dataPlayer;

  PlayerData({required this.title, required this.dataPlayer});
}

class ModuleRequest {
  final String url;
  final String method;
  final List<KeyValue>? headers;
  final List<KeyValue>? httpBody;

  ModuleRequest(this.url, this.method, this.headers, this.httpBody);
}

class Extra {
  final List<Commands> commands;
  final List<KeyValue> extraInfo;

  Extra(this.commands, this.extraInfo);
}

class Commands {
  final String commandName;
  final List<KeyValue> params;

  Commands(this.commandName, this.params);
}

class KeyValue {
  final String key;
  final String value;

  KeyValue(this.key, this.value);

  Map<String, dynamic> toJson() {
    return {
      'key': key,
      'value': value,
    };
  }
}

class JavascriptConfig {
  final bool removeJavascript;
  final bool loadInWebView;
  final String javaScript;

  JavascriptConfig(this.removeJavascript, this.loadInWebView, this.javaScript);

  Map<String, dynamic> toJson() {
    return {
      'removeJavascript': removeJavascript,
      'loadInWebView': loadInWebView,
      'javaScript': javaScript,
    };
  }
}

class Chapters {
  final ModuleRequest request;
  final Extra extra;
  final JavascriptConfig javascriptConfig;
  final Output output;

  Chapters(this.request, this.extra, this.javascriptConfig, this.output);
}

class RawVideo {
  final List<Video> video;
  RawVideo(this.video);
}

class Video {
  final String videoQuality;
  final ModuleRequest videoLink;
  final String serverName;

  Video(this.videoQuality, this.videoLink, this.serverName);
}

class NeedsResolver {
  final String resolverIdentifier;
  final ModuleRequest link;
  final String serverName;

  NeedsResolver(this.resolverIdentifier, this.link, this.serverName);
}

class Output {
  final String moduleID;
  final Videos videos;
  final String? images;
  final String? text;

  Output(this.moduleID, this.videos, this.images, this.text);
}

class Videos {
  final List<NeedsResolver> needsResolver;
  final List<RawVideo> rawVideo;

  Videos(this.needsResolver, this.rawVideo);
}

class Chapter {
  final String chapName;
  final ModuleRequest link;
  final bool openInWebView;

  Chapter(this.chapName, this.link, this.openInWebView);
}


class Info {
  final ModuleRequest request;
  final Extra extra;
  final JavascriptConfig javascriptConfig;
  final Output output;

  Info(this.request, this.extra, this.javascriptConfig, this.output);
 }