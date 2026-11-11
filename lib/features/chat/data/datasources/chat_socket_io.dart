import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

WebSocketChannel openChatSocket(Uri uri, {String? origin}) =>
    IOWebSocketChannel.connect(
      uri,
      headers: {if (origin != null) 'Origin': origin},
      connectTimeout: const Duration(seconds: 15),
    );
