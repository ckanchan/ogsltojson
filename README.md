# ogsltojson

Converts Oracc SL files to JSON

## Introduction

This command line utility converts a cuneiform sign list from the Oracc Sign List format to a JSON representation suitable for serialisation and deserialisation to Swift structs.

## Usage

    ogsltojson [OGSLSTRING]
    ogsltojson --input [OGSLPATH] [OUTPUTPATH]?

    If OUTPUTPATH is not supplied, print JSON to stdout

## Specifications

The Oracc Sign List specification is available on the [Oracc website](http://oracc.org/ns/sl/1.0)
