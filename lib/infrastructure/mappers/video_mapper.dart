
import '../../domain/domain.dart';
import '../infracstructure.dart';

class VideoMapper {

  static moviedbVideoToEntity( VideoDB moviedbVideo ) => Video(
    id: moviedbVideo.id, 
    name: moviedbVideo.name, 
    youtubeKey: moviedbVideo.key,
    publishedAt: moviedbVideo.publishedAt,
    type: moviedbVideo.type
  );


}