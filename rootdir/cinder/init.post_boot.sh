#! /bin/sh
# Copyright (c) 2022 Qualcomm Innovation Center, Inc. All rights reserved.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted (subject to the limitations in the
# disclaimer below) provided that the following conditions are met:
#
#     * Redistributions of source code must retain the above copyright
#       notice, this list of conditions and the following disclaimer.
#
#     * Redistributions in binary form must reproduce the above
#       copyright notice, this list of conditions and the following
#       disclaimer in the documentation and/or other materials provided
#       with the distribution.
#
#     * Neither the name of Qualcomm Innovation Center, Inc. nor the names of its
#       contributors may be used to endorse or promote products derived
#       from this software without specific prior written permission.
#
# NO EXPRESS OR IMPLIED LICENSES TO ANY PARTY'S PATENT RIGHTS ARE
# GRANTED BY THIS LICENSE. THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT
# HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED
# WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
# MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.
# IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR
# ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
# DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE
# GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
# INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER
# IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR
# OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN
# IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

SHELLPROMPT=$(cat << "END"
~~~~~~~~^~~^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^~!!~^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^~
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^75!:^^^^!JGBBG~^!^^^^^^^^^^^^^^^^^^^^^^^^^^^^~
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^?5#&&GPPP5PY5#BY:::.:^^^^^^^^^^^^^^^^^^^^^^^^^^~
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^!Y#&#@&@&@@#B&&#GP7:.....:^^^^^^^^^^^^^^^^^^^^^^^^~
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^~!?YB&@@&&&B@@BGG@@&B#G7:^:.....:^^^^^^^^^^^^^^^^^^^^^^~
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^!?YPB#&&&@@@@&&&@@BP!PB#PB@J7?!!^......:^^^^^^^^^^^^^^^^^^^^~
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^~JB#5Y&&#&&&@@&##5&@#5PGB!P&#?:!BBGJ^......::^^^^^^^^^^^^^^^^^^~
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^:^?75##Y!G&&@#&@@&#BG&#5P#&&B&BP~::JBBG5!:..::....^~^^^^^^^^^^^^^^~
^^^~^^^^^^^^^^^^^^^^^^^^^^^~~!~~J7G#&&@&BJY#@#G@@@&&B&&G#&##@&GGG!::^5GGBPJ!:.^7~...:^~^^^~^^^^^^^^~
^^~~^~^~~~~^^^^^^^^~~^^~^~~~~B#P~!G&@@@@BBYY&P#@&G#BB&#&&#B&#PP&#?~^^!5BBGBP?^.??:....:^~~~^~~~^~^^~
^~~~^^~^^~~^^^^^^^^~^^~^^..:J#GY.^7?#@@@##&&&#&#P#&&&###B&&BGP#@&57^^~~B#BGBBP?^~7^.....:~~~~~~~^^^~
~~~~~~~~^~~^^~~~~^~^^^~^:..:BB?^^7?#&&@&@&&&&&BPB@&#B#####BGPB@@@G?~^~~7B##B&&&BJ!~^^^:...^~~~~~~~~~
~~~~~~~~~~~~~~~~~~~~~~~^:?G5G7!!PB?&&5&@#B&&#BGB@&BB#&&#BBGP#@@@@G7~^~~~!P##&&&&BPY77^^^:...^~~~~~~~
~~~~~~~~~~~~~~~~~~~~~:^YG?PY^?#&&B?#&YB@PG&BGP#@&BB##BBGGPPP#@@@&5?!^^!!~~?G#&@&Y!J^::::^^:...:~~~~~
~~~~~~~~~~~~~~~~~~~~~:!PY!PJ7#@#55Y&BYGG5&BBPB&#BBG5PPGPPPP5P&@&5JY?~^~!!!~~Y#@#^ ....:..:^~:...:~~~
~~~~~~~~~~~~~~~~~~!^!G&#YG5!~G#5YYY&5J5J7!J5PBGGBP75GGP55P55G&&&#5YY57^^~J7~^!BB^:~:.:~^...:^~^:.::~
~~~~~~~~~~~~~~~~:J~^##GPBGJ7Y5BP5YJ&J!:!7!7J5YYPP5GGG5?J7Y555GGBB55PYYY!:JPY!^^?Y5GY5G&P7~.:::^~~^::
~~~~~~~~~~~~~~7^YP!JGPPP5YBB5PP55?~!^^:!~~^!YJ!!~::5GGJJ^.:75PB&&##G5?5!:^?P57~^^~?JYB##&&Y^^^^~^^^:
~~~~~~~~~~~~~77?GP5PP55YJBPP555Y7^^~.:~::^..:::    .~?G&&7^^P5?PPBBGP?P~:JP57Y5Y!!!!!?PBGJ?~:.:7J!7^
~~~~~~~~~~~!??JPPP5P55Y557:^!!!7^^~:.^~.:^^.:..       .~!7J^!7~5Y?YP7~?~:5##5PGB#P!J?JG@&?7??!:.:!?7
~~~~~~~~~!5YYP5555Y?7^:!~:...:^^:~~.:~^::~!..:...   ..   .^PJ^:^PP5Y!:!~:!PGGGG#&J77J5PG&&#BPY??7!:~
~~~~~~~^:GGPP5Y5Y7^^~...^:...::.^!^.:^~~!77^ ..:.....:...:^GP~^G&&G~^::...!JJ7~^..  .:::!?Y5?5PPPG!^
!~~~~~7: !P555J?7~.:...:^::.....^~^~^^~?J!::.....::...^??J?J7!!?GBB5^:::.....           .:G##&&##G7^
!~~~J#G. .Y5?!^~^:.....:::.... .^!:^:...::^?7:::.^:..:!JY7^~7~^!7!~~^:...  ...:!:.  ....:~?PGGG5J^^:
::!YG5!...!?~~~::::....:^::...  .:.....:..:^^:.!:..^^^:.:^:.:^::^?^^::::....:.^7..:^!!~~7JJ77!~^^:::
:^77~:^.:. :!:..::.....:^:..  ..  ...:.:..::^:.^:.:^::. .:..:^:. ::~^^:::. .?JJY7!!7!!7~~~^^^^^:^:^^
 __          __  _                            _          _                _____ _____ ______ _   _
 \ \        / / | |                          | |        | |        /\    / ____/ ____|  ____| \ | |
  \ \  /\  / /__| | ___ ___  _ __ ___   ___  | |_ ___   | |       /  \  | (___| (___ | |__  |  \| |
   \ \/  \/ / _ \ |/ __/ _ \| '_ ` _ \ / _ \ | __/ _ \  | |      / /\ \  \___ \\\___ \|  __| | . ` |
    \  /\  /  __/ | (_| (_) | | | | | |  __/ | || (_) | | |____ / ____ \ ____) |___) | |____| |\  |
     \/  \/ \___|_|\___\___/|_| |_| |_|\___|  \__\___/  |______/_/    \_\_____/_____/|______|_| \_|


** SHELL LOGIN **
================
UserName : root
pwd : oelinux123
================

** TO LOAD MODEM RUN BELOW COMMAND **
=====================================
echo start > /sys/class/remoteproc/remoteproc0/state
=====================================
--------------------------------------------------------------------------------------------------

END
)

echo "$SHELLPROMPT" > /dev/console
echo 4 > /proc/sys/kernel/printk
