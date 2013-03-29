#!/bin/bash

# Chrome (if not on OS X you will need to manually package the extension in chrome://extensions)
cp content_script.js chrome/
rm chrome/Xcode-Stylerizer.crx
rm chrome/Xcode-Stylerizer.pem
/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome --pack-extension=chrome/
mv chrome.crx chrome/Xcode-Stylerizer.crx
mv chrome.pem chrome/Xcode-Stylerizer.pem

# Opera
cp content_script.js opera/includes/
echo "(function() {" > opera/includes/content_script.js.opera
sed -i.bak '1d' opera/includes/content_script.js
rm opera/includes/content_script.js.bak
cat opera/includes/content_script.js >> opera/includes/content_script.js.opera
echo " window.addEventListener('DOMContentLoaded', function() { walk(document.body);}, false);}());" >> opera/includes/content_script.js.opera
rm opera/includes/content_script.js
mv opera/includes/content_script.js.opera opera/includes/content_script.js
cd opera
zip -r Xcode-Stylerizer.oex *
cd ..

# Sarari (you will then need to manually package the extension in Safari > Develop > Show Extension Builder)
cp content_script.js Xcode-Stylerizer.safariextension
