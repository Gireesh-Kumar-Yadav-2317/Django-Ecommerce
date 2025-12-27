#!/bin/bash
# Fix broken url() references in jQuery UI CSS

CSS_FILE="static_in_env/vendor/jqueryui/jquery-ui.css"

echo "Fixing $CSS_FILE ..."

# Remove stray quotes after .png
sed -i 's/\.png");/\.png);/g' "$CSS_FILE"

# Also fix any url("images/...) to url(images/...)
sed -i 's/url("images\//url(images\//g' "$CSS_FILE"

echo "✅ Done. Check the file and re-run collectstatic."

