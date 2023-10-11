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
* [Pre-requisite](#pre-requisite)
* [Commands](#commands)
<!-- tocstop -->
# Usage
<!-- usage -->
```sh-session
$ npm install -g @sharinpix/sharinpix-cli
$ sharinpix COMMAND
running command...
$ sharinpix (--version)
@sharinpix/sharinpix-cli/0.0.9 linux-x64 node-v18.16.0
$ sharinpix --help [COMMAND]
USAGE
  $ sharinpix COMMAND
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
* [`sharinpix help [COMMANDS]`](#sharinpix-help-commands)
* [`sharinpix import file`](#sharinpix-import-file)
* [`sharinpix plugins`](#sharinpix-plugins)
* [`sharinpix plugins:install PLUGIN...`](#sharinpix-pluginsinstall-plugin)
* [`sharinpix plugins:inspect PLUGIN...`](#sharinpix-pluginsinspect-plugin)
* [`sharinpix plugins:install PLUGIN...`](#sharinpix-pluginsinstall-plugin-1)
* [`sharinpix plugins:link PLUGIN`](#sharinpix-pluginslink-plugin)
* [`sharinpix plugins:uninstall PLUGIN...`](#sharinpix-pluginsuninstall-plugin)
* [`sharinpix plugins:uninstall PLUGIN...`](#sharinpix-pluginsuninstall-plugin-1)
* [`sharinpix plugins:uninstall PLUGIN...`](#sharinpix-pluginsuninstall-plugin-2)
* [`sharinpix plugins update`](#sharinpix-plugins-update)

## `sharinpix help [COMMANDS]`

Display help for sharinpix.

```
USAGE
  $ sharinpix help [COMMANDS] [-n]

ARGUMENTS
  COMMANDS  Command to show help for.

FLAGS
  -n, --nested-commands  Include all nested commands in the output.

DESCRIPTION
  Display help for sharinpix.
```

_See code: [@oclif/plugin-help](https://github.com/oclif/plugin-help/blob/v5.2.20/src/commands/help.ts)_

## `sharinpix import file`

describe the command here

```
USAGE
  $ sharinpix import file -p <value> [-f]

FLAGS
  -f, --force
  -p, --path=<value>  (required) path to CSV file

DESCRIPTION
  describe the command here

EXAMPLES
  $ sharinpix import file
```

_See code: [src/commands/import/file.ts](https://github.com/sharinpix/sharinpix-cli/blob/v0.0.9/src/commands/import/file.ts)_

## `sharinpix plugins`

List installed plugins.

```
USAGE
  $ sharinpix plugins [--json] [--core]

FLAGS
  --core  Show core plugins.

GLOBAL FLAGS
  --json  Format output as json.

DESCRIPTION
  List installed plugins.

EXAMPLES
  $ sharinpix plugins
```

_See code: [@oclif/plugin-plugins](https://github.com/oclif/plugin-plugins/blob/v3.9.1/src/commands/plugins/index.ts)_

## `sharinpix plugins:install PLUGIN...`

Installs a plugin into the CLI.

```
USAGE
  $ sharinpix plugins:install PLUGIN...

ARGUMENTS
  PLUGIN  Plugin to install.

FLAGS
  -f, --force    Run yarn install with force flag.
  -h, --help     Show CLI help.
  -v, --verbose

DESCRIPTION
  Installs a plugin into the CLI.
  Can be installed from npm or a git url.

  Installation of a user-installed plugin will override a core plugin.

  e.g. If you have a core plugin that has a 'hello' command, installing a user-installed plugin with a 'hello' command
  will override the core plugin implementation. This is useful if a user needs to update core plugin functionality in
  the CLI without the need to patch and update the whole CLI.


ALIASES
  $ sharinpix plugins add

EXAMPLES
  $ sharinpix plugins:install myplugin 

  $ sharinpix plugins:install https://github.com/someuser/someplugin

  $ sharinpix plugins:install someuser/someplugin
```

## `sharinpix plugins:inspect PLUGIN...`

Displays installation properties of a plugin.

```
USAGE
  $ sharinpix plugins:inspect PLUGIN...

ARGUMENTS
  PLUGIN  [default: .] Plugin to inspect.

FLAGS
  -h, --help     Show CLI help.
  -v, --verbose

GLOBAL FLAGS
  --json  Format output as json.

DESCRIPTION
  Displays installation properties of a plugin.

EXAMPLES
  $ sharinpix plugins:inspect myplugin
```

_See code: [@oclif/plugin-plugins](https://github.com/oclif/plugin-plugins/blob/v3.9.1/src/commands/plugins/inspect.ts)_

## `sharinpix plugins:install PLUGIN...`

Installs a plugin into the CLI.

```
USAGE
  $ sharinpix plugins:install PLUGIN...

ARGUMENTS
  PLUGIN  Plugin to install.

FLAGS
  -f, --force    Run yarn install with force flag.
  -h, --help     Show CLI help.
  -v, --verbose

DESCRIPTION
  Installs a plugin into the CLI.
  Can be installed from npm or a git url.

  Installation of a user-installed plugin will override a core plugin.

  e.g. If you have a core plugin that has a 'hello' command, installing a user-installed plugin with a 'hello' command
  will override the core plugin implementation. This is useful if a user needs to update core plugin functionality in
  the CLI without the need to patch and update the whole CLI.


ALIASES
  $ sharinpix plugins add

EXAMPLES
  $ sharinpix plugins:install myplugin 

  $ sharinpix plugins:install https://github.com/someuser/someplugin

  $ sharinpix plugins:install someuser/someplugin
```

_See code: [@oclif/plugin-plugins](https://github.com/oclif/plugin-plugins/blob/v3.9.1/src/commands/plugins/install.ts)_

## `sharinpix plugins:link PLUGIN`

Links a plugin into the CLI for development.

```
USAGE
  $ sharinpix plugins:link PLUGIN

ARGUMENTS
  PATH  [default: .] path to plugin

FLAGS
  -h, --help      Show CLI help.
  -v, --verbose
  --[no-]install  Install dependencies after linking the plugin.

DESCRIPTION
  Links a plugin into the CLI for development.
  Installation of a linked plugin will override a user-installed or core plugin.

  e.g. If you have a user-installed or core plugin that has a 'hello' command, installing a linked plugin with a 'hello'
  command will override the user-installed or core plugin implementation. This is useful for development work.


EXAMPLES
  $ sharinpix plugins:link myplugin
```

_See code: [@oclif/plugin-plugins](https://github.com/oclif/plugin-plugins/blob/v3.9.1/src/commands/plugins/link.ts)_

## `sharinpix plugins:uninstall PLUGIN...`

Removes a plugin from the CLI.

```
USAGE
  $ sharinpix plugins:uninstall PLUGIN...

ARGUMENTS
  PLUGIN  plugin to uninstall

FLAGS
  -h, --help     Show CLI help.
  -v, --verbose

DESCRIPTION
  Removes a plugin from the CLI.

ALIASES
  $ sharinpix plugins unlink
  $ sharinpix plugins remove
```

## `sharinpix plugins:uninstall PLUGIN...`

Removes a plugin from the CLI.

```
USAGE
  $ sharinpix plugins:uninstall PLUGIN...

ARGUMENTS
  PLUGIN  plugin to uninstall

FLAGS
  -h, --help     Show CLI help.
  -v, --verbose

DESCRIPTION
  Removes a plugin from the CLI.

ALIASES
  $ sharinpix plugins unlink
  $ sharinpix plugins remove
```

_See code: [@oclif/plugin-plugins](https://github.com/oclif/plugin-plugins/blob/v3.9.1/src/commands/plugins/uninstall.ts)_

## `sharinpix plugins:uninstall PLUGIN...`

Removes a plugin from the CLI.

```
USAGE
  $ sharinpix plugins:uninstall PLUGIN...

ARGUMENTS
  PLUGIN  plugin to uninstall

FLAGS
  -h, --help     Show CLI help.
  -v, --verbose

DESCRIPTION
  Removes a plugin from the CLI.

ALIASES
  $ sharinpix plugins unlink
  $ sharinpix plugins remove
```

## `sharinpix plugins update`

Update installed plugins.

```
USAGE
  $ sharinpix plugins update [-h] [-v]

FLAGS
  -h, --help     Show CLI help.
  -v, --verbose

DESCRIPTION
  Update installed plugins.
```

_See code: [@oclif/plugin-plugins](https://github.com/oclif/plugin-plugins/blob/v3.9.1/src/commands/plugins/update.ts)_
<!-- commandsstop -->
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
