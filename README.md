# NauticNet.Proto

Protobuf definitions for transporting data across the wire.

## Updating the definitions

Prerequisites:

- **IMPORTANT:** Make sure you read and fully understand the the [rules for updating a message type](https://developers.google.com/protocol-buffers/docs/proto3#updating)
- [Install](https://grpc.io/docs/protoc-installation/) protobuf compiler `protoc`

After updating the proto file, run `./gen_proto.sh` to regenerate the Elixir modules.

Do NOT make manual adjustments to the Elixir modules.
