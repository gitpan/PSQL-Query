use inc::Module::Install;
use strict;
use warnings;

name           'PSQL-Query';
author         'Evan Carroll <me@evancarroll.com>',
all_from       'lib/PSQL/Query.pm';
requires       'Moose';
requires       'Getopt::Long';
no_index       'directory' => 'PSQL/Query';
prompt_script  'bin/psql-plus';
version        '0.01_02';

WriteAll;
