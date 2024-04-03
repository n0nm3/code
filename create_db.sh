#!/bin/bash

mariadb -u root <<< "DROP DATABASE IF EXISTS phishing_db; CREATE DATABASE phishing_db; USE phishing_db; CREATE TABLE link(Link_ID int NOT NULL AUTO_INCREMENT primary key, lien varchar(1500));" 
mariadb -u root <<< "DROP USER IF EXISTS user_phishing; CREATE USER 'user_phishing'@'localhost' IDENTIFIED BY 'mdp'; GRANT ALL ON phishing_db.* to 'user_phishing'@'localhost' WITH GRANT OPTION; FLUSH PRIVILEGES;"

file="./ALL-phishing-links.txt"

while IFS= read line
do
    escaped_line=$(printf "%s\n" "$line" | sed "s/'/''/g")
    # va faire insérer $line dans notre bdd
    mariadb -u user_phishing -pmdp <<< "USE phishing_db; INSERT INTO link(lien) VALUES ($line);"
done <"$file"

