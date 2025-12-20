#!/bin/bash
# Script to generate index.html for top-level directories

set -e

OUTPUT_FILE="index.html"

echo "Generating $OUTPUT_FILE..."

# Get all top-level directories (excluding .git)
dirs=$(find . -maxdepth 1 -type d ! -name '.git' ! -name '.' | sed 's|^\./||')

# Start HTML file
cat <<EOF > "$OUTPUT_FILE"
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Site Landing Page</title>
<style>
body { font-family: Arial, sans-serif; padding: 40px; background: #f4f4f4; }
h1 { text-align: center; }
ul { list-style: none; padding: 0; max-width: 400px; margin: 0 auto; }
li { margin: 10px 0; }
a { text-decoration: none; color: #007bff; font-size: 18px; }
a:hover { text-decoration: underline; }
</style>
</head>
<body>
<h1>Site Landing Page</h1>
<ul>
EOF

# Add folders as links
for dir in $dirs; do
  echo "<li><a href=\"$dir/\">$dir</a></li>" >> "$OUTPUT_FILE"
done

# Close HTML
cat <<EOF >> "$OUTPUT_FILE"
</ul>
</body>
</html>
EOF

echo "$OUTPUT_FILE generated successfully!"
