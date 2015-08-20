#######################################################################
#
# Copyright 2011, prawn.  sean dot prawn at gmail dot com
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.
#
#######################################################################

############################# pwntter #################################
#
#       Extension for TTYyter to dump data into mysql tables.
#
#######################################################################
# CPAN Modules 
use DBI;
use Date::Manip;
use HTML::Entities;

# mysql database config
my $host     = "localhost";
my $db	     = "pwntter";
my $user_id  = "pwntter";
my $password = "pwntter";
my $pwntter_version = "0.3";

sub date_format {
  my $date = shift;
  my $s;
  if (! defined $date) {exit};
  $s = substr( $date, 0, 4 );            #yyyy
  $s = $s . '-' . substr( $date, 4, 2 ); #-mm
  $s = $s . '-' . substr( $date, 6, 2 ); #-dd
  $s = $s . ' ' . substr( $date, 8, 8 ); # hh:mm:mm
  
  return( $s );

}

$handle = sub {

     my $dbh = DBI->connect("DBI:mysql:database=$db;host=$host",
                            "$user_id", "$password",
                            {'RaiseError' => 1});

     my $ref = shift;

     #tweet data
     my $id = $ref->{'id_str'};
     my $text = &descape(decode_entities($ref->{'text'}));
     my $created_at = ParseDate($ref->{'created_at'});
     my $source	= &descape($ref->{'source'});
     my $geo_lat = $ref->{geo}->{coordinates}->[0];
     my $geo_long = $ref->{geo}->{coordinates}->[1];

     #user data
     my $user_id = $ref->{'user'}->{'id'};
     my $name = &descape($ref->{'user'}->{'name'});
     my $screen_name = &descape($ref->{'user'}->{'screen_name'});
     my $description = &descape($ref->{'user'}->{'description'});
     my $profile_image_url = &descape($ref->{'user'}->{'profile_image_url'});
     my $location = &descape($ref->{'user'}->{'location'});
     my $url = &descape($ref->{'user'}->{'url'});
     my $protected = ($ref->{'user'}->{'protected'} eq "true");
     my $followers_count = $ref->{'user'}->{'followers_count'};
     my $friends_count = $ref->{'user'}->{'friends_count'};

     if (defined ($ref{'user'}->{created_at}) ) {

       my $user_created_at = ParseDate($ref->{'user'}->{'created_at'});

     }

     my $favourites_count = $ref->{'user'}->{'favourites_count'};
     my $utc_offset = $ref->{'user'}->{'utc_offset'};
     my $time_zone = $ref->{'user'}->{'time_zone'};
     my $statuses_count	= $ref->{'user'}->{'statuses_count'};
     my $following = ($ref->{'user'}->{'following'} eq "true");
     my $verified = ($ref->{'user'}->{'verified'} eq "true");
     my $geo_enabled = ($ref->{'user'}->{'geo_enabled'} eq "true");

     if (! defined $ref->{'user'}{'id'}) { #listed tweets need this

       $user_id = $ref->{'from_user_id'};

     }

     if ( $utc_offset == "") { $utc_offset = 0; }

     #format dates to mysql datetime format YYYY-MM-DD HH:MM:SS
     if ($created_at ne '') {$created_at = date_format($created_at);}
     if ($user_created_at ne ''){ $user_created_at  = date_format($user_created_at);}

     my $sql = 	"replace into `tweets` " .
		"SET `id` = ?, " .
		" `user_id` = ?, " .
	   	" `screen_name` = ?, " .
		" `text` = ?, " .
		" `created_at` = ?, " .
		" `source` = ?, " .
		" `user_name` = ?, " . 
                " `geo_lat` = ?, " . 
		" `geo_long` = ?";



     my $sth = $dbh->prepare($sql);

     $sth->execute($id, $user_id, $screen_name, $text, $created_at, 
		$source, $name, $geo_lat, $geo_long);		  

     my $user_sql = "replace into `users` " .
		    "SET `id` = ?, " .
		    " `name` = ?, " .
		    " `screen_name` = ?, " .
		    " `description` = ?, " .
		    " `location` = ?, " .
		    " `profile_image_url` = ?, " .
		    " `url` = ?, " .
		    " `protected` = ?, " .
		    " `followers_count` = ?, " .
		    " `friends_count` = ?, " .
		    " `created_at` = ?, " .
		    " `favourites_count` = ?, " .
		    " `utc_offset` = ?, " .
		    " `time_zone` = ?, " .
		    " `statuses_count` = ?, " .
		    " `following` = ?, " .
		    " `verified` = ?, " .
		    " `geo_enabled` = ?";

  
     $sth = $dbh->prepare($user_sql);
     $sth->execute($user_id, $name, $screen_name, $description, $location, 
			$profile_image_url, $url, $protected, 
			$followers_count, $friends_count, $created_at, 
			$favourites_count, $utc_offset, $time_zone, 
			$statuses_count, $following, $verified, $geo_enabled);

     return 1;
};

$dmhandle = sub {

     my $ref = shift;


     my $dbh = DBI->connect("DBI:mysql:database=$db;host=$host",
                            "$user_id", "$password",
                            {'RaiseError' => 1});


     #Direct Message data
     my $id = $ref->{'id_str'};
     my $sender_id = &descape($ref->{'sender_id'});
     my $text = &descape(decode_entities($ref->{'text'}));
     my $recipient_id = &descape($ref->{'recipient_id'});
     my $created_at = ParseDate($ref->{'created_at'});
     my $sender_screen_name = &descape($ref->{'sender_screen_name'});
     my $recipient_screen_name = &descape($ref->{'recipient_screen_name'});
 
   
     #sender data
     my $user_id = $ref->{'sender'}->{'id'};
     my $name = &descape($ref->{'sender'}->{'name'});
     my $screen_name = &descape($ref->{'sender'}->{'screen_name'});
     my $description = &descape($ref->{'sender'}->{'description'});
     my $profile_image_url = &descape($ref->{'sender'}->{'profile_image_url'});
     my $location = &descape($ref->{'sender'}->{'location'});
     my $url = &descape($ref->{'sender'}->{'url'});
     my $protected = ($ref->{'sender'}->{'protected'} eq "true");
     my $followers_count = $ref->{'sender'}->{'followers_count'};
     my $friends_count = $ref->{'sender'}->{'friends_count'};
     my $user_created_at = ParseDate($ref->{'sender'}->{'created_at'});
     my $favourites_count = $ref->{'sender'}->{'favourites_count'};
     my $utc_offset = $ref->{'sender'}->{'utc_offset'};
     my $time_zone = $ref->{'sender'}->{'time_zone'};
     my $statuses_count	= $ref->{'sender'}->{'statuses_count'};
     my $following = ($ref->{'user'}->{'following'} eq "true");
     my $verified = ($ref->{'user'}->{'verified'} eq "true");

     #format dates to mysql datetime format YYYY-MM-DD HH:MM:SS
     $created_at = date_format($created_at);
     $user_created_at = date_format($user_created_at);

     my $dm_sql = "replace into `direct_messages` " .
		      "SET `id` = ?, " .
		      " `sender_id` = ?, " .
		      " `text` = ?, " .
		      " `recipient_id` = ?, " .
		      " `created_at` = ?, " .
		      " `sender_screen_name` = ?, " .
		      " `recipient_screen_name` =?";
   


     my $sth = $dbh->prepare($dm_sql);
     $sth->execute($id, $sender_id, $text, $recipient_id, $created_at, 
	$sender_screen_name, $recipient_screen_name);		  
     
     if ( $utc_offset == "") { $utc_offset = 0; }

     my $sender_sql = "replace into `users` " .
			"SET `id` = ?, " .
			" `name` = ?, " .
			" `screen_name` = ?, " .
			" `description` = ?, " .
			" `location` = ?, " .
			" `profile_image_url` = ?, " .
			" `url` = ?, " .
			" `protected` = ?, " .
			" `followers_count` = ?, " .
			" `friends_count` = ?, " .
			" `created_at` = ?, " .
			" `favourites_count` = ?, " .
			" `utc_offset` = ?, " .
			" `time_zone` = ?, " .
			" `statuses_count` = ?, " .
			" `following` = ?, " .
			" `verified` = ?";

     $sth = $dbh->prepare($sender_sql);
     $sth->execute($user_id, $name, $screen_name, $description, $location, 
			$profile_image_url, $url, $protected, $friends_count, 
			$followers_count, $created_at, $favourites_count,
			$utc_offset, $time_zone, $statuses_count, $following, 
			$verified);

  


     return 1;
};
