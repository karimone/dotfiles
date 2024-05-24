get_context() {
    pcregrep -o1 "{{(.*?)}}" $1 | sed -e 's/^[ \t]*//' | sort -u
}

reduce_mp4() {
  prefix="reduced-"
  crf=28
  preset="medium"
  vf=""
  input=""

  if [ "$1" != "-i" ]; then
    input="$1"
    shift
  fi

  while getopts "hi:p:x:c:f:" opt; do
    case $opt in
    h)
      echo "Usage: reduce_mp4 [-h] [-i input] [-p preset] [-x prefix] [-c crf] [-f vf]"
      echo "Reduces the size of an mp4 video using ffmpeg."
      echo "The reduced file will be saved with the name '[prefix][input_file]'"
      echo "If the prefix is not provided, the default prefix 'reduced-' will be used."
      echo "If the crf is not provided, the default value of 28 will be used."
      echo "If the preset is not provided, the default preset 'medium' will be used."
      echo "Available presets: ultrafast, superfast, veryfast, faster, fast, medium, slow, slower, veryslow."
      echo "If the vf is not provided, no video filters will be applied."
      return 0
      ;;
    i)
      input="$OPTARG"
      ;;
    p)
      preset="$OPTARG"
      ;;
    x)
      prefix="$OPTARG-"
      ;;
    c)
      crf="$OPTARG"
      ;;
    f)
      vf="$OPTARG"
      ;;
    ?)
      echo "Invalid option: -$OPTARG"
      return 1
      ;;
    esac
  done

  if [ -z "$input" ]; then
    echo "Error: missing input file."
    return 1
  fi

  output="${input%.*}.mp4"
  original_file="original_${input}"

  mv "$input" "$original_file"

  ffmpeg -i "$original_file" -v quiet -stats -loglevel error -vcodec libx265 -crf $crf -preset $preset $vf -y "$output"
}

branch_decommit() {
    # decommit the current branch based on the given branch
    if [[ ! ("$#" == 1) ]]; then 
        echo "Provide the base branch to compare the current branch e.g: master"
        return 1
    fi
    git reset $(git merge-base $1 $(git rev-parse --abbrev-ref HEAD))
}


git_last_sha() {
    git rev-parse --verify HEAD;
}

git_fixup() {
    last_sha=$(git_last_sha)
    command="git commit --edit --fixup $last_sha"
    echo "$command"
    sh -c "$command"
}

git_rebase_autosquash() {
    git rebase --autosquash --interactive origin/master
}

get_extension() {
    fullfile=$1
    filename=$(basename -- "$fullfile")
    extension="${filename##*.}"
    echo "$extension"
}

get_filename() {
    fullfile=$1
    filename=$(basename -- "$fullfile")
    filename="${filename%.*}"
    echo "$filename"
}

mp4tomp3() {
    if [ "$#" -eq 0 ]; then 
        echo "Usage:"
        echo "  mp4tomp3 [FILENAME] [DIRECTORY=./]"
        return 1
    else
        directory=${2:-"./"}
        if [ ! -d "$directory" ]; then
            mkdir -p "$directory"
        fi
        filename=$(get_filename "$1")
        cmd="ffmpeg -i $1 $directory/$filename.mp3"
        echo "$cmd"
        sh -c "$cmd"
    fi
}

tstomp3() {
    # convert the ts file in mp3
    if [ "$#" -eq 0 ]; then 
        echo "Usage:"
        echo "  tstomp3 [FILENAME]"
        return 1
    else
        file_to_convert="$1"
        filename=$(get_filename "$file_to_convert")
        cmd="ffmpeg -i $file_to_convert -acodec libmp3lame -ab 128k $filename.mp3"
        echo "$cmd"
        sh -c "$cmd"
    fi
}


tstomp4() {
    # convert the ts file in mp4
    if [ "$#" -eq 0 ]; then 
        echo "Usage:"
        echo "  tstomp4 [FILENAME]"
        return 1
    else
        file_to_convert="$1"
        filename=$(get_filename "$file_to_convert")
        cmd="ffmpeg -i $file_to_convert -v quiet -stats -loglevel error -vcodec libx265 -crf 28 -preset fast -y $filename.mp4"
        echo "$cmd"
        sh -c "$cmd"
    fi
}

all_mp4tomp3() {
    for i in $(ls -1 *.mp4); do; mp4tomp3 "$i"; done
}

all_tstomp4() {
    for i in $(ls -1 *.ts); do; tstomp4 "$i"; done
}

wmvtomp4() {
    # convert the wmw file in mp4
    if [ "$#" -eq 0 ]; then 
        echo "Usage:"
        echo "  $0 [FILENAME]"
        return 1
    else
        file_to_convert="$1"
        filename=$(get_filename "$file_to_convert")
        cmd="ffmpeg -i $file_to_convert -c:v libx264 -crf 23 -c:a aac -q:a 100 $filename.mp4"
        echo "$cmd"
        sh -c "$cmd"
    fi
}


dur() {
    # show duration of a media file
    if [ "$#" -eq 0 ]; then 
        echo "Usage:"
        echo "  dur [FILENAME]"
        return 1
    else
        file="$1"
        mediainfo "$file"| grep "^Duration" | head -n 1 | awk -F':' '{print $2}'
    fi
}


mp4merge() {
    # merge all the mp4 files in the given output file name
    output=$1;
    if [[ -z $output ]];
    then
        echo "Error: missing output file";
    else
        touch __mylist.txt
        for i in $(ls *.mp4)
        do
            echo "file $i" >> __mylist.txt
        done
        ffmpeg -f concat -safe 0 -i __mylist.txt -c copy "$output"
        rm __mylist.txt
    fi
}


# generic python tools

pip-install() {
    pip install "$1" && pip freeze | grep "$1" >> requirements.txt
}

cut_video() {
    file="$1"
    from="$2"
    to="$3"
    filename=$(get_filename "$1")
    extension=$(get_extension "$1")
    out="$filename-cutted.$extension"
    cmd="ffmpeg -i $file -ss $from -to $to -c copy $out"
    echo "$cmd"
}


backup_database() {
    if [[ "$1" == "-h" || "$1" == "--help" ]]; then
      echo "Usage: backup_database <database_name> [path]"
      echo "This script creates a compressed backup of the specified PostgreSQL database with a progress bar"
      echo "If path is provided, backup will be saved at the provided path"
      return 0
    fi

    # Get the name of the database from the first argument
    db_name=$1
    backup_path=$2

    # Get the current date and time
    date_time=$(date +%Y-%m-%d_%H-%M-%S)

    # Create the backup file with the current date and time in the name
    if [[ -z "$backup_path" ]]; then
      pg_dump $db_name | pv | gzip > "$db_name-$date_time.sql.gz"
    else
      if [[ ! -d "$backup_path" ]]; then
        echo "Error: The provided path does not exist"
        return 1
      else
        pg_dump $db_name | pv | gzip > "$backup_path/$db_name-$date_time.sql.gz"
      fi
    fi
}

restore_database() {
    if [[ "$1" == "-h" || "$1" == "--help" ]]; then
      echo "Usage: restore_database <database_name> <backup_path>"
      echo "This script restores a PostgreSQL database from a compressed backup file"
      return 0
    fi

    # Get the name of the database and the path of the backup file from the arguments
    db_name=$1
    backup_path=$2

    # check if the provided database already exist
    if psql -lqt | cut -d \| -f 1 | grep -qw $db_name; then
        read -p "The database $db_name already exists, do you want to overwrite it (y/n)? " -n 1 -r
        echo   
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            if [[ ! -f "$backup_path" ]]; then
                echo "Error: The provided backup file path does not exist"
                return 1
            elif [[ ! -n "$db_name" ]]; then
                echo "Error: The provided database name is not valid"
                return 1
            else
                # Restore the database from the backup file
                dropdb "$dbname"
                createdb "$dbname"
                gunzip -c "$backup_path" | psql -d $db_name
            fi
        else
            echo "Database restore canceled"
        fi
    else
        if [[ ! -f "$backup_path" ]]; then
            echo "Error: The provided backup file path does not exist"
            return 1
        elif [[ ! -n "$db_name" ]]; then
            echo "Error: The provided database name is not valid"
            return 1
        else
            # Restore the database from the backup file
            gunzip -c "$backup_path" | psql -d $db_name
        fi
    fi
}

list_databases() {
    if [[ "$1" == "-h" || "$1" == "--help" ]]; then
      echo "Usage: list_databases"
      echo "This script lists all local PostgreSQL databases with their size in human-readable format and the number of tables"
      return 0
    fi

    # Get the list of all databases
    databases=`psql -l | tail -n +4 | head -n -5 | awk '{print $1}' | grep -vE '^List|^Name|template[0|1]|\(|\|'`

    # Print the table header
    printf "\033[1;32m%-20s %-20s %-20s\033[m\n" "Database" "Size" "Tables"

    # Loop through the databases
    for db in $databases; do
        # Get the size of the database in bytes
        echo "connecting to $db"
        size=`psql -d $db -c "SELECT pg_size_pretty(pg_database_size('$db'));" -t`
        # Get the number of tables in the database
        tables=`psql -d $db -c "SELECT count(*) FROM information_schema.tables WHERE table_schema NOT LIKE 'pg_%' AND table_schema != 'information_schema';" -t`
        # Print the database name, size, and number of tables
        printf "\033[1;34m%-20s\033[m %-20s %-20s\n" $db "$size" "$tables"
    done
}


add_prefix() {
    # Assign the input parameters to variables
    prefix=$1
    regex=$2

    # Use the for loop to iterate through all files that match the regex
    for file in $regex; do
        # Rename the file by adding the prefix
        mv "$file" "${prefix}${file}"
    done
}


get_media_info() {
  file="$1"
  size=$(du -h "$file" | awk '{print $1}')
  duration=$(ffmpeg -i "$file" 2>&1 | grep "Duration" | awk '{print $2}' | tr -d ',')
  audio_format=$(ffmpeg -i "$file" 2>&1 | grep "Audio:")
  video_format=$(ffmpeg -i "$file" 2>&1 | grep "Video:")
  echo "File size: $size"
  echo "Duration: $duration"
  if [ -n "$audio_format" ]; then
    echo "Audio: $audio_format"
  fi
  if [ -n "$video_format" ]; then
    echo "Video: $video_format"
  fi
} 

merge_videos() {
    local output_file=""
    local input_list=()

    while getopts "o:i:" opt; do
        case $opt in
            o) output_file="$OPTARG" ;;
            i) IFS=',' read -ra input_list <<< "$OPTARG" ;;
            *) echo "Usage: $(basename "$0") -o <output_file.mp4> -i <input1.mp4,input2.mp4,...>"; exit 1 ;;
        esac
    done

    # Check if an output file name and at least one input file are provided
    if [[ -z $output_file ]] || [[ ${#input_list[@]} -eq 0 ]]; then
        echo "Error: Provide an output file name and at least one input file."
        exit 1
    fi

    # Create a concatenated file list for ffmpeg
    file_concat=$(printf "file '%s'\n" "${input_list[@]}")

    # Create a list file for ffmpeg input
    list_file=$(mktemp "${TMPDIR:-/tmp}/list.txt")
    echo -e "$file_concat" > "$list_file"

    # Perform concatenation using ffmpeg
    ffmpeg -f concat -safe 0 -i "$list_file" -c copy "$output_file"

    # Clean up temporary files
    rm "$list_file"

    echo "Merge completed. The output file is '$output_file'."
}
