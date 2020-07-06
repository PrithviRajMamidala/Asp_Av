#!/usr/bin/perl

# my $filename = 'C:\Users\naga.sai\Documents\perl_tests\vm_10.txt';
# open my $handle, '<', $filename or die "Cannot open:$!\n", "UTF-8";
# chomp(my @lines = <$handle>);
# close $handle;

`vmstat 1 600 | grep -v '^procs' | grep -v '^ r' > vms.txt`
@lines = `vmstat 1 600 | grep -v '^procs' | grep -v '^ r'`;

print "\n1 min \n------ \n";
func(60);
print "\n5 min \n------ \n";
func(300);
print "\n10 min \n------ \n";
func(scalar@lines);

`perl ADG300_vm_stat_1.pl > out.txt`


# Average Function definition
sub Average 
{
   # get total number of arguments passed.
   $n = scalar(@_);
   #print "$n";
   $sum = 0;

   foreach $item (@_) {
      $sum += $item;
   }
   $average = $sum / $n;

   return $average
}

sub func
{
my $j = 0;
my ($n) = @_;
	for (my $i=scalar@lines-1; $i >= 0 ; $i--)
		{
			$free = (split(' ', $lines[$i]))[3];
			$buff = (split(' ', $lines[$i]))[4];
			$cache = (split(' ', $lines[$i]))[5];
			$id = (split(' ', $lines[$i]))[14];
			if($j < $n)
				{
					@CPU_use[$j] = (100 - $id);
					@Memory_usage [$j]= (1000000 - ($free + $buff + $cache));
					$j++;
				}
		}
	$Avg_CPUuse = Average(@CPU_use);
	printf ("Average CPU usage: %.3f%\n", $Avg_CPUuse);
	$Avg_Memuse = (Average(@Memory_usage))/10000;
	printf ("Average Memeory usage: %.3f%\n", $Avg_Memuse);
}





