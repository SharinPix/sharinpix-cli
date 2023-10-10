SharinPix CLI
=================

This is a simple CLI for SharinPix API

<!--
[![oclif](https://img.shields.io/badge/cli-oclif-brightgreen.svg)](https://oclif.io)
[![CircleCI](https://circleci.com/gh/oclif/hello-world/tree/main.svg?style=shield)](https://circleci.com/gh/oclif/hello-world/tree/main)
[![GitHub license](https://img.shields.io/github/license/oclif/hello-world)](https://github.com/oclif/hello-world/blob/main/LICENSE)
-->
<!-- toc -->
* [Usage](#usage)
* [Commands](#commands)

<!-- tocstop -->
# Usage
<!-- usage -->
```sh-session
$ npm install -g sharinpix-cli
$ spx COMMAND
running command...
$ spx (--version)
sharinpix-cli/0.0.0 linux-x64 node-v18.16.0
$ spx --help [COMMAND]
USAGE
  $ spx COMMAND
...
```
<!-- usagestop -->

# Pre-requisite
Before you can execute any command from the SharinPix CLI, you need to find the SharinPix Secret URL. 

Find your SharinPix secret url and execute the following command in your terminal (make sure to replace the secret url with yours)
```shell
export SHARINPIX_SECRET_URL=sharinpix://02cc044f-xxxx-xxxx-8b72-0eabb16a21cb:MplDxxxxvRLPX_kHM-BDe0PkoVlncsiGkoxxxxsheOAJyUU@api.sharinpix.com/api/v1
```

# Commands
<!-- commands -->
* [`spx import file`](#spx-import-file)

## `spx import file --path <path_to_csv_file>`

Bulk upload images from your computer to SharinPix using a CSV file 

```
USAGE
  $ spx import file -f <value>

ARGUMENTS
  PERSON  Person to say hello to

FLAGS
  -p, --path=<value>  (required) Path to the CSV file (see sample below)

DESCRIPTION
  Bulk upload local images to SharinPix

EXAMPLES
  $ spx import file --path ./test/import.csv
  Processed ID: 00324000004GUxhAAG, Path: /home/kevan/Pictures/Sample/sample.jpg, Tags: Hello, filename: sample.jpg
```

