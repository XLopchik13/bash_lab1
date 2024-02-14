resolution=$1
directory=$2

if [ -z "$resolution" ] || [ -z "$directory" ]; then
    echo "Usage: $0 <resolution> <directory>"
    exit 1
fi

if ! command -v convert &> /dev/null; then
    echo "ImageMagick is not installed. Please install it first."
    exit 1
fi

if [ ! -d "$directory" ]; then
    echo "Directory does not exist."
    exit 1
fi

count=0
total=$(find "$directory" -maxdepth 1 -type f -iname "*.jpg" | wc -l)

for file in "$directory"/*.jpg; do
    filename=$(basename "$file")
    filename_noext="${filename%.*}"
    new_filename="${filename_noext}-${resolution}.jpg"
    
    convert "$file" -resize "$resolution" "$directory/$new_filename"
    
    count=$((count+1))
    echo "Processed $count out of $total images."
done

echo "All images processed."
