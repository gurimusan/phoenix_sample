defmodule PhoenixSample.Guardian do
  use Guardian, otp_app: :phoenix_sample

  alias PhoenixSample.User
  alias PhoenixSample.Services.UserService

  def subject_for_token(%User{} = resource, _claims) do
    {:ok, to_string(resource.id)}
  end

  def subject_for_token(_, _) do
    {:error, :reason_for_error}
  end

  def resource_from_claims(claims) do
    {:ok, UserService.user_by_id(claims["sub"])}
  end

  def resource_from_claims(_claims) do
    {:error, :reason_for_error}
  end
end
