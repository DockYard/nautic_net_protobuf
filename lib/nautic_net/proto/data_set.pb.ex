defmodule NauticNet.Proto.DirectionReference do
  @moduledoc false
  use Protobuf, enum: true, protoc_gen_elixir_version: "0.10.0", syntax: :proto3

  field(:DIRECTION_REFERENCE_NONE, 0)
  field(:DIRECTION_REFERENCE_TRUE, 1)
  field(:DIRECTION_REFERENCE_MAGNETIC, 2)
end

defmodule NauticNet.Proto.WindReference do
  @moduledoc false
  use Protobuf, enum: true, protoc_gen_elixir_version: "0.10.0", syntax: :proto3

  field(:WIND_REFERENCE_NONE, 0)
  field(:WIND_REFERENCE_TRUE, 1)
  field(:WIND_REFERENCE_MAGNETIC, 2)
  field(:WIND_REFERENCE_APPARENT, 3)
  field(:WIND_REFERENCE_TRUE_BOAT, 4)
  field(:WIND_REFERENCE_TRUE_WATER, 5)
end

defmodule NauticNet.Proto.DataSet.DataPoint do
  @moduledoc false
  use Protobuf, protoc_gen_elixir_version: "0.10.0", syntax: :proto3

  oneof(:sample, 0)

  field(:timestamp, 1, type: Google.Protobuf.Timestamp)
  field(:hw_unique_number, 2, type: :uint32, json_name: "hwUniqueNumber")
  field(:heading, 16, type: NauticNet.Proto.HeadingSample, oneof: 0)

  field(:speed_water_referenced, 17,
    type: NauticNet.Proto.SpeedSample,
    json_name: "speedWaterReferenced",
    oneof: 0
  )

  field(:velocity_over_ground, 18,
    type: NauticNet.Proto.VelocitySample,
    json_name: "velocityOverGround",
    oneof: 0
  )

  field(:wind_velocity, 19,
    type: NauticNet.Proto.WindVelocitySample,
    json_name: "windVelocity",
    oneof: 0
  )

  field(:water_depth, 20,
    type: NauticNet.Proto.WaterDepthSample,
    json_name: "waterDepth",
    oneof: 0
  )

  field(:position, 21, type: NauticNet.Proto.PositionSample, oneof: 0)
end

defmodule NauticNet.Proto.DataSet do
  @moduledoc false
  use Protobuf, protoc_gen_elixir_version: "0.10.0", syntax: :proto3

  field(:counter, 1, type: :uint32)

  field(:data_points, 2,
    repeated: true,
    type: NauticNet.Proto.DataSet.DataPoint,
    json_name: "dataPoints"
  )

  field(:ref, 3, type: :string)
end

defmodule NauticNet.Proto.HeadingSample do
  @moduledoc false
  use Protobuf, protoc_gen_elixir_version: "0.10.0", syntax: :proto3

  field(:reference, 1, type: NauticNet.Proto.DirectionReference, enum: true)
  field(:heading_deg, 2, type: :float, json_name: "headingDeg")
end

defmodule NauticNet.Proto.SpeedSample do
  @moduledoc false
  use Protobuf, protoc_gen_elixir_version: "0.10.0", syntax: :proto3

  field(:speed_kt, 1, type: :float, json_name: "speedKt")
end

defmodule NauticNet.Proto.VelocitySample do
  @moduledoc false
  use Protobuf, protoc_gen_elixir_version: "0.10.0", syntax: :proto3

  field(:reference, 1, type: NauticNet.Proto.DirectionReference, enum: true)
  field(:speed_kt, 2, type: :float, json_name: "speedKt")
  field(:angle_deg, 3, type: :float, json_name: "angleDeg")
end

defmodule NauticNet.Proto.WindVelocitySample do
  @moduledoc false
  use Protobuf, protoc_gen_elixir_version: "0.10.0", syntax: :proto3

  field(:reference, 1, type: NauticNet.Proto.WindReference, enum: true)
  field(:speed_kt, 2, type: :float, json_name: "speedKt")
  field(:angle_deg, 3, type: :float, json_name: "angleDeg")
end

defmodule NauticNet.Proto.WaterDepthSample do
  @moduledoc false
  use Protobuf, protoc_gen_elixir_version: "0.10.0", syntax: :proto3

  field(:depth, 1, type: :float)
end

defmodule NauticNet.Proto.PositionSample do
  @moduledoc false
  use Protobuf, protoc_gen_elixir_version: "0.10.0", syntax: :proto3

  field(:latitude, 1, type: :float)
  field(:longitude, 2, type: :float)
end
