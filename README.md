# Smart File Organizer

<div align="center">
  <img src="https://your-image-link.png" alt="Smart File Organizer Logo" width="200">
</div>

## Overview

Smart File Organizer is a powerful script designed to organize large numbers of files in a folder according to their types and creation dates. It's a handy tool that not only categorizes files but also optimizes disk space by removing duplicates.

## Features

- **File Classification**: Automatically sorts files into categories such as images, videos, documents, audio, and compressed files.

- **Organized by Creation Date**: Files are further organized into folders based on their creation dates, providing a structured hierarchy.

- **Duplicate Removal**: Optimizes disk space by identifying and removing duplicate files.

- **User-Friendly**: Easy to use with a simple Bash script that takes a folder name as an argument.

## How It Works

1. **User Input**: Provide the script with the folder name you want to organize.

2. **File Classification**: The script scans the folder for various file types, categorizing them into predefined categories.

3. **Organized Hierarchy**: Files are then moved to a structured hierarchy based on their types and creation dates.

4. **Duplicate Detection**: Duplicate files are identified and removed, ensuring optimal disk space utilization.

5. **Logging**: A detailed log file keeps track of the files moved, ensuring transparency in the organization process.

## Benefits

- **Efficiency**: Quickly organizes and categorizes a large number of files.

- **Disk Optimization**: Identifies and removes duplicate files, optimizing disk space.

- **User-Friendly**: Simple and intuitive script that requires minimal user input.

## Usage

```bash
bash org.sh folder-name
