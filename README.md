**Warning** This project is no longer maintained or supported.

# NAME

teampass - Teampass client, retrieves and inserts passwords into Teampass password manager

# SYNOPSIS

```shell
teampass list
teampass show [-c] <passname>
teampass find <passname>
teampass insert <passname>
teampass generate <passname>
teampass shell [-c]
teampass dump
```

# DESCRIPTION

`teampass` is a command line client for [Teampass](http://teampass.net/) that uses the Teampass API to list, retrieve and insert passwords.

It is loosely inspired by the password store `pass(1)` utility and thus can be easily adapted for usage with some wrappers built for it such as the `passmenu` script for integration with `dmenu`/`rofi` and such.

It can also be used to display them as json for easy use with `jq(1)` or other json parsing tools.

Example scripts are provided for `dmenu(1)` integration, `bash(1)` completion and import of passwords into `pass(1)`.

`list`

List all passnames.

`show <passname>`

Show the password identified by `<passname>`.

`find <passname>`

Find passwords inside the tree that match `<passname>`.

`insert <passname>`

Insert a new password into the password store called `<passname>`. Will ask for the password on stdin.

`generate <passname>`

Insert a new password into the password store called `<passname>`. Will generate an [XKCD-compliant](https://xkcd.com/936/) password ant outputs it on stdout.

`shell`

Start an interactive shell for searching and displaying passwords, featuring autocompletion and search history.

`dump`

Dump all passwords as json on stdout.

`-c --clip`

In `show` and `shell` modes, substitute writing to stdout by writing to clipboard.

`-h --help`

Show help.

# EXAMPLES

List existing passwords in store
```
$ teampass list
web/example.com/foo
web/example.com/bar
wifi/room1/wpa
```

Find existing passwords in store that match ".com"
```
$ teampass find .com
web/example.com/foo
web/example.com/bar
```

Show existing password
```
$ teampass show web/example.com/foo
98/oPmojk
```

Copy existing password to clipboard
```
$ teampass show -c web/example.com/foo
```

Add password to store
```
$ teampass insert web/example.net/foo
Press Ctrl-T to toggle password visibility
Password: *********
```

Generate an XKCD-compliant password
```
$ teampass generate web/example.net/bar
Generated password: "formed danbury tinder stripy climate program's"
```

Open a nice shell with autocompletion and history search
```
$ teampass shell
```

Dump all passwords as json on stdout and use `jq(1)` to query the label of the 5th password in the "web" category
```
$ teampass dump | jq '."web"."5"."label"'
```

# CONFIGURATION

Teampass API URL and API key as well of (due to limitations of the API) names and IDs of categories of passwords to display need to be set in a `~/.teampass.json` file. You should be able to get those by looking a Teampass database.

```json
{
	"api_endpoint":"https://teampass.example.com/api/index.php",
	"api_key":"oioijiojhggi54f87ezPkkMjnnhN4OijiYYhnjk",
	"categories": {"1": "Web", "2": "Servers"}
}
```

# FILES

`~/.teampass.json`

Configuration file that must contains the Teampass API key and the informations about the categories of passwords to display.

`~/.teampass_history`

History of passnames displayed through the `shell` mode.

# LIMITATIONS

The API of Teampass being limited, it's not possible to list categories of passwords, so they have to be set along with their ID in the configuration. For the same reason, the displayed hierarchy of passwords is flattened.

No restrictions apply to the use of the API, so using this utility means having an API key which means having full privileges on the Teampass instance, which might not be desired.

# BUGS

The `insert` command is currently broken, one parameter is likely wrong when calling the API.
