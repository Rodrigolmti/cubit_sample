# Cubit Sample

The goal of this project is to build a simple application using clean architecture and cubit, unfortunately cubit was deprecated by his creator, and now they are using with bloc and different approaches, this project use the old cubit implementation.

## Guide

- Clean architecture
- Simple implementation for environments (using InheritedWidget)
- DI (dependency injection) to handle instances default and mock impls

### Code

- Presentation layer
    cubit -> Handle all the logics, call useCases and post states to the view
    screen -> Only build widgets based on the view_state
    view_state -> Should have all the logics and process data, screen should not need to make computations or any logic that does not concern build widgets, so, the view_state class have all this and the screen only use it.

    - It is common we see widgets with somoe logics like '${model.something - ${model.somenthingElse}}', or any more complex logics that should not be there.

- Data
    use_cases -> Business logics 
    repository -> Work like a proxy in most of the times, but could have some cache logics (remote or local) data source.
    model -> Can have view models, response models, storage models ...
    data_source -> Responsible for raw data like, call some API and process the response to a model, or get some info in the DB
    mappers -> Map one class to another one, the main ideia is prevent models like view to have any logics that they do not need to know

