defmodule NauticNet.LoRaPacketTest do
  use ExUnit.Case

  alias NauticNet.Protobuf.LoRaPacket

  test "can decode base 16" do
    base16 = "0D55BC15F512120DB674274215634190C220F40128FC0C3001"
    binary = Base.decode16!(base16)

    assert %NauticNet.Protobuf.LoRaPacket{
             __unknown_fields__: [],
             hardwareID: 4_111_842_389,
             payload:
               {:roverData,
                %NauticNet.Protobuf.RoverData{
                  __unknown_fields__: [],
                  battery: 0,
                  cog: 1660,
                  heading: 0,
                  heel: 244,
                  latitude: 41.863975524902344,
                  longitude: -72.1277084350586,
                  sog: 1
                }}
           } == LoRaPacket.decode(binary)
  end
end
