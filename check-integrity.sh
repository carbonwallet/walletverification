THEREPO="carbonwallet"
THESITE="carbonwallet.com"

# Create some temprary directories
REPOS="$(mktemp -d)"
WEBSITE="$(mktemp -d)"
TARS="$(mktemp -d)"

# Get the git repository
git clone --quiet git://github.com/$THEREPO/$THEREPO.github.io.git $REPOS

# remove stuff that doesn't get deployed by the web.
rm -rf $REPOS/.git
rm -rf $REPOS/README.md
rm -rf $REPOS/CNAME

# Get the website
wget -r -q http://$THESITE -P $WEBSITE

ls -la $WEBSITE/$THESITE
ls -la $REPOS

# Perform the check

if diff -r $WEBSITE/$THESITE $REPOS; then
  echo "$THESITE matches the github repository."
else
  echo "$WEBSITE does not match the github repo."
fi

# Remove folders
rm -rf $REPOS
rm -rf $WEBSITE
rm -rf $TARS
