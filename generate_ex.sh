#! /bin/bash
#
# (Re-)generates protobuf Elixir modules from lib/nautic_net/proto/*.proto definition files. 
#
# Run this from the project root.
#

echo 'Genering Elixir from Protobuf definitions...'
protoc --elixir_out=. --elixir_opt=package_prefix=NauticNet.Protobuf ./lib/nautic_net/protobuf/*.proto

echo 'Formatting...'
mix format ./lib/nautic_net/protobuf/*.pb.ex

echo 'Done!'
