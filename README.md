### `pt-online-schema-change` plugin written in Perl.
 
Plugin when executed with your `pt-online-schema-change` command will pause in the last stage of execution, untill file `/opt/pt_schema_change_wait.txt` is deleted.

#####How to run:

just add `--plugin /path/to/fis_pt_online_schema_change_plugin.pl` to your  `pt-online-schema-change` command

#####what will it do to your run:

it will create plain text file in `/opt/pt_schema_change_wait.txt` your `pt-online-schema-change` command should run as usual until very last step, it will pause `before_swap_tables` is executed.

[pt-online-schema-change documentation](https://www.percona.com/doc/percona-toolkit/2.2/pt-online-schema-change.html)

example:

`pt-online-schema-change --execute --plugin /path/to/pt_online_schema_change_plugin.pl 
--password=YOUR_DB_PASSWORD --user=YOUR_DB_USER --chunk-time=1 --nodrop-old-table --alter "add column foo int(11) default null, add column foo2 int(11) default null, add column foo3 int(11) default null, add column foo4 int(11) default null" D=employees,t=employees,h=127.0.0.1 --alter-foreign-keys-method "auto"
`


___

btw, 
`--pause-file` option in the latest `pt-online-schema-change` build (2.2.20) will do similar thing. 
However this option will only create copy of the table, with new schema and only move data when file is deleted.


