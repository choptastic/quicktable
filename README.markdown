# quicktable

A plugin adding a more succint way of specifying tables for the [Nitrogen Web Framework](http://nitrogenoproject.com)

## Installing into a Nitrogen Application

Add it as a rebar dependency by adding into the deps section of rebar.config:

```erlang
	{quicktable, ".*", {git, "git://github.com/choptastic/quicktable.git", {branch, master}}}
```

### Using Nitrogen's built-in plugin installer (Requires Nitrogen 2.2.0)

Run `make` in your Application. The rest should be automatic.

### Manual Installation (Nitrogen Pre-2.2.0)

Run the following at the command line:

```shell
	./rebar get-deps
	./rebar compile
```

Then add the following includes into any module requiring the form

```erlang
	-include_lib("quicktable/include/records.hrl").
```

## Usage

```erlang
	#quicktable{
		html_encode=true,
		data=[
			["R1C1", "R1C2", "R1C3"],
			["R2C1", "R2C2", "R2C3"],
			["R3C1", "R3C2", "R3C3"]
		]
	}.
```
or - enabling interpretation of first row as header:

```erlang
	#quicktable{
		html_encode=true,
		first_row_is_header=true,
		data=[
			{"HeaderC1", "HeaderC2", "HeaderC3"},
			{"tupleR2C1", "tupleR2C2", "tupleR2C3"},
			{"tupleR3C1", "tupleR3C2", "tupleR3C3"}
		]
	}.
```


The `data` attribute is a list of rows, with the each row merely being a list
of cells, and the cell contents being encoded either with the specified
`html_encode` attribute, or a simple body.

## License

Copyright (c) 2013, [Jesse Gumm](http://jessegumm.com)
([@jessegumm](http://twitter.com/jessegumm))

MIT License
