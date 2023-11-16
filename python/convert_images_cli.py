import os
import shutil
import argparse
from PIL import Image


def convert_images_to_png(directory):
    # Get a list of all files in the directory
    file_list = os.listdir(directory)

    # Processed Directory
    del_dir = os.path.join(directory, "del")
    if not os.path.exists(del_dir):
        os.mkdir(del_dir)

    # Iterate through each file in the directory
    for filename in file_list:
        # Check if the file is a JPEG or JPG image
        if filename.lower().endswith(('.jpg', '.jpeg')):
            # Construct the full path of the image
            image_path = os.path.join(directory, filename)

            # Open the image using PIL (Python Imaging Library)
            with Image.open(image_path) as img:
                # Construct the new filename with the .png extension
                new_filename = os.path.splitext(filename)[0] + ".png"
                new_image_path = os.path.join(directory, new_filename)

                # Save the image in PNG format
                img.save(new_image_path, "PNG")
                # Move original file to del folder
                shutil.move(filename, del_dir)
                # Print a message indicating the conversion
                print(f"Converted {filename} to {new_filename}")


def main():
    # Create an argument parser
    parser = argparse.ArgumentParser(description="Convert JPEG and JPG images in a directory to PNG.")

    # Add a positional argument for the directory
    parser.add_argument("directory", help="The directory containing the images")

    # Parse the command-line arguments
    args = parser.parse_args()

    # Call the function to convert images to PNG
    convert_images_to_png(args.directory)


if __name__ == "__main__":
    main()
