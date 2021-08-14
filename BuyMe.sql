CREATE DATABASE IF NOT EXISTS BuyMe;
USE BuyMe;

CREATE TABLE IF NOT EXISTS users (
  username varchar(30) NOT NULL DEFAULT '',
  password varchar(30) NOT NULL DEFAULT '',
  name varchar(50) DEFAULT NULL,
  acct_type varchar(5) DEFAULT NULL,
  PRIMARY KEY(username));

INSERT INTO users
VALUES ("admin","adminpass","Steve","admin");

CREATE TABLE IF NOT EXISTS items (
  item_id int DEFAULT 0,
  name varchar(50) DEFAULT NULL,
  item_condition varchar(30) DEFAULT NULL,
  manufacturing_location varchar(30) DEFAULT NULL,
  brand varchar(30) DEFAULT NULL,
  color varchar(30) DEFAULT NULL,
  design varchar(30) DEFAULT NULL,
  material varchar(30) DEFAULT NULL,
  quantity int DEFAULT 0,
  PRIMARY KEY(item_id));

CREATE TABLE IF NOT EXISTS auctions (
  seller varchar(30) NOT NULL DEFAULT '',
  auction_id int DEFAULT 0,
  item_id int DEFAULT 0,
  reserve_price decimal(9,2) DEFAULT NULL,
  current_price decimal(9,2) DEFAULT NULL,
  start_date datetime DEFAULT NOW(),
  end_date datetime DEFAULT NULL,
  PRIMARY KEY(auction_id),
  CONSTRAINT fk_itemid_items FOREIGN KEY(item_id) references items(item_id));
  
CREATE TABLE IF NOT EXISTS shirts (
  item_id int DEFAULT 0,
  child bool DEFAULT NULL,
  shirt_size varchar(3) DEFAULT NULL,
  gender varchar(6) DEFAULT NULL,
  PRIMARY KEY(item_id),
  CONSTRAINT fk_shirts_item_id FOREIGN KEY(item_id) references items(item_id) ON DELETE CASCADE);
  
CREATE TABLE IF NOT EXISTS pants (
  item_id int DEFAULT 0,
  child bool DEFAULT NULL,
  pants_size varchar(3) DEFAULT NULL,
  pants_type varchar(30) DEFAULT NULL,
  style varchar(30) DEFAULT NULL,
  gender varchar(6) DEFAULT NULL,
  PRIMARY KEY(item_id),
  CONSTRAINT fk_pants_item_id FOREIGN KEY(item_id) references items(item_id) ON DELETE CASCADE);
  
CREATE TABLE IF NOT EXISTS footwear (
  item_id int DEFAULT 0,
  child bool DEFAULT NULL,
  shoe_size decimal(3,1) DEFAULT NULL,
  width varchar(6) DEFAULT NULL,
  in_sole bool DEFAULT NULL,
  securing_method varchar(30) DEFAULT NULL,
  purpose varchar(30) DEFAULT NULL,
  gender varchar(6) DEFAULT NULL,
  PRIMARY KEY(item_id),
  CONSTRAINT fk_footwear_item_id FOREIGN KEY(item_id) references items(item_id) ON DELETE CASCADE);

CREATE TABLE IF NOT EXISTS alerts (
  username varchar(30) NOT NULL DEFAULT '',
  alert_message varchar(100) NOT NULL DEFAULT '', 
  alert_type varchar(10) DEFAULT NULL,
  PRIMARY KEY(username,alert_message),
  CONSTRAINT fk_alerts_user FOREIGN KEY(username) REFERENCES users(username));

CREATE TABLE IF NOT EXISTS autoBid (
  username varchar(30) NOT NULL DEFAULT '',
  auction_id int DEFAULT 0,
  active_status bool DEFAULT NULL, 
  highest_price decimal(9,2) DEFAULT NULL,
  time_interval time DEFAULT NULL,
  PRIMARY KEY(username,auction_id),
  CONSTRAINT fk_autoBid_user FOREIGN KEY(username) REFERENCES users(username),
  CONSTRAINT fk_autoBid_item FOREIGN KEY(auction_id) REFERENCES auctions(auction_id));

CREATE TABLE IF NOT EXISTS bidOn (
  username varchar(30) NOT NULL,
  auction_id int DEFAULT 0,
  date datetime NOT NULL,
  amount decimal(9, 2) DEFAULT 0,
  PRIMARY KEY(username, auction_id,date),
  CONSTRAINT fk_bidOn_user FOREIGN KEY(username) REFERENCES users(username),
  CONSTRAINT fk_bidOn_auction FOREIGN KEY(auction_id) REFERENCES auctions(auction_id));

CREATE TABLE IF NOT EXISTS ask (
  customer_username varchar(30) NOT NULL DEFAULT '',
  representative_username varchar(30) NOT NULL DEFAULT '',
  date datetime NOT NULL,
  question varchar(200) DEFAULT NULL,
  answer varchar(200) DEFAULT NULL,
  PRIMARY KEY(customer_username,representative_username,date),
  CONSTRAINT fk_ask_customer FOREIGN KEY(customer_username) REFERENCES users(username),
  CONSTRAINT fk_ask_representative FOREIGN KEY(representative_username) REFERENCES users(username));

CREATE TABLE IF NOT EXISTS sold (
  seller varchar(30) NOT NULL DEFAULT '',
  buyer varchar(30) NOT NULL DEFAULT '',
  auction_id int DEFAULT 0,
  final_price decimal(9,2) DEFAULT NULL,
  PRIMARY KEY(seller,auction_id),
  CONSTRAINT fk_sold_auction FOREIGN KEY(auction_id) REFERENCES auctions(auction_id),
  CONSTRAINT fk_sold_auction FOREIGN KEY(seller) REFERENCES users(username));
