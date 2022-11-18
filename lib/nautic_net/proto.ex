defmodule NauticNet.Proto do
  @moduledoc """
  Protobof implementation concerns.
  """

  alias NauticNet.Proto.DataSet

  def new_data_set(data_points, opts \\ []) do
    counter = opts[:counter] || 0
    ref = opts[:ref] || new_ref()

    DataSet.new(counter: counter, data_points: data_points, ref: ref)
  end

  defp new_ref do
    Base.url_encode64(:crypto.strong_rand_bytes(10), padding: false)
  end

  @doc """
  Breaks down a list of DataPoints into a list of DataSets whose encoded sizes
  do not exceed `max_bytes`.

  This is meant to fit encoded DataSets into UDP payload sizes (~512 bytes) that won't
  be fragmented across the Internet.
  """
  def chunk_into_data_sets(data_points, max_bytes, opts \\ []) do
    counter = opts[:counter] || 0

    Enum.chunk_while(
      data_points,
      DataSet.new(counter: counter),
      fn data_point, data_set ->
        next_data_set = %DataSet{data_set | data_points: [data_point | data_set.data_points]}

        if byte_size(DataSet.encode(next_data_set)) > max_bytes do
          next_acc = DataSet.new(counter: next_data_set.counter + 1, data_points: [data_point])
          {:cont, data_set, next_acc}
        else
          {:cont, next_data_set}
        end
      end,
      fn data_set -> {:cont, data_set, data_set} end
    )
  end

  @doc """
  Convert a DateTime to a standard Google protobuf Timestamp type.
  """
  def to_proto_timestamp(%DateTime{} = datetime) do
    Google.Protobuf.Timestamp.new(seconds: DateTime.to_unix(datetime))
  end

  @doc """
  Returns now as a protobuf Timestamp type
  """
  def utc_now do
    to_proto_timestamp(DateTime.utc_now())
  end

  @doc """
  Encodes a protobuf message prepended with the byte count.

  The byte count is a 16-bit unsigned integer, and indicates the number of bytes
  in the endedod protobuf message after the count.

  See https://developers.google.com/protocol-buffers/docs/techniques#streaming
  """
  def encode_delimited(%struct{} = message) do
    encoded = struct.encode(message)
    <<byte_size(encoded)::unsigned-integer-16, encoded::binary>>
  end
end
