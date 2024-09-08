while read url; do
  filename=$(basename "$url" | sed 's/[^a-zA-Z0-9]/_/g').txt
  wget -q -O - "$url" | html2text > "$filename"
done < transcript-urls.txt