defmodule NauticNet.Protobuf.LoRaPacket do
  @moduledoc false
  use Protobuf, protoc_gen_elixir_version: "0.11.0", syntax: :proto3

  oneof(:payload, 0)

  field(:hardwareID, 1, type: :fixed32)
  field(:roverData, 2, type: NauticNet.Protobuf.RoverData, oneof: 0)
  field(:roverDiscovery, 3, type: NauticNet.Protobuf.RoverDiscovery, oneof: 0)
  field(:roverConfiguration, 4, type: NauticNet.Protobuf.RoverConfiguration, oneof: 0)
end

defmodule NauticNet.Protobuf.RoverData do
  @moduledoc false
  use Protobuf, protoc_gen_elixir_version: "0.11.0", syntax: :proto3

  field(:latitude, 1, type: :float)
  field(:longitude, 2, type: :float)
  field(:heading, 3, type: :uint32)
  field(:heel, 4, type: :int32)
end

defmodule NauticNet.Protobuf.RoverDiscovery do
  @moduledoc false
  use Protobuf, protoc_gen_elixir_version: "0.11.0", syntax: :proto3
end

defmodule NauticNet.Protobuf.RoverConfiguration do
  @moduledoc false
  use Protobuf, protoc_gen_elixir_version: "0.11.0", syntax: :proto3

  field(:slots, 1, repeated: true, type: :int32)
  field(:sbw, 2, type: :uint32)
  field(:sf, 3, type: :uint32)
end
