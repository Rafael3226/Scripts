param (
    [Parameter(Mandatory = $true)]
    [string]$projectName
)

if ([string]::IsNullOrWhiteSpace($projectName)) {
    Write-Host "Usage: ts-init <project-name>"
    exit 1
}

# Create a new directory for your project
New-Item -ItemType Directory -Name $projectName
Set-Location $projectName

# Initialize a new npm project
npm init -y

# Install TypeScript and ts-node as development dependencies
npm install typescript ts-node eslint prettier jest --save-dev

# Initialize a TypeScript configuration file (tsconfig.json)
npx tsc --init
# Initialize ESLint configuration
npx eslint --init
# Initialize Jest configuration
npx jest --init

# Configure ESLint and Prettier settings in package.json
npm set-script format "prettier --write ."
# Configure test script in package.json
npm set-script test "jest"
# Configure Build script in package.json
npm set-script dev "ts-node ./src/main.ts"

# Read the JSON file
$jsonFilePath = "package.json"
$jsonContent = Get-Content $jsonFilePath -raw | ConvertFrom-Json
# Update the value
$jsonContent.scripts.dev = "ts-node ./src/main.ts"
$jsonContent.scripts.format = "prettier --write ."
# Convert the updated JSON object back to a JSON string and back to the file
$jsonContent | ConvertTo-Json | Set-Content $jsonFilePath


# Create a source directory for your TypeScript files
New-Item -ItemType Directory -Name src
# Create a simple TypeScript file for testing
Set-Content -Path .\src\main.ts -Value "function main() {console.log('Hello TS');} main();"

# Format
npm run format

# Initialize a Git repository
git init
# Create a .gitignore file to exclude unnecessary files from version control
Set-Content -Path .gitignore -Value "node_modules/"
# Commit the updated project setup
git add .
git commit -m "Initial project setup with TypeScript, ESLint, Prettier, and Jest"

# Display success message
Write-Host "Project '$projectName' has been set up successfully."

# Open VS Code
code .
