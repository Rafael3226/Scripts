param (
    [string]$directory
)

# Check if the directory parameter is provided
if (-not $directory) {
    Write-Host "Usage: convert_images.ps1 -directory <path_to_directory>"
    Exit
}

# Resolve the full path of the Python script
$pythonScript = Join-Path -Path $PSScriptRoot -ChildPath "python\convert_images_cli.py"


# Check if the Python script exists
if (-not (Test-Path $pythonScript)) {
    Write-Host "Error: Python script not found."
    Exit
}

# Execute the Python script with the provided directory parameter
python $pythonScript $directory
