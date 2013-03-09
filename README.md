Calamum 
=============

Calamum is a simple ruby build program to generate a REST API documentation from a YAML file definition.

## Installation


### Gem Installation

Download and install calamum with the following.

    $gem install calamum

## Usage

     calamum -h
     Usage: /bin/calamum (options)
       -d, --debug                      Show actions to do (default)
       -f, --file DEFINITION            Definition YAML file (required)
       -p, --path PATH                  The distination path for the generated doc directory
       -t, --template TEMPLATE          Documentation HTML template
       -v, --version                    Show calamum version
       -h, --help                       Show this message
### Simple Example
First, you must write a YAML file which contains the definition of your REST API.
A simple example file 'sample.yml' in sample directory.

Next just run the calamum command as following:
     
     $calamum -f my_api_definition.yml

A "doc" directory is generated (by default in your home path, to change it specify the option '-p/--path') with a index file that contain your API Documentation.

Open the index.html file in your browser to show your api doc. 