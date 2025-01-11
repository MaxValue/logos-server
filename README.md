
# Logos Server

_A simple web service to offer permalinks to your logos_

* Do you want to have permanent links to the logo of your group/verein?
* Does your logo come in different variants?
* Do you want to swap your logos style at specific times during the year?
* Does your group/verein have subgroups with a different logo?

This script tries to satisfy these requirements.

[TOC]

## Script Usage

`./logos.sh /path/to/logos/dir defaultGroupName currentStyleName`

* `logos.sh` is the script name, as seen in this repository
* `/path/to/logos/dir` should be replaced with the path where your logos are stored (more about the directory structure needed later)
* `defaultGroupName` should be replaced with the name of the subgroup which should be assumed as default (more on that later)
* `currentStyleName` should be replaced with the name of style which should be assumed as default (more on that later)

### The required directory structure

* logosRootDir/
    * groupName/
        * default_full.ico
        * default_full.png
        * default_full.svg
        * default_name.ico
        * default_name.png
        * default_name.svg
        * default_square.ico
        * default_square.png
        * default_square.svg
        * pride_full.ico
        * pride_full.png
        * pride_full.svg
        * pride_name.ico
        * pride_name.png
        * pride_name.svg
        * pride_square.ico
        * pride_square.png
        * pride_square.svg

You do not need to provide all these variants. This is just an example. The important part is, that your canonical logo (the default design) is named beginning with `default_` and other style variants have their specific prefix. Everything after the first `_` is not important, here it is used for differentiating between the form factors of the logo.

### What the script does in detail

* for each group it creates symlinks to the current style variant. These symlinks start with `logo_`
* it also creates a file-extension-less symlink of each format variant for each style, as convenience
* in the root directory of the logos it creates symlinks for all the files of the default group

This behavior results in links like these:

* https://public.example.com/logos/logo_full.svg
* https://public.example.com/logos/logo_name.png
* https://public.example.com/logos/logo_square.ico
* https://public.example.com/logos/pride_full.png
* https://public.example.com/logos/pride_name.ico
* https://public.example.com/logos/pride_square.svg
* https://public.example.com/logos/AT/logo_full.png
* https://public.example.com/logos/AT/logo_name.svg
* https://public.example.com/logos/AT/logo_square.ico
* https://public.example.com/logos/AT/default_full
* https://public.example.com/logos/AT/default_full.svg
* https://public.example.com/logos/AT/default_name.ico
* https://public.example.com/logos/AT/default_square.png
* https://public.example.com/logos/AT/pride_full.ico
* https://public.example.com/logos/AT/pride_name.svg
* https://public.example.com/logos/AT/pride_square.png

## Script Setup

### Prerequisites

* `bash` shell
* `find` command

### Step by Step

1. Download the script
2. Create your directory structure
3. Run the script, e.g.:
    `./logos.sh /path/to/logos/dir AT default`
4. Setup your web server to point to that directory structure
5. Optionally setup a cronjob to change the default group at specific times of the year, e.g.:
    * at pride month:
        `*/3 * 1 6 * logosuser ./logos.sh /path/to/logos/dir AT pride`
    * after pride month:
        `*/3 * 1 7 * logosuser ./logos.sh /path/to/logos/dir AT default`

## Roadmap
* Support .htaccess files and nginx rules as alternative to cronjobs

## Versioning

We use [SemVer](http://semver.org/) for versioning. For the versions available, see the [tags on this repository](https://gitlab.com/MaxValue/logos-server/-/tags).

## Authors
* **Max Fuxjäger** - *Initial work* - [MaxValue](https://gitlab.com/MaxValue)

See also the list of [contributors](https://gitlab.com/MaxValue/logos-server/-/graphs/main?ref_type=heads) who participated in this project.

## Project History
This project was created because I (Max) needed a low maintenance solution for swapping logos on a Verein-Website without changing each link and, if possible, have the logos updated if those were hotlinked to from other sites. I did not find anything similar, at least not as simple as this, so in a procrastination streak I wrote this script.
