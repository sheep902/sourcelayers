#Sourcelayers

##Introduction

Sourcelayers is a code reading tool.

##Contribute

Sourcelayers is licensed under MIT or GPL.

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
 - Two-level state in frontend: app state and component state.
   - App state: single source of truth. A singleton Baobab tree.
     e.g. domain model.
   - Component state: display state. Internal states are set by UI events or automatically inferred from
   App state by component.
     e.g. form content, button down/up.
 - TODO Background jobs may fail at any moment. Scalable fail-over?

```

         Backend                                                               Frontend

  +--------------------+           +--------------+            +----------------+
  |                    |           |           ...+----Query--->                <---Cancel-----+
  |   Command Worker   <--Spawn----+.......    .  |            |  Intent Worker |              |
  |                    |           |       \...|..<--Command---+                <---Spawn--+   |
  +----^---------------+           |           .  |            +-------+--------+          |   |
       |                           |           .  |                    |                   |   |
     Direct                        |   Endpoint.  |                Transition              |   |
     Access         +---------+    |           .  |                    |                 +-+---+---+
       |            | Update  +---->.......    .  |            +-------v--------+        | Intent  |--------------+
  +----v------------| Trigger |    |       \...|..+----Push---->                +--Query-> Context |              |
  |                 +---------+    |           .  |            |     State      |        +---------+ Component    |
  |   OrientDB Store   |           |           ...+----Query--->                +----Query---->|                  |
  |                    +--Query---->........../   |            +----------------+              +------------------+
  +--------------------+           +--------------+

```

Intent Worker: The equivalent of Flux's Action Handler. User's UI activities are meaningless to our App (e.g. typing chars in form) until we can finally infer what the user's real intention is (e.g. click sign up button -> create a user). An intent worker translate this intent into server command/state transitions.

Context: Information from app state and view state. Note an intent worker is meant to model user's decision under a certain state of the app, and context is a snapshot of the "certain state", so contexts should be static (I don't know how to make them dynamic anyway).

Command: How the background sees the user intent. Optional.

Transition: An intent worker triggers transitions to change app state. When a collision is detected in the transition handler, the handler may decide to solve it or terminate the intent worker.

TODO intent collision set