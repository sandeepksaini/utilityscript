#### Some GIT Based Commmands:

```bash
yum install git -y
git config --global user.name "SandeepKumar"
git config --global user.email "sandeeprhct@gmail.com"
```

#### To clone the git repo:
```bash
git clone 'repo_name'
```

#### To clone git repo to specific local folder:
```bash
git clone 'repo_name' /dir/name
```
#### Clone of git repo silently:
```bash
git clone 'repo_name' 1>/dev/null 2>&1
```

#### To fetch + merge, run
```bash
git pull
```
#### If you want simply to fetch :
```bash
git fetch
```

#### To stage the file
```bash
git add file_name
```
#### To add comment after staging the file
```
git commit -m "put your Message here"
```
#### To push the file in github repo
```
git push origin master
