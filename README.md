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
  |                    |           |           ...+--Query(n)-->                <--Terminate---------+
  |   Command Worker   <--Spawn----+.......    .  |            |  Intent Worker |                    |
  |                    |           |       \...|..<-Command(1)-+                <---Spawn------+     |
  +----^---------------+           |           .  |            +----+------^----+              |     |
       |                           |           .  |                 |      |                   |     |
     Direct                        |   Endpoint.  |              Command Terminate             |     |
     Access         +---------+    |           .  |                 |      |               +---+---+ |
       |            | Update  +---->.......    .  |            +----v------+----+        +-|Context|-+-+
  +----v------------| Trigger |    |       \...|..+----Push---->                |        | +-------+   |
  |                 +---------+    |           .  |            |     State      +-Query->|  Component  |
  |   OrientDB Store   |           |           ...+----Query--->                |        |             |
  |                    +--Query---->........../   |            +----------------+        +-------------+
  +--------------------+           +--------------+

```

Intent Worker: The equivalent of Flux's Action Handler. User's UI activities are meaningless to our App (e.g. typing chars in form) until we can finally infer what the user's real intention is (e.g. click sign up button). Then an intent worker is generated to finish this intent. An intent worker translate the intent into one server command & several store commands. Intent worker can be terminated by user.

Context: Collects information from view state + baobab store and feeds it into the intent worker being generated. Note intent workers are meant to model users' decisions under a certain state of the app, and a context is a snapshot of the "certain state", so contexts should be static (I don't know how to make them dynamic anyway).  Server Command: A server command describes the corresponding user intent in a view-agnostic way.

State Command: An intent worker can send several state commands to put app in the proper state. When a collision is detected in the state command handler, the handler may decide to solve it or terminate the intent worker.
