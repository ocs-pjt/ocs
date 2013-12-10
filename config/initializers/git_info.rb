GIT_TAG = `git for-each-ref refs/tags --sort=-authordate --format='%(refname)' --count=1`.split("/").last
GIT_BRANCH = `git status | sed -n 1p`.split(" ").last
GIT_COMMIT = `git log | sed -n 1p`.split(" ").last