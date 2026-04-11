enum ErrorKey {
  network,       // error_network
  timeout,       // error_timeout
  server400,     // error_server_400
  server401,     // error_server_401
  server404,     // error_server_404
  server500,     // error_server_500
  serverUnknown, // error_server_unknown (has {code} placeholder)
  noData,        // error_no_data
  unknown,       // error_unknown
}