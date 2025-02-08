change the uri/url fo a remote git repository `git remote set-url origin https://github.com/alexandrecuer/emoncms`

see which remote URL you have currently in this local repository: `git remote show origin`

count number of code lines `git ls-files | grep -P ".*(py)" | xargs wc -l`

https://panjeh.medium.com/github-git-tag-release-to-an-old-commit-8fe38ee7167f

pour chercher un pattern dans le code : `git grep pattern`

pour voir les différences : `git diff`

undo last commit not pushed : `git reset --soft HEAD~`

This command undoes the latest commit, keeps the changes in place, and reverts the files back to the staging area.

# permissions problems

maybe this happens if one time you run git as sudo

```
git fetch
Username for 'https://github.com': alexandrecuer
Password for 'https://alexandrecuer@github.com': 
warning: redirecting to https://github.com/alexjunk/BIOS2/
remote: Enumerating objects: 39, done.
remote: Counting objects: 100% (39/39), done.
remote: Compressing objects: 100% (23/23), done.
remote: Total 39 (delta 17), reused 34 (delta 15), pack-reused 0 (from 0)
error: insufficient permission for adding an object to repository database .git/objects
fatal: failed to write object
fatal: unpack-objects failed
```
the solution is to fix permissions manually in the .git folder
```
cd .git/objects
ls -al
sudo chown -R yourname:yourgroup *
```
