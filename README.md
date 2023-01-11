# NauticNet.Protobuf

Protobuf definitions for transporting data across the wire.

## Setup

```sh
brew install protobuf
mix escript.install hex protobuf
asdf reshim

# Check installation
protoc --version
protoc-gen-elixir --version
```

Full install directions [here](https://grpc.io/docs/protoc-installation/) and [here](https://github.com/elixir-protobuf/protobuf)

## Making Changes

### IMPORTANT!!!
Before making any changes, be sure you read and fully understand the the [rules for updating a message type](https://developers.google.com/protocol-buffers/docs/proto3#updating).

### Updating the definitions

Do NOT make manual adjustments to the Elixir modules. Run:

```sh
./generate_ex.sh
```

