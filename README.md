# Overview
We had two folders (containing many thousands of files) that at one point had been synced, but had had the synchronization turned off a few years back and then had drifted over time with some files being added on each side, some modified, and some deleted. 

For discussion purposes lets call the root folders A and B

We wanted to get to one "good" version and then turn syncing back on, but we were worried about losing files that only existed in one place. However, a simple automated sync didn't do what we wanted because we had cases like:

* A file present in A had been intentionally deleted from B and shouldn't be put back
* A file in A was an older version of the same file in B
* A file in A was a newer version of the same file B
* Sub-directories in A or B had created/moved so that position of files wasn't the same in both places

So we were going to end up with a manual process, but it would be helpful to limit the scope of work.

The intent behind this script is to take directory A ("source") and identify any identical files present somewhere in B ("destination"). Those files should be deleted (they are moved to a directory called `_delete` at the root level of source). For those files, we're going live with where they exist in the destination.

For files that don't have an identical copy somewhere in the destination, leave them in place on the source side so they can be manually reviewed, deleted, or moved into an appropriate location in the destination.

Here are some screen shots to clarify the process.

## Source Directory Before
![Source Before](https://github.com/stevenchanin/find-unique-files/raw/master/readme_images/1-SourceBefore.png)

## Destination Directory Before
![Destination Before](https://github.com/stevenchanin/find-unique-files/raw/master/readme_images/2-DestinationBefore.png)

## Source Directory After
![Source After](https://github.com/stevenchanin/find-unique-files/raw/master/readme_images/3-SourceAfter.png)

Since the destination is to be modified manually after reviewing what is left in Source, it is not changed by running the script.

# Installation
Install bundler (if necessary)
```
$ gem install bundler
```

Install gems
```
$ bundle install
```

# Execution
The script uses `Thor` to handle command line options
```
$ thor find_unique:execute /PATH/TO/SOURCE /PATH/TO/DESTINATION [-v] [-d]
```

where `-v` enables verbose mode and prints more output and `-d` runs in debug mode. This will show you the results of the analysis, but not modify any files in source.

## Example - run in debug mode
```
$ thor find_unique:execute ./_src ./_dest -d
```

## Example - run 
```
$ thor find_unique:execute ./_src ./_dest -d
```
