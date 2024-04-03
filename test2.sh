file="./ALL-phishing-links.txt"

while IFS= read line
do
    escaped_line=$(printf "%s\n" "$line" | sed "s/'/''/g")
    # va faire insérer $line dans notre bdd
    #echo $line
    mariadb -u user_phishing -pmdp <<< "USE phishing_db; INSERT INTO link(lien) VALUES ('$escaped_line');"
    #mariadb -u user_phishing -pmdp <<< "USE phishing_db; INSERT INTO lien (lien) VALUES ("$line");"
done <"$file" 
