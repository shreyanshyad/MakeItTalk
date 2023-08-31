#!/bin/bash

source venv/bin/activate

echo "Starting the script..."

# Check if the correct number of arguments is provided
if [ $# -ne 1 ]; then
    echo "Usage: $0 <filepath>"
    exit 1
fi

# Get the filepath argument
filepath="$1"
echo "Input file: $filepath"

# Create a temp folder if it doesn't exist
temp_folder="./temp"
echo "Creating temporary folder: $temp_folder"
mkdir -p "$temp_folder"
mkdir -p "$temp_folder/output"

# Get the filename from the filepath
filename=$(basename "$filepath")
extension="${filename##*.}"

# Copy the file to the temp folder
temp_filepath="$temp_folder/$filename"
echo "Copying the file to temporary folder: $temp_filepath"
cp "$filepath" "$temp_filepath"

# Extract face
output_folder="$temp_folder/output"
echo "Extracting face from: $temp_filepath"
python face-extractor/extract.py --input "$temp_filepath" --output "$output_folder"

filename_no_ext="${filename%.*}"

resized_image_path="temp/output/${filename_no_ext}_1.jpg"

if [ ! -f "$resized_image_path" ]; then
    echo "Error: Resized image not found at path: $resized_image_path"
    exit 1
fi

filename="${filename_no_ext}.jpg"

resized_image_dest="temp/output/${filename}"
echo "Resizing image: $resized_image_path"
python img_resize.py "$resized_image_path" "$resized_image_dest"

cp "$resized_image_dest" "./examples"

end2end_script_image="${filename}"
echo "Running main end-to-end script with image: $end2end_script_image"
python main_end2end.py --jpg "$end2end_script_image"

input_video="examples/${filename_no_ext}_pred_fls_M6_04_16k_audio_embed.mp4"
output_video="./${filename_no_ext}.mp4"
echo "Cropping video: $input_video"
python vid_crop.py "$input_video" "$output_video"

echo "Script execution complete!"