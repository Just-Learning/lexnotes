# download subtitle for a list of youtube videos, and use video id as filename

yt-dlp --skip-download --write-auto-subs --write-subs --sub-lang en --convert-subs srt \
--batch-file video-urls.txt --output "%(id)s.%(ext)s" --exec "sed '/^[0-9]/d; /^$/d' {} > %(id)s.txt" --verbose