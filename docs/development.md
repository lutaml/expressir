## Development Plan

This document is a draft to understand the basic of the original library, and
how the whole tool chain is working at the moment. Once, we've an understanding
then let's look at the potential area of improvement, and plan out a high level
plan to start the development.

### What is it, expressir?

* Expressir is a ruby tool to harvest iso express data model
* Express is one of the language to represent data model
* Expressir tool is used to manipulate iso express data model
* The input for the expressir is a standard xml document
* XML Spec: http://stepmod.sourceforge.net/express_model_spec/
* Expressir does the job of representing express model as ruby class
* REXML-based parser that reads EXPRESS as XML and creates the dictionary (i.e.
  instances of the EXPRESS Ruby Classes) and then calls a mapper, that may be
  specified as an option at runtime
* Mappers that read the EXPRESS dictionary and perform the conversion to the
  desired language or format
* Express to UML2 Mapper - Convert the express model to UML2
* Express to OWL Structure - Convert the express model to OWL Structure
* Ruby API generator for express language
* Current Ruby API is super slow, it takes 2 hours to generate 400 entity

### How does the original version work?

At the core the `expressir.rb` is responsible for everything at moment, it takes
an Express XML file as an input and then it parses that XML file and build the
correct ruby interface for further processing.

This `expressir.rb` also expect one mapping file `deafult to mapping.rb`, and it
also expect the file to specify a custom method `map_from_express` to take the
`Ruby Express Representation` and convert this ruby representation to the
desire output format.

The library also provides couple mapping for UM2, OWL and SysML, so anyone can
export their data to any of those format if necessary, and the use cases for
those library are as following:

```ruby
ruby expressir.rb expxml=<schema.xml> map=<mapping_owl.rb>
```

### What are potential improvement area?

* The interface is not well defined, someone needs to dig deeper to understand
  just the basic of the library and how to use for their use cases. This is
  something that could be improved as initial step.
* At the moment, these are some ruby files, so potentially we could group those
  together as a CLI tool and group some of the common functionality, and provide
  a straight forward interface for users.
* The good part about this library is author had the extensibility in mind from
  the beginning, so we should keep that functionality as flexible as possible.
* There are lot of boilerplate code in the library, but it's understandable as
  it was written quite long time ago, so maybe most of the tool was not even
  available back then, so this is the another area we could improve.
* Another improvement we could do in terms of actual codebase, we should be able
  to refactor this library and cleanup as much as possible.

### What are the initial changes?

Initially, we can start by creating a ruby cli gem, group these functionality
together. This could be named as `expressir`, and this gem will be shipped with an
executable called `expressir`.

Second of all, let's add some dedicated interface for the default type, so user
does not need to know all the details but the name of the interface, for example
we could expose the transformation as follows:

```sh
# Convert to owl
expressir express2owl file=[express_xml_file] [**options]

# Convert to UML
expressir express2uml file=[express_xml_file] [**options]

# Convert to SysML
expressir express2sysml file=[express_xml_file] [**options]

# Custom conversion
expressir express2custom file=[express_xml_file] mapping=[custom_mapping.rb]
```

Third of all once this library is functional as the original version then we
will go through each of the existing types, and refactor those as necessary.

### References

* https://martinfowler.com/bliki/MovingToNokogiri.html
