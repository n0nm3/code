file="./ALL-phishing-links.txt"
while IFS= read line
do
    # display $line or do something with $line
    echo "$line"
done <"$file"
