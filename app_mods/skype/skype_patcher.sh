#!/bin/bash

#npm install -g asar

SKYPEPATH=/usr/share/skypeforlinux/resources

rm -Rf $SKYPEPATH/app
asar extract $SKYPEPATH/app.asar $SKYPEPATH/app
chown -R $USER:$USER $SKYPEPATH/app
mv $SKYPEPATH/app.asar $SKYPEPATH/app.asar.backup

# write badge count into a file
BADGEPATCH="
        const fs = require('fs');
        const path = require('path');
        const os = require('os');
        const badgeFile = path.join(os.homedir(), '.config', 'skypeforlinux', 'badge_count');
        fs.writeFile(badgeFile, count, (err) => {});"
BADGEPATCH_ESCAPED=$(printf '%s\n' "$BADGEPATCH" | sed 's:[\/&]:\\&:g;$!s/$/\\/')

sed -i "/this\._trayBadgeCount = count;/a $BADGEPATCH_ESCAPED" $SKYPEPATH/app/tray/SkypeTray.js
