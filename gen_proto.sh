#! /bin/bash
#
# (Re-)generates protobuf Elixir modules from lib/nautic_net/proto/*.proto definition files. 
#
# Run this from the project root.
#

protoc --elixir_out=. --elixir_opt=package_prefix=NauticNet.Proto ./lib/nautic_net/proto/*.proto

mix format ./lib/nautic_net/proto/*.pb.ex
