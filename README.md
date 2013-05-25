calamum
=======

Calamum is a simple tool to generate a REST API documentation from a JSON file definition.

## Installation
Download and install calamum: `gem install calamum`

## Usage
```
calamum -h
Usage: /bin/calamum (options)
  -d, --debug                      Show actions to do (true by default)
  -f, --file DEFINITION            Path to the file with JSON API definition
  -p, --path PATH                  Path to the directory where docs will be generated
  -t, --template TEMPLATE          Name of HTML template (twitter by default)
  -v, --version                    Show version number
  -h, --help                       Show this help
```

To generate a documentation you should write a definition of your REST API in JSON format.
<br/>
You could find an example of API definition in the [sample.json](/sample/sample.json). Next, just run the calamum command.

    $calamum -f my_api_definition.json
To preview just generated documentation, navigate to the 'docs' directory (by default in your home path, you can specify the destination path with the option '-p/--path').
Then, find and open the index.html file in your browser and enjoy the result.

## Inspirations
- [Apiary](http://apiary.io/blueprint)
- [IO Docs](https://github.com/mashery/iodocs)
- [Swagger](https://developers.helloreverb.com/swagger)
