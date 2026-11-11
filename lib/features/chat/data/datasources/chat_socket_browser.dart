import 'package:web_socket_channel/web_socket_channel.dart';

WebSocketChannel openChatSocket(Uri uri, {String? origin}) =>
    WebSocketChannel.connect(uri);
