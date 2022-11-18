defmodule NauticNet.Protobuf.DirectionReference do
  @moduledoc false
  use Protobuf, enum: true, protoc_gen_elixir_version: "0.10.0", syntax: :proto3

  field(:DIRECTION_REFERENCE_NONE, 0)
  field(:DIRECTION_REFERENCE_TRUE, 1)
  field(:DIRECTION_REFERENCE_MAGNETIC, 2)
end

defmodule NauticNet.Protobuf.WindReference do
  @moduledoc false
  use Protobuf, enum: true, protoc_gen_elixir_version: "0.10.0", syntax: :proto3

  field(:WIND_REFERENCE_NONE, 0)
  field(:WIND_REFERENCE_TRUE, 1)
  field(:WIND_REFERENCE_MAGNETIC, 2)
  field(:WIND_REFERENCE_APPARENT, 3)
  field(:WIND_REFERENCE_TRUE_BOAT, 4)
  field(:WIND_REFERENCE_TRUE_WATER, 5)
end

defmodule NauticNet.Protobuf.DataSet.DataPoint do
  @moduledoc false
  use Protobuf, protoc_gen_elixir_version: "0.10.0", syntax: :proto3

  oneof(:sample, 0)

  field(:timestamp, 1, type: Google.Protobuf.Timestamp)
  field(:hw_unique_number, 2, type: :uint32, json_name: "hwUniqueNumber")
  field(:heading, 16, type: NauticNet.Protobuf.HeadingSample, oneof: 0)

  field(:speed_water_referenced, 17,
    type: NauticNet.Protobuf.SpeedSample,
    json_name: "speedWaterReferenced",
    oneof: 0
  )

  field(:velocity_over_ground, 18,
    type: NauticNet.Protobuf.VelocitySample,
    json_name: "velocityOverGround",
    oneof: 0
  )

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
  use Protobuf, protoc_gen_elixir_version: "0.10.0", syntax: :proto3

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
  use Protobuf, protoc_gen_elixir_version: "0.10.0", syntax: :proto3

  field(:reference, 1, type: NauticNet.Protobuf.DirectionReference, enum: true)
  field(:heading_deg, 2, type: :float, json_name: "headingDeg")
end

defmodule NauticNet.Protobuf.SpeedSample do
  @moduledoc false
  use Protobuf, protoc_gen_elixir_version: "0.10.0", syntax: :proto3

  field(:speed_kt, 1, type: :float, json_name: "speedKt")
end

defmodule NauticNet.Protobuf.VelocitySample do
  @moduledoc false
  use Protobuf, protoc_gen_elixir_version: "0.10.0", syntax: :proto3

  field(:reference, 1, type: NauticNet.Protobuf.DirectionReference, enum: true)
  field(:speed_kt, 2, type: :float, json_name: "speedKt")
  field(:angle_deg, 3, type: :float, json_name: "angleDeg")
end

defmodule NauticNet.Protobuf.WindVelocitySample do
  @moduledoc false
  use Protobuf, protoc_gen_elixir_version: "0.10.0", syntax: :proto3

  field(:reference, 1, type: NauticNet.Protobuf.WindReference, enum: true)
  field(:speed_kt, 2, type: :float, json_name: "speedKt")
  field(:angle_deg, 3, type: :float, json_name: "angleDeg")
end

defmodule NauticNet.Protobuf.WaterDepthSample do
  @moduledoc false
  use Protobuf, protoc_gen_elixir_version: "0.10.0", syntax: :proto3

  field(:depth, 1, type: :float)
end

defmodule NauticNet.Protobuf.PositionSample do
  @moduledoc false
  use Protobuf, protoc_gen_elixir_version: "0.10.0", syntax: :proto3

  field(:latitude, 1, type: :float)
  field(:longitude, 2, type: :float)
end
