THEREPO="carbonwallet"
THESITE="carbonwallet.com"

# Create some temprary directories
REPOS="$(mktemp -d)"
WEBSITE="$(mktemp -d)"
TARS="$(mktemp -d)"

# Get the git repository
git clone --quiet git://github.com/$THEREPO/$THEREPO.github.io.git $REPOS

# remove files from the repo download that don't get deployed by the web.
# we are only intersted in what goes to the browser
rm -rf $REPOS/.git
rm -rf $REPOS/README.md
rm -rf $REPOS/CNAME
rm -rf $REPOS/js/background.js
rm -rf $REPOS/manifest.json
rm -rf $REPOS/images/icons
rm -rf $REPOS/font

# Get the website
wget -r -q http://$THESITE -P $WEBSITE

# We have to ignore fonts as I never know which will load
rm -rf $WEBSITE/$THESITE/font

# Perform the check

if diff -r $WEBSITE/$THESITE $REPOS; then
  echo "$THESITE matches the github repository."
else
  echo "$THESITE does not match the github repo."
fi

# Remove folders
rm -rf $REPOS
rm -rf $WEBSITE
rm -rf $TARS
