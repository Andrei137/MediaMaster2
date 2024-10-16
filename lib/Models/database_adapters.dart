import 'dart:io';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'app_achievement.dart';
import 'creator.dart';
import 'game.dart';
import 'game_achievement.dart';
import 'genre.dart';
import 'link.dart';
import 'media.dart';
import 'media_creator.dart';
import 'media_link.dart';
import 'media_platform.dart';
import 'media_publisher.dart';
import 'media_retailer.dart';
import 'media_user.dart';
import 'media_user_genre.dart';
import 'media_user_tag.dart';
import 'note.dart';
import 'platform.dart';
import 'publisher.dart';
import 'retailer.dart';
import 'tag.dart';
import 'user.dart';
import 'user_achievement.dart';
import 'wishlist.dart';

Future<void> initHiveAndAdapters() async {
  // Obtain a directory where Hive should store its files
  final appDocumentDir = await path_provider.getApplicationDocumentsDirectory();
  Directory DBDir =
      await Directory('${appDocumentDir.path}\\MediaMasterDB').create();

  await Hive.initFlutter(DBDir.path);

  Hive.registerAdapter(AppAchievementAdapter());
  Hive.registerAdapter(CreatorAdapter());
  Hive.registerAdapter(GameAdapter());
  Hive.registerAdapter(GameAchievementAdapter());
  Hive.registerAdapter(GenreAdapter());
  Hive.registerAdapter(LinkAdapter());
  Hive.registerAdapter(MediaAdapter());
  Hive.registerAdapter(MediaCreatorAdapter());
  Hive.registerAdapter(MediaLinkAdapter());
  Hive.registerAdapter(MediaPlatformAdapter());
  Hive.registerAdapter(MediaPublisherAdapter());
  Hive.registerAdapter(MediaRetailerAdapter());
  Hive.registerAdapter(MediaUserAdapter());
  Hive.registerAdapter(MediaUserGenreAdapter());
  Hive.registerAdapter(MediaUserTagAdapter());
  Hive.registerAdapter(NoteAdapter());
  Hive.registerAdapter(PlatformAdapter());
  Hive.registerAdapter(PublisherAdapter());
  Hive.registerAdapter(RetailerAdapter());
  Hive.registerAdapter(TagAdapter());
  Hive.registerAdapter(UserAdapter());
  Hive.registerAdapter(UserAchievementAdapter());
  Hive.registerAdapter(WishlistAdapter());

  await Hive.openBox<AppAchievement>('appAchievements');
  await Hive.openBox<Creator>('creators');
  await Hive.openBox<Game>('games');
  await Hive.openBox<GameAchievement>('gameAchievements');
  await Hive.openBox<Genre>('genres');
  await Hive.openBox<Link>('links');
  await Hive.openBox<Media>('media');
  await Hive.openBox<MediaCreator>('media-creators');
  await Hive.openBox<MediaLink>('media-links');
  await Hive.openBox<MediaPlatform>('media-platforms');
  await Hive.openBox<MediaPublisher>('media-publishers');
  await Hive.openBox<MediaRetailer>('media-retailers');
  await Hive.openBox<MediaUser>('media-users');
  await Hive.openBox<MediaUserGenre>('media-user-genres');
  await Hive.openBox<MediaUserTag>('media-user-tags');
  await Hive.openBox<Note>('notes');
  await Hive.openBox<Platform>('platforms');
  await Hive.openBox<Publisher>('publishers');
  await Hive.openBox<Retailer>('retailers');
  await Hive.openBox<Tag>('tags');
  await Hive.openBox<User>('users');
  await Hive.openBox<UserAchievement>('userAchievements');
  await Hive.openBox<Wishlist>('wishlists');
}
