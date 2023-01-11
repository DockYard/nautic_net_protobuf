defmodule NauticNet.Protobuf.AngleReference do
  @moduledoc false
  use Protobuf, enum: true, protoc_gen_elixir_version: "0.11.0", syntax: :proto3

  field(:ANGLE_REFERENCE_NONE, 0)
  field(:ANGLE_REFERENCE_TRUE_NORTH, 1)
  field(:ANGLE_REFERENCE_MAGNETIC_MORTH, 2)
end

defmodule NauticNet.Protobuf.SpeedReference do
  @moduledoc false
  use Protobuf, enum: true, protoc_gen_elixir_version: "0.11.0", syntax: :proto3

  field(:SPEED_REFERENCE_NONE, 0)
  field(:SPEED_REFERENCE_GROUND, 1)
  field(:SPEED_REFERENCE_WATER, 2)
end

defmodule NauticNet.Protobuf.WindReference do
  @moduledoc false
  use Protobuf, enum: true, protoc_gen_elixir_version: "0.11.0", syntax: :proto3

  field(:WIND_REFERENCE_NONE, 0)
  field(:WIND_REFERENCE_TRUE_NORTH, 1)
  field(:WIND_REFERENCE_MAGNETIC_NORTH, 2)
  field(:WIND_REFERENCE_APPARENT, 3)
  field(:WIND_REFERENCE_BOAT_TRUE_NORTH, 4)
  field(:WIND_REFERENCE_WATER_TRUE_NORTH, 5)
end

defmodule NauticNet.Protobuf.DataSet.DataPoint do
  @moduledoc false
  use Protobuf, protoc_gen_elixir_version: "0.11.0", syntax: :proto3

  oneof(:sample, 0)

  field(:timestamp, 1, type: Google.Protobuf.Timestamp)
  field(:hw_unique_number, 2, type: :uint32, json_name: "hwUniqueNumber")
  field(:heading, 16, type: NauticNet.Protobuf.HeadingSample, oneof: 0)
  field(:speed, 17, type: NauticNet.Protobuf.SpeedSample, oneof: 0)
  field(:velocity, 18, type: NauticNet.Protobuf.VelocitySample, oneof: 0)

  field(:wind_velocity, 19,
    type: NauticNet.Protobuf.WindVelocitySample,
    json_name: "windVelocity",
    oneof: 0
  )

  field(:water_depth, 20,
    type: NauticNet.Protobuf.WaterDepthSample,
    json_name: "waterDepth",
    oneof: 0
  )

  field(:position, 21, type: NauticNet.Protobuf.PositionSample, oneof: 0)
end

defmodule NauticNet.Protobuf.DataSet do
  @moduledoc false
  use Protobuf, protoc_gen_elixir_version: "0.11.0", syntax: :proto3

  field(:counter, 1, type: :uint32)

  field(:data_points, 2,
    repeated: true,
    type: NauticNet.Protobuf.DataSet.DataPoint,
    json_name: "dataPoints"
  )

  field(:ref, 3, type: :string)
end

defmodule NauticNet.Protobuf.HeadingSample do
  @moduledoc false
  use Protobuf, protoc_gen_elixir_version: "0.11.0", syntax: :proto3

  field(:angle_reference, 1,
    type: NauticNet.Protobuf.AngleReference,
    json_name: "angleReference",
    enum: true
  )

  field(:angle_rad, 2, type: :float, json_name: "angleRad")
end

defmodule NauticNet.Protobuf.SpeedSample do
  @moduledoc false
  use Protobuf, protoc_gen_elixir_version: "0.11.0", syntax: :proto3

  field(:speed_reference, 1,
    type: NauticNet.Protobuf.SpeedReference,
    json_name: "speedReference",
    enum: true
  )

  field(:speed_m_s, 2, type: :float, json_name: "speedMS")
end

defmodule NauticNet.Protobuf.VelocitySample do
  @moduledoc false
  use Protobuf, protoc_gen_elixir_version: "0.11.0", syntax: :proto3

  field(:speed_reference, 1,
    type: NauticNet.Protobuf.SpeedReference,
    json_name: "speedReference",
    enum: true
  )

  field(:angle_reference, 2,
    type: NauticNet.Protobuf.AngleReference,
    json_name: "angleReference",
    enum: true
  )

  field(:speed_m_s, 3, type: :float, json_name: "speedMS")
  field(:angle_rad, 4, type: :float, json_name: "angleRad")
end

defmodule NauticNet.Protobuf.WindVelocitySample do
  @moduledoc false
  use Protobuf, protoc_gen_elixir_version: "0.11.0", syntax: :proto3

  field(:wind_reference, 1,
    type: NauticNet.Protobuf.WindReference,
    json_name: "windReference",
    enum: true
  )

  field(:speed_m_s, 2, type: :float, json_name: "speedMS")
  field(:angle_rad, 3, type: :float, json_name: "angleRad")
end

defmodule NauticNet.Protobuf.WaterDepthSample do
  @moduledoc false
  use Protobuf, protoc_gen_elixir_version: "0.11.0", syntax: :proto3

  field(:depth_m, 1, type: :float, json_name: "depthM")
end

defmodule NauticNet.Protobuf.PositionSample do
  @moduledoc false
  use Protobuf, protoc_gen_elixir_version: "0.11.0", syntax: :proto3

  field(:latitude, 1, type: :float)
  field(:longitude, 2, type: :float)
end
