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
webpack-dev-server --hot
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
 - TODO Some changes are local (e.g. git clone) and will not be automatically synchronized across machines.

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


Intent Worker: The equivalent of Flux's Action Handler. User's UI activities are meaningless to our App (e.g. typing chars in form) until we can finally infer what the user's real intention is (e.g. click sign up button -> create a user). An intent worker translate this intent into server command/state transitions.

Context: Information from app state and view state. Note an intent worker is meant to model user's decision under a certain state of the app, and context is a snapshot of the "certain state", so contexts should be static (I don't know how to make them dynamic anyway).

Command: How the backend understands the intent. Optional.

Transition: An intent worker triggers transitions to change app state. When a collision is detected in the transition handler, the handler may decide to solve it or terminate the intent worker.

```
###Intent

####Conflict

Intents can conflict with each other.

For example, many websites provide instant search utilities, allowing every <input/> event to trigger a XHR and use some tricks (e.g. timestamps, queuing..) to ensure the view isn't corrupted by disordered callbacks.

But that's not what the user **wants to do**. In this case, all the previous inputs become meaningless to the user in every keystoke, and our app logic should just work that way.

Use 'Component#cancel_all(type)' to discard all previous intents that is of specified type & triggered by this component.
