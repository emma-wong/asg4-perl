#!/usr/bin/perl

# This program was completed using pair programming.
#
# Partners:
# Emma Wong (emgwong)
# Ryan Watkins (rdwatkin)


use strict;
use warnings;
use Getopt::Std;

# program name
$0 =~ s|^(.*/)?([^/]+)/*$|$2|;

# declare hashtables and relevant indices
my %macros;
my %targets;
my %commands;
my @prev;
my $previous = "";

# exit signal
my $myexit = 0;
END {exit $myexit;}

# checks for -d
my %options;
getopts('d', \%options);

my $makefile = './Makefile';

# get target
my $mytarget = "";
$mytarget = $ARGV[0] if $ARGV[0];

my %strsignal = (
    1 => "Hangup",
    2 => "Interrupt",
    3 => "Quit",
    4 => "Illegal instruction",
    5 => "Trace/breakpoint trap",
    6 => "Aborted",
    7 => "Bus error",
    8 => "Floating point exception",
    9 => "Killed",
   11 => "Segmentation fault",
   13 => "Broken pipe",
   14 => "Alarm clock",
   15 => "Terminated",
   16 => "Stack fault",
   17 => "Child exited",
   18 => "Continued",
   19 => "Stopped (signal)",
   20 => "Stopped",
   21 => "Stopped (tty input)",
   22 => "Stopped (tty output)",
   24 => "CPU time limit exceeded",
   25 => "File size limit exceeded",
   26 => "Virtual timer expired",
   27 => "Profiling timer expired",
   28 => "Window changed",
   29 => "I/O possible",
   30 => "Power failure",
   31 => "Bad system call",
);

open my $file, $makefile or die "$0: $makefile: $!";

while (defined(my $line = <$file>)) {
  chomp($line);

  # check line for a macro, target, or command
  if ($line !~ /^#.+/) {

    # if macro
    if ($line =~ /\s*(\S+)\s*=\s+(.+)/) {
      my @array_of_values = ();
      @array_of_values = split(" ", $2);
      $macros->{$1} = [@array_of_values];
    }

    # else if target
    else if ($line =~ /\s*(\S+)\s*:.*/ and $line !~ /\t\s*.+/) {
      if ($mytarget eq "") {$mytarget = $1;}
      previous = $1;
      
    }

    # else if command
  }
}
close $file;

# sub execute_targetcommands {
#    my $exit_ignore = 0;
#    my $term_signal = $? & 0x7F;
#    my $core_dumped = $? & 0x80;
#    my $exit_status = ($? >> 8) & 0xFF;
#    if ($exit_status != 0) {
#       printf "%s: %s[%s] Error %d%s\n", $0, 
#       $exit_ignore ? '' : '*** ', $trgt, 
#       $exit_status, $exit_ignore ? ' (ignored)' : '';
#       if (!$exit_ignore) {
#          exit 2;
#       }
#       else {
#          $myexit_status = $exit_stat;
#       }
#    }
# }

# method for runtime
sub mtime ($) {
  my ($filename) = @_;
  my @stat = stat $filename;
  return @stat ? $stat[9] : undef;
}

sub debug {

}
debug_print() if defined $options{'d'};
