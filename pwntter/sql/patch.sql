ALTER TABLE `pwntter`.`users` CHANGE COLUMN `followers_count` `followers_count` BIGINT(20) NULL DEFAULT '0'  , CHANGE COLUMN `friends_count` `friends_count` BIGINT(20) NULL DEFAULT '0'  ;
ALTER TABLE `pwntter`.`users` CHANGE COLUMN `favourites_count` `favourites_count` BIGINT(20) NULL DEFAULT '0'  ;
ALTER TABLE `pwntter`.`users` CHANGE COLUMN `statuses_count` `statuses_count` BIGINT(20) NULL  ;
