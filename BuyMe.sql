CREATE DATABASE IF NOT EXISTS BuyMe;
USE BuyMe;

CREATE TABLE IF NOT EXISTS users(
username varchar(30),
password varchar(30),
name varchar(50),
acct_type varchar(5),
primary key(usersusername));
