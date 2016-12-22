use strict ;
use warnings;


package pt_online_schema_change_plugin ;

sub new {
    my ($class, %args) = @_;
    my $self = { %args };
    return bless $self, $class;
}

sub before_swap_tables {
    my $pauseFile = './pt_schema_change_wait_.txt';

    if (-e $pauseFile) {
        #file $pauseFile exist
    } else {
        #create file if it does not exist
        open(my $fh, '>', $pauseFile);
        print $fh "Please delete this file to allow pt-online-schema-change script to complete \n";
        close $fh;
    }

    print "======================================================================================\n";
    print "SCRIPT WILL ONLY SWAP TABLE IF FILE IS NOT PRESENT $pauseFile\n";
    print "======================================================================================\n";

    #loop until deleted
    while (-e $pauseFile) {
        print "File $pauseFile is present will delay table swap by 1 minute to proceed silmply delete this file\n";
        sleep(60);
    }
    print "File is $pauseFile NOT present will swap tables now!\n";
    return;
}
1;
