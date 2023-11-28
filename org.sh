if [[ $# -ne 1 ]]; then
    echo "Use: bash org.sh folder-name "
fi

folder=$1
findF=$(find / -name "$folder")

if [[ -z $findF ]]; then
    echo "folder not exist!"
    exit
fi

image_extensions=".jpeg,.jpg,.png,.gif,.bmp,.tiff,.tif,.webp,.svg,.raw"
video_extensions=".mp4,.mkv,.avi,.mov,.wmv,.flv,.webm,.mpeg,.mpg,.3gp,.rm,.rmvb,.m4v,.ts,.ogv,.vob"
doc_extensions=".doc,.docx,.pdf,.ppt,.pptx,.odt,.xls,.xlsx,.odp,.ods,.txt,.rtf,.csv,.html,.htm"
audio_extensions=".mp3,.wav,.ogg,.flac,.aac,.wma,.m4a,.opus,.amr,.aiff"
compressed_extensions=".zip,.tar,.tar.gz,.tar.bz2,.tar.xz,.gz,.bz2,.rar,.7z,.xz"

echo "listing all files -- please wait!"
sudo find "$folder" -type f > /tmp/all_files.txt

m=0

sort_files() {
    type=$1
    shift
    extensions=$(echo $* | tr ',' ' ')

    for ext in $extensions; do
        grep $ext /tmp/all_files.txt >> /tmp/found.txt
        Upper_ext=$(echo $ext | tr '[:lower:]' '[:upper:]')
        grep $Upper_ext /tmp/all_files.txt >> /tmp/found.txt

        grep -v $ext /tmp/all_files.txt > /tmp/remain.txt
        grep -v $Upper_ext /tmp/remain.txt > /tmp/all_files.txt
    done

    nb=$(wc -l /tmp/found.txt | awk -F' ' '{print $1}')
    echo "$type found: $nb"

    if [[ -s /tmp/found.txt ]]; then
        if [[ ! -d "$folder/$type" ]]; then
            mkdir "$folder/$type"
        fi

        while read -r line; do
            # get the file year
            year=$(ls -la --time-style=+%Y "$line" | tr -s ' ' | awk '{print $6}')
            # get the name
            name=$(basename "$line")
            # create the year folder
            if [[ -e "$folder/$type/$year" ]]; then
                mkdir "$folder/$type/$year"
            fi

            # check file existence
            if [[ ! -f "$folder/$type/$year/$name" ]]; then
                # move file
                echo "moving $line ..." >> "$folder/log.txt"
                mv "$line" "$folder/$type/$year"
                let m=m+1
            else
                # check the size
                size=$(stat -c %s "$line")
                sizep=$(stat -c %s "$folder/$type/$year/$name")

                if [[ $size -ne $sizep ]]; then
                    # move and rename file
                    echo "moving $line ..." >> "$folder/log.txt"
                    mv "$line" "$folder/$type/$year/$sizep$name"
                    let m=m+1
                else
                    echo "file $line is duplicated" >> "$folder/log.txt"
                fi
            fi
        done < /tmp/found.txt
    fi

    rm /tmp/found.txt
}

sort_files picture $image_extensions
sort_files video $video_extensions

# delete empty folders

 find "$folder" -type d -empty -delete

# display statistics
echo "-----------------------------"
echo "$m files moved"

# delete files
rm /tmp/all_files.txt
rm /tmp/remain.txt


