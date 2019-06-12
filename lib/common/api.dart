
import 'dart:core';

/**
 *
 * api
**/

String BASE_URL = "http://192.168.1.106";

const String CODE_BASE_PORT = ":12223";

const String ROOM_BASE_PORT = ":12222";

const String HOTEL_BASE_PORT = ":12224";

const String ORDER_BASE_PORT = ":12225";

String CODE_URL = BASE_URL + CODE_BASE_PORT + "/auth/code/";

String TOKEN_URL = BASE_URL + CODE_BASE_PORT + "/auth/checkcode";

String HOTEL_URL = BASE_URL + HOTEL_BASE_PORT + "/hotel/info/0/1";

String ROOM_URL = BASE_URL + ROOM_BASE_PORT + "/room/detail/1";

String ROOM_COUNT_URL = BASE_URL + ROOM_BASE_PORT + "/room/count/1";

String SINGLE_ROOM_COUNT_URL = BASE_URL + ROOM_BASE_PORT + "/room/single/count/1";

String ORDER_URL = BASE_URL + ORDER_BASE_PORT + "/order/detail/";


String COMMIT_ORDER_URL = BASE_URL + ORDER_BASE_PORT + "/order/commit/";

String CREATE_ORDER_URL = BASE_URL + ORDER_BASE_PORT + "/order/create/body";