# Simple Configuration File Format for MATLAB

Simple text-based file format for loading dictionary-like configuration data into MATLAB.

## The File Format

The simple config files are assumed to be ordinary text (`.txt`) files. The syntax of the files is designed to be very similar to the YAML syntax.
- configuration data can be stored as key/value pairs, delimitted using a colon (`:`)
- keys must be text
- values can be text, numbers, list of text, or a list of numbers
- comments are started with the pound symbol (`#`)

> **NOTE:** This simple config format does **_not_** support nested dictionaries.


### Example

```
# satellite name
name: example satellite

# satellite properties
mass [kg]: 50
area of each face of cubesat [m^2]: [2, 2, 3, 1.5, 5, 5]
label for each face of cubesat: [face A, face B, face C, face D, face E, face F]
```


## Loading a Simple Configuration File

A simple config file can be loaded into MATLAB using the `load_config` function.


### Syntax

`config = load_config(file_path)`

### Inputs

- **`file_path` (char array or 1×1 string):** relative or absolute file path (with or without extension)


### Outputs
- **`config` (1×1 dictionary (string --> cell)):** dictionary storing config data


### Examples
- See `EXAMPLES.mlx` or the "Examples" tab on the File Exchange page for examples.