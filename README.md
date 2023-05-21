# Simple Configuration File Format for MATLAB [![View Simple Configuration File Format for MATLAB on File Exchange](https://www.mathworks.com/matlabcentral/images/matlab-file-exchange.svg)](https://www.mathworks.com/matlabcentral/fileexchange/129884-simple-configuration-file-format-for-matlab)

Simple text-based file format for loading dictionary-like configuration data into MATLAB.

## The File Format

The simple config files are assumed to be ordinary text (`.txt`) files. The syntax of the files is designed to be very similar to the YAML syntax.
- configuration data can be stored as key/value pairs, delimitted using a colon (`:`)
- keys must be text
- values can be text, numbers, booleans, lists of text, lists of numbers, and lists of booleans
	- lists are defined using square brackets (`[ ]`)
	- list elements are delimited using commas (`,`)
	- booleans can be specified as `false`, `False`, `true`, or `True`
- comments are started with the pound symbol (`#`)

> **NOTE:** This simple config format does **_not_** support nested dictionaries.


### Example

```
# satellite name
name: example satellite

# satellite properties
mass [kg]: 50
area of each face [m^2]: [2, 2, 3, 1.5, 5, 5]
label for each face: [face A, face B, face C, face D, face E, face F]

% control system settings
actuators active: false
sensors active: true
```


## Loading a Simple Configuration File

A simple config file can be loaded into MATLAB using the `load_config` function.


### Syntax

`config = load_config(file_path)`

### Description

`config = load_config(file_path)` loads a simple config located at the file path (can be absolute or relative path, and with or without the `.txt` extension) specified by `file_path` into the `config` dictionary.


### Examples
- See `EXAMPLES.mlx` or the "Examples" tab on the File Exchange page for examples.