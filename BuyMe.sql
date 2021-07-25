CREATE TABLE IF NOT EXISTS users (
  username varchar(30) NOT NULL DEFAULT '',
  password varchar(30) NOT NULL DEFAULT '',
  name varchar(50),
  acct_type varchar(5),
  PRIMARY KEY(username));

CREATE TABLE IF NOT EXISTS auction (
  auction_id int,
  reserve_price decimal(9,2),
  current_price decimal(9,2),
  start_date datetime,
  end_date datetime,
  price_increment decimal(9,2),
  bid_interval decimal(9,2),
  upper_limit decimal(9,2),
  PRIMARY KEY(auction_id));

CREATE TABLE IF NOT EXISTS item (
  item_id int,
  name varchar(50),
  item_condition varchar(30),
  manufacturing_location varchar(30),
  brand varchar(30),
  color varchar(30),
  design varchar(30),
  material varchar(30),
  PRIMARY KEY(item_id));
  
CREATE TABLE IF NOT EXISTS shirts (
  item_id int,
  child bool,
  shirt_size varchar(3),
  gender varchar(6),
  PRIMARY KEY(item_id),
  CONSTRAINT fk_item_id FOREIGN KEY(item_id) references item(item_id));
  
CREATE TABLE IF NOT EXISTS pants (
  item_id int,
  child bool,
  pants_size varchar(3),
  pants_type varchar(30),
  style varchar(30),
  gender varchar(6),
  PRIMARY KEY(item_id),
  CONSTRAINT fk_item_id FOREIGN KEY(item_id) references item(item_id));
  
CREATE TABLE IF NOT EXISTS footwear (
  item_id int,
  child bool,
  shoe_size decimal(3,1),
  width varchar(3),
  in_sole bool,
  securing_method varchar(30),
  purpose varchar(30),
  gender varchar(6),
  PRIMARY KEY(item_id),
  CONSTRAINT fk_item_id FOREIGN KEY(item_id) references item(item_id));

CREATE TABLE IF NOT EXISTS alerts(
  username varchar(30),
  item_id int, 
  price_min decimal(9,2),
  price_max decimal(9,2),
  PRIMARY KEY(username,item_id),
  CONSTRAINT fk_alerts_user FOREIGN KEY(username) REFERENCES user(username),
  CONSTRAINT fk_alerts_item FOREIGN KEY(item_id) REFERENCES item(item_id));

CREATE TABLE IF NOT EXISTS autoBid(
  username varchar(30),
  auction_id int,
  active_status bool, 
  highest_price decimal(9,2),
  time_interval time,
  PRIMARY KEY(username,auction_id),
  CONSTRAINT fk_autoBid_user FOREIGN KEY(username) REFERENCES user(username),
  CONSTRAINT fk_autoBid_item FOREIGN KEY(auction_id) REFERENCES auction(auction_id));

CREATE TABLE IF NOT EXISTS bidOn(
  username varchar(30),
  date datetime,
  auction_id int,
  PRIMARY KEY(username, auction_id,date),
  CONSTRAINT fk_bidOn_user FOREIGN KEY(username) REFERENCES user(username),
  CONSTRAINT fk_bidOn_auction FOREIGN KEY(auction_id) REFERENCES auction(auction_id));

CREATE TABLE IF NOT EXISTS asks(
  customer_username varchar(30),
  representative_username varchar(30),
  date datetime,
  question varchar(200),
  answer varchar(200),
  PRIMARY KEY(customer_username,representative_username,date),
  CONSTRAINT fk_asks_customer FOREIGN KEY(customer_username) REFERENCES user(username),
  CONSTRAINT fk_asks_representative FOREIGN KEY(representative_username) REFERENCES user(username));

CREATE TABLE IF NOT EXISTS sells(
  username varchar(30),
  auction_id int,
  final_price decimal(9,2),
  PRIMARY KEY(username,auction_id),
  CONSTRAINT fk_sells_user FOREIGN KEY(username) REFERENCES user(username),
  CONSTRAINT fk_sells_auction FOREIGN KEY(auction_id) REFERENCES auction(auction_id));

CREATE TABLE IF NOT EXISTS beingSold(
  auction_id int,
  PRIMARY KEY(auction_id),
  CONSTRAINT fk_beingSold_auction FOREIGN KEY(auction_id) REFERENCES auction(auction_id));
