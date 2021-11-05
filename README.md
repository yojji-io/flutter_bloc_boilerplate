# flutter_skeleton

Flutter BLOC boilerplate


## Getting Started
Before run project you should do few steps:
- Setup default variables in environment_config.yaml
- Generate config file with
 flutter pub run environment_config:generate --some_key=some_value
 It is possible to pass arguments into it to override some values

- Run codegeneration tool:
 flutter pub run build_runner build --delete-conflicting-outputs 

- Build and run application