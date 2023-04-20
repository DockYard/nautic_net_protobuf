defmodule NauticNet.ProtoTest do
  use ExUnit.Case

  alias NauticNet.Protobuf
  alias NauticNet.Protobuf.DataSet
  alias NauticNet.Protobuf.DataSet.DataPoint
  alias NauticNet.Protobuf.PositionSample
  alias NauticNet.Protobuf.SpeedSample

  describe "chunk_into_data_sets/3" do
    test "works for single packets" do
      samples = build_speed_points(10)
      max_bytes = 512
      counter = 100

      assert [data_set] = Protobuf.chunk_into_data_sets(samples, max_bytes, counter: counter)

      assert data_set.counter == 100
      assert length(data_set.data_points) == 10
      assert byte_size(DataSet.encode(data_set)) <= max_bytes
    end

    test "works for multiple packets" do
      samples =
        build_speed_points(:rand.uniform(100) + 100) ++
          build_position_points(:rand.uniform(100) + 100)

      max_bytes = 512
      counter = 100

      assert data_sets = [_ | _] = Protobuf.chunk_into_data_sets(samples, max_bytes, counter: counter)

      for {data_set, index} <- Enum.with_index(data_sets) do
        assert data_set.counter == 100 + index
        assert length(data_set.data_points) < 100
        assert byte_size(DataSet.encode(data_set)) <= max_bytes
      end
    end
  end

  defp build_speed_points(count) do
    for _ <- 1..count do
      DataPoint.new(
        timestamp: Protobuf.utc_now(),
        sample: {:speed, SpeedSample.new(speed_m_s: :rand.uniform())}
      )
    end
  end

  defp build_position_points(count) do
    for _ <- 1..count do
      DataPoint.new(
        timestamp: Protobuf.utc_now(),
        sample:
          {:position,
           PositionSample.new(
             latitude: (:rand.uniform() - 0.5) * 180,
             longitude: (:rand.uniform() - 0.5) * 360
           )}
      )
    end
  end
end
