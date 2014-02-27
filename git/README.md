# scripts to manage github projects

---

get all projects

    for p in $(find /d/dev/src/github.com -type d -maxdepth 2 -mindepth 2 | sort); do pushd "$p" > /dev/null; git config --get remote.origin.url; popd > /dev/null; done


---

get all users

    find -type d -maxdepth 1 -mindepth 1 -exec sh -c "cd {}; pwd" \;  > user_list.txt


---

clone projects

- create dir

        cut -d'/' -f6 user_list.txt | xargs mkdir

    or

         awk -F '/' '{print $6}' user_list.txt | xargs mkdir


