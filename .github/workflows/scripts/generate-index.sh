#!/bin/bash
# Script to generate index.html for top-level directories

set -e

OUTPUT_FILE="index.html"

echo "Generating $OUTPUT_FILE..."

# Get all top-level directories (excluding hidden folders and .git)
dirs=$(find . -maxdepth 1 -type d ! -name '.*' ! -name '.' | sed 's|^\./||' | sort)

# Start HTML file
cat <<EOF > "$OUTPUT_FILE"
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Site Directory</title>
<style>
* {
  margin: 0;
  padding: 0;
  box-sizing: border-box;
}

body {
  font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, Cantarell, sans-serif;
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  min-height: 100vh;
  padding: 40px 20px;
  display: flex;
  align-items: center;
  justify-content: center;
}

.container {
  background: white;
  border-radius: 16px;
  box-shadow: 0 20px 60px rgba(0, 0, 0, 0.3);
  max-width: 600px;
  width: 100%;
  padding: 48px;
  animation: fadeIn 0.5s ease-in;
}

@keyframes fadeIn {
  from {
    opacity: 0;
    transform: translateY(20px);
  }
  to {
    opacity: 1;
    transform: translateY(0);
  }
}

h1 {
  text-align: center;
  color: #2d3748;
  margin-bottom: 12px;
  font-size: 32px;
  font-weight: 700;
}

.subtitle {
  text-align: center;
  color: #718096;
  margin-bottom: 40px;
  font-size: 16px;
}

.directory-list {
  list-style: none;
}

.directory-item {
  margin-bottom: 12px;
  animation: slideIn 0.3s ease-out forwards;
  opacity: 0;
}

@keyframes slideIn {
  to {
    opacity: 1;
  }
}

.directory-item:nth-child(1) { animation-delay: 0.1s; }
.directory-item:nth-child(2) { animation-delay: 0.15s; }
.directory-item:nth-child(3) { animation-delay: 0.2s; }
.directory-item:nth-child(4) { animation-delay: 0.25s; }
.directory-item:nth-child(5) { animation-delay: 0.3s; }
.directory-item:nth-child(n+6) { animation-delay: 0.35s; }

.directory-link {
  display: flex;
  align-items: center;
  padding: 16px 20px;
  background: #f7fafc;
  border-radius: 10px;
  text-decoration: none;
  color: #2d3748;
  font-size: 18px;
  font-weight: 500;
  transition: all 0.2s ease;
  border: 2px solid transparent;
}

.directory-link:hover {
  background: #edf2f7;
  border-color: #667eea;
  transform: translateX(8px);
  box-shadow: 0 4px 12px rgba(102, 126, 234, 0.15);
}

.directory-icon {
  width: 24px;
  height: 24px;
  margin-right: 16px;
  fill: #667eea;
}

.count {
  text-align: center;
  margin-top: 32px;
  color: #a0aec0;
  font-size: 14px;
}
</style>
</head>
<body>
<div class="container">
  <h1>📂 Site Directory</h1>
  <p class="subtitle">Browse available directories</p>
  <ul class="directory-list">
EOF

# Add folders as links with icons
count=0
for dir in $dirs; do
  echo "<li class=\"directory-item\"><a href=\"$dir/\" class=\"directory-link\"><svg class=\"directory-icon\" xmlns=\"http://www.w3.org/2000/svg\" viewBox=\"0 0 24 24\"><path d=\"M10 4H4c-1.1 0-1.99.9-1.99 2L2 18c0 1.1.9 2 2 2h16c1.1 0 2-.9 2-2V8c0-1.1-.9-2-2-2h-8l-2-2z\"/></svg>$dir</a></li>" >> "$OUTPUT_FILE"
  count=$((count + 1))
done

# Close HTML
cat <<EOF >> "$OUTPUT_FILE"
  </ul>
  <p class="count">$count $([ $count -eq 1 ] && echo "directory" || echo "directories") available</p>
</div>
</body>
</html>
EOF

echo "$OUTPUT_FILE generated successfully!"
