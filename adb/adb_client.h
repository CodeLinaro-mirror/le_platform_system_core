#ifndef _ADB_CLIENT_H_
#define _ADB_CLIENT_H_

#include "adb.h"

#include <string>

/* connect to adb, connect to the named service, and return
** a valid fd for interacting with that service upon success
** or a negative number on failure
*/
int adb_connect(const std::string& service, std::string* _Nonnull error);
int _adb_connect(const std::string& service, std::string* _Nonnull error);

// Connect to adb, connect to the named service, returns true if the connection
// succeeded AND the service returned OKAY. Outputs any returned error otherwise.
bool adb_command(const std::string& service);

// Connects to the named adb service and fills 'result' with the response.
// Returns true on success; returns false and fills 'error' on failure.
bool adb_query(const std::string& service, std::string* _Nonnull result,
               std::string* _Nonnull error);

// Set the preferred transport to connect to.
void adb_set_transport(TransportType type, const char* _Nullable serial);

/* Set TCP specifics of the transport to use
*/
void adb_set_tcp_specifics(int server_port);

/* Set TCP Hostname of the transport to use
*/
void adb_set_tcp_name(const char* _Nullable hostname);

/* Return the console port of the currently connected emulator (if any)
 * of -1 if there is no emulator, and -2 if there is more than one.
 * assumes adb_set_transport() was alled previously...
 */
int  adb_get_emulator_console_port(void);

/* send commands to the current emulator instance. will fail if there
 * is zero, or more than one emulator connected (or if you use -s <serial>
 * with a <serial> that does not designate an emulator)
 */
int adb_send_emulator_command(int argc, const char* _Nonnull* _Nonnull argv,
                              const char* _Nullable serial);

// Reads a standard adb status response (OKAY|FAIL) and
// returns true in the event of OKAY, false in the event of FAIL
// or protocol error.
bool adb_status(int fd, std::string* _Nonnull error);

#endif
