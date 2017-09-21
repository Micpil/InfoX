# v1. MP 21/10/17
# I'll stick with Perl. 
# Hard enough just getting my head back around that let alone rewriting it in Python or PHP.
# Start by reformatting, commenting and just figuring out what it does and look for ways to improve.
# Seems to be doing things in a roundabout way

#
# Instructions
#
# 1. Figure out what this function does
# 2. Write a unit test for it
# 3. Refactor for readability and efficiency
#
# NOTE: Do regular commits that show agile style iterations through the problem.
# If you prefer a different language, you can provide your solution in PHP, 
# Python or Javascript too.

# 
# declare namespace
package SillyFunction;

# sorts an arrayref of hashes with "brand" and "type" as fields by brand and type.
# assumes the pairings are unique
sub group_products 
{
	my $products = shift; # list of product items (unique brand|type combinations assumed!)
	
	#testing
	$products = [{ brand => "b", type => "z" }, { brand => "b", type => "x"}, { brand => "a", type => "v"}, { brand => "a", type => "u"}];
	
	my %brand_type = ();  # empty hash for brand type
	my $grouped_products = []; # ref to an array containing sorted output (sorted by brand then type)

	# for each product hash
	foreach (@{$products}) # deref the arrayref to a standard array (!)
	{
		# assign empty hashref if $brand_type{$_->{brand}} is false (unnecessary.. Perl autovivicates undefined values used as a hash/array refs)
		$brand_type{$_->{brand}} ||= {}; 
		# assign 1 to type 
		$brand_type{$_->{brand}}->{$_->{type}} = 1; 
	}
	
	# for each alphabetically sorted brand type name
	foreach (sort keys %brand_type)
	{
		my $brand = $_; # store current key (kinda unnecessary)
		# Sort all the keys referenced by $brand_type{$brand}
		foreach (sort keys %{$brand_type{$brand}}) 
		{
			# deref an ordinary array from the arrayref and add a hashref to the output for brand and type
			push(@{$grouped_products}, { brand => $brand, type => $_});
		}
	}
	# implicitly return arrayref containing all brands and types
	return $grouped_products; 
}

# All good
1;

# lazy test harness for a silly bit of code
print "start run\n\n";

$out = SillyFunction->group_products();

foreach (@{$out})
	{print $_->{brand}, " : ",  $_->{type}, "\n";}

print "\n\nend run";
  