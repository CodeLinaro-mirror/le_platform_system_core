/*
** Copyright 2006, The Android Open Source Project
**
** Licensed under the Apache License, Version 2.0 (the "License"); 
** you may not use this file except in compliance with the License. 
** You may obtain a copy of the License at 
**
**     http://www.apache.org/licenses/LICENSE-2.0 
**
** Unless required by applicable law or agreed to in writing, software 
** distributed under the License is distributed on an "AS IS" BASIS, 
** WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. 
** See the License for the specific language governing permissions and 
** limitations under the License.
*/
/*
** Changes from Qualcomm Innovation Center, Inc. are provided under the following license:
** Copyright (c) 2024 Qualcomm Innovation Center, Inc. All rights reserved.
** SPDX-License-Identifier: BSD-3-Clause-Clear
*/

#include <errno.h>
#include <stddef.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>

#ifndef HAVE_WINSOCK
#include <sys/socket.h>
#include <sys/select.h>
#include <sys/types.h>
#include <netinet/in.h>
#endif

#include <cutils/sockets.h>

#ifdef WITH_VSOCK
#include <cutils/vm_sockets.h>
#endif

#define LISTEN_BACKLOG 4

/* open listen() port on any interface */
int socket_inaddr_any_server(int port, int type)
{

    int s, n;

#ifndef WITH_VSOCK
    struct sockaddr_in addr;

    memset(&addr, 0, sizeof(addr));
    addr.sin_family = AF_INET;
    addr.sin_port = htons(port);
    addr.sin_addr.s_addr = htonl(INADDR_ANY);

    s = socket(AF_INET, type, 0);
    if(s < 0) return -1;

    n = 1;
    setsockopt(s, SOL_SOCKET, SO_REUSEADDR, (const char *) &n, sizeof(n));
#else
    struct sockaddr_vm addr;

    memset(&addr, 0, sizeof(addr));
    addr.svm_family = AF_VSOCK;
    addr.svm_port = 5555;
    addr.svm_cid = 3;
    s = socket(AF_VSOCK, SOCK_STREAM, 0);
    if(s < 0) return -1;
#endif

    if(bind(s, (struct sockaddr *) &addr, sizeof(addr)) < 0) {
        printf("Failed to create socket\n");
        close(s);
        return -1;
    }

    if (type == SOCK_STREAM) {
        int ret;

        ret = listen(s, LISTEN_BACKLOG);

        if (ret < 0) {
            close(s);
            return -1; 
        }
    }

    return s;
}
