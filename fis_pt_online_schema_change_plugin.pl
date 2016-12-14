use strict ;
use warnings FATAL => 'all';

package pt_online_schema_change_plugin ;

sub new {
    my ($class, %args) = @_;
    my $self = { %args };
    return bless $self, $class;
}

sub before_swap_tables {
    if (-e '/opt/pt_schema_change_wait.txt') {
        #file /opt/pt_schema_change_wait.txt exist
    } else {
        #create file if it does not exist
        open(my $fh, '>', '/opt/pt_schema_change_wait.txt');
        print $fh "Please delete this file to allow pt-online-schema-change script to complete \n";
        close $fh;
    }

    print "======================================================================================\n";
    print "SCRIPT WILL ONLY SWAP TABLE IF FILE IS NOT PRESENT /opt/pt_schema_change_wait.txt\n";
    print "======================================================================================\n";

    #loop until deleted
    while (-e '/opt/pt_schema_change_wait.txt') {
        print "File /opt/pt_schema_change_wait.txt is present will delay table swap by 1 minute to proceed silmply delete this file\n";
        sleep(60);
    }
    print "File is /opt/pt_schema_change_wait.txt NOT present will swap tables now!\n";
    return;
}
1;