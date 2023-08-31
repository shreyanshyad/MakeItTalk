import sys
from PIL import Image

def resize_image(input_path, output_path, new_size):
    try:
        image = Image.open(input_path)
        resized_image = image.resize(new_size)
        resized_image.save(output_path)
        print(f"Image resized and saved as {output_path}")
    except Exception as e:
        print("An error occurred:", e)

if __name__ == "__main__":
    if len(sys.argv) != 3:
        print("Usage: python resize_image.py input_image_path output_image_path")
    else:
        input_path = sys.argv[1]
        output_path = sys.argv[2]
        new_size = (256, 256)
        resize_image(input_path, output_path, new_size)
