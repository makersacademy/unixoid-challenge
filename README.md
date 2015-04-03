[![Gem Version](https://badge.fury.io/rb/unixoid-challenge.svg)](http://badge.fury.io/rb/unixoid-challenge)

Unixoid Challenge
=================

Instructions
------------

* Test time: 1 hour (you can take longer, don’t worry)
* You will need to have [RVM](https://github.com/makersacademy/pre_course/blob/master/pills/installing_rvm.md) configured if you're using a mac and be using a version of Ruby that is not the default. 
* Feel free to use google, your notes, books, etc. but work on your own
* Obviously don't use Sublime Text, Finder or similar tools – only the command-line
* You'll almost certainly need to Google some things. This is deliberate.
* Upon completion of this challenge (or any time you are taking a break), please use the `history` command to see a list of the commands you have made on the command line.  If you save these details into a text file they can be a useful reference.

Tasks:
------

First navigate on the command line to your Desktop directory, and then create a temporary directory using the following command:

```sh
mkdir temp
```

Then change into that directory using this next command:

```sh
cd temp
```

Checking and submitting your progress
-------------------------------------

First, you will need to install the `unixoid-challenge` gem, like this:

```sh
gem install unixoid-challenge
```

At any point while going through the challenge you can check your progress by running:

```sh
unixoid-challenge
```

We recommend running this after each task to make sure you're on the right track.
__(make sure you are in the temp directory when you run "unixoid-challenge")__

This will tell you if you've completed the task, or which of the tasks above you still need to complete. It will also submit your results to GitHub (you'll need your username and password that you use to login to GitHub) so we can track your progress.

Now use your command line skills to complete the following:

1. Using one command, create a directory structure "my/private/files"
2. Using one command, create a directory structure "my/public/files"
3. Create an empty file 't-vars.env' in my/private/files
4. Using command-line only add the line "List of env vars that begin with T" to the file, make sure it ends with a newline
5. List all env variables that begin with "T" (hint: you'll need a regex that includes the marker of the start of the line) and append them to the end of the file
6. Export a new variable TESTING_MAKERS=working in such a way that it is still available when you open a new shell
7. Open a new terminal window, check that a new variable is available
8. Output the count of the variables that begin with T to a new file my/public/files/t-vars.count, e.g. "Overall count: 5" (hint: you'll need to use 'command substitution' in bash)
9. Change the permissions of the my/private/files/t-vars.env to make sure that only the owner can read and write the file
10. Change the permissions of the my/private/files directory to make sure that only the owner can change into it
11. Give read and write permissions to all users on my/public/files/t-vars.count
12. Create another file my/public/files/text-files-count.txt and output the number of text files in your home directory (recursively) into that file
13. Create another file my/private/files/first-three-env.txt and output the first three env variables from a list of all of them sorted alphabetically
14. Create another file my/private/files/commands.txt and output the contents of the `history` command to that file


