#Sourcelayers

##Introduction

Sourcelayers is a code reading tool.

##Contribute

Sourcelayers is licensed under MPL or GPLv2.

The author keeps his rights to relicense this repo and its contributions.

## Development

```
npm install
npm install webpack-dev-server -g
webpack-dev-server --save
```

## Design Decisions

### Whiteboard

 - Rails apps depend on Sprockets, so it seems fine to depend on webpack.
 - Flux/CQRS-alike unidirectional data flow everywhere.
 - TODO Baobab solved questions about keeping app-level states. Where should states of reusable components go?
   e.g. A list item may have state.
 - TODO Background jobs may fail at any moment. Scalable failover?

### Planned Architecture



                                                        +
                   Backend                              |                       Frontend
                                                        |
                                                        |
                                            +----------------------Push Changes---------------------+
                                            |           |                                           |
                                  +---------+---+       |     +----------------+              +-----v-------------+
            +----Push Changes----->             <---Query----->                |              |                   |
            |                     |  Endpoints  |             | Command Worker |              |  Change Listener  |
            |  +----Query--------->             <--Command----+                +--------+     |                   |
            |  |                  +---------+---+       |     +---^------------+        |     +-----+-------------+
            |  |                            |           |         |                     |           |
            |  |                            |Spawn      |         |Spawn                +--Event----+
            |  |   +---Command Record-------+           |         |                                 |Updates
            |  |   |                        |           |         |                                 |
  +---------+--v---v---+     +--------------v---+       |     +---+----------+                 +----v-----------+
  |                    |     |                  |       |     |              <----Updates------+                |
  |   OrientDB Store   <-R/W->  Command Worker  |       |     |     View     |                 | Baobab Store   |
  |                    |     |                  |       |     |              <----Query-------->                |
  +--------------------+     +------------------+       |     +--------------+                 +----------------+
                                                        |
                                                        |
                                                        +

