#!/usr/bin/perl


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

my $filename = '/nfs/user/n/nagasaiprithviraj/perl_tests/vm_10.txt';
open my $handle, '<', $filename or die "Cannot open:$!\n", "UTF-8";
chomp(my @lines = <$handle>);
close $handle;

my $j = 0;

for (my $i=scalar@lines-1; $i >= 0 ; $i--)
	{
		$verify = (split(' ', $lines[$i]))[0];
	#print "$verify";
		if($verify eq procs or $verify eq r)
		{
		}
		else
		{
			$free = (split(' ', $lines[$i]))[3];
			$buff = (split(' ', $lines[$i]))[4];
			$cache = (split(' ', $lines[$i]))[5];
			$id = (split(' ', $lines[$i]))[14];
			if($j < 60)
			{
				@CPU_use[$j] = (100 - $id);
				@Memory_usage [$j]= (1000000 - ($free + $buff + $cache));
			}
			if($j < 300)
			{
				@CPU_use_5[$j] = (100 - $id);
				@Memory_usage_5 [$j]= (1000000 - ($free + $buff + $cache));
			}
			if($j < scalar@lines)
			{
				@CPU_use_10[$j] = (100 - $id);
				@Memory_usage_10 [$j]= (1000000 - ($free + $buff + $cache));
			}
			$j++;
		}
	}

print "\n1 min \n------ \n";
$Avg_CPUuse = Average(@CPU_use);
printf ("Average CPU usage: %.3f%\n", $Avg_CPUuse);
$Avg_Memuse = (Average(@Memory_usage))/10000;
printf ("Average Memeory usage: %.3f%\n", $Avg_Memuse);

print "\n5 min \n------ \n";
$Avg_CPUuse = Average(@CPU_use_5);
printf ("Average CPU usage: %.3f%\n", $Avg_CPUuse);
$Avg_Memuse = Average(@Memory_usage_5)/10000;
printf ("Average Memeory usage: %.3f%\n", $Avg_Memuse);

print "\n10 min \n------ \n";
$Avg_CPUuse = Average(@CPU_use_10);
printf ("Average CPU usage: %.3f%\n", $Avg_CPUuse);
$Avg_Memuse = Average(@Memory_usage_10)/10000;
printf ("Average Memeory usage: %.3f%\n", $Avg_Memuse);

