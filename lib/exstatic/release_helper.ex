defmodule Exstatic.ReleaseHelper do
  @config Mix.Project.config()
  @tag "v#{@config[:version]}"

  @spec github_release_url!(String.t()) :: {String.t(), [{String.t(), String.t()}]}
  def github_release_url!(file_name) do
    start_finch()

    token = System.fetch_env!("EXSTATIC_GITHUB_TOKEN")

    case fetch_github_asset_id(file_name) do
      {:ok, asset_id} ->
        {asset_url(asset_id),
         [
           {"Authorization", "token #{token}"},
           {"Accept", "application/octet-stream"},
           {"User-Agent", "exstatic-bot"}
         ]}

      {:error, reason} ->
        raise "Failed to fetch GitHub asset ID: #{reason}"
    end
  end

  defp fetch_github_asset_id(file_name) do
    start_finch()

    token = github_personal_access_token!()

    headers = [
      {"Authorization", "token #{token}"},
      {"Accept", "application/vnd.github+json"},
      {"User-Agent", "exstatic-bot"}
    ]

    case Req.get(release_url(), headers: headers) do
      {:ok, %{status: 200, body: release}} ->
        case Enum.find(release["assets"], fn asset -> asset["name"] == file_name end) do
          nil -> {:error, "Asset not found: #{file_name} in release #{@tag}"}
          asset -> {:ok, asset["id"]}
        end

      {:ok, %{status: status, body: body}} ->
        {:error, "Failed to fetch releases: #{status} #{inspect(body)}"}

      {:error, reason} ->
        {:error, reason}
    end
  end

  defp asset_url(asset_id) do
    "https://uploads.github.com/repos/#{@config[:repo]}/releases/#{asset_id}/assets"
  end

  defp release_url, do: "https://api.github.com/repos/#{@config[:repo]}/releases/tags/#{@tag}"

  defp github_personal_access_token! do
    case System.get_env("EXSTATIC_GITHUB_TOKEN") do
      nil ->
        raise "Missing EXSTATIC_GITHUB_TOKEN environment variable (GitHub personal access token)."

      token ->
        token
    end
  end

  defp start_finch do
    unless Process.whereis(Req.Finch) do
      {:ok, _} = Finch.start_link(name: Req.Finch)
    end
  end
end
