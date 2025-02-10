defmodule Exstatic.ReleaseHelper do
  @moduledoc """
  A helper module for fetching precompiled assets from a private GitHub release. 

  If/when Exstatic becomes a public repo this will not be necessary.

  This module is designed to work with `RustlerPrecompiled`, allowing it to dynamically
  fetch the correct precompiled NIF binaries from a GitHub release using the GitHub API.
  It retrieves the asset ID for a given file name and constructs a download URL with the
  necessary authentication headers.

   ## Required Environment Variables

  - `EXSTATIC_GITHUB_TOKEN` – A GitHub personal access token (PAT) with access to private repositories.
  """

  @config Mix.Project.config()
  @tag "v#{@config[:version]}"

  @doc """
  Retrieves the GitHub asset download URL and authentication headers.

  ## Parameters

  - `file_name` (String.t()): The name of the asset file to download.

  ## Returns

  - `{download_url, headers}` (tuple): A tuple containing the GitHub asset URL and headers.

  ## Raises

  - `RuntimeError`: If the `EXSTATIC_GITHUB_TOKEN` environment variable is missing or if the asset ID cannot be found.

  ## Example

      iex> Exstatic.ReleaseHelper.github_release_url!("libexstatic-v0.1.1-nif-2.16-aarch64-apple-darwin.so.tar.gz")
      {"https://api.github.com/repos/Intellection/exstatic/releases/assets/227243824",
      [{"Authorization", "token MY_TOKEN"}, {"Accept", "application/octet-stream"}, {"User-Agent", "exstatic-bot"}]}
  """
  @spec github_release_url!(String.t()) :: {String.t(), [{String.t(), String.t()}]}
  def github_release_url!(file_name) do
    token = github_personal_access_token!()

    case fetch_github_asset_id(file_name, token) do
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

  defp fetch_github_asset_id(file_name, token) do
    headers = [
      {"Authorization", "token #{token}"},
      {"Accept", "application/vnd.github+json"},
      {"User-Agent", "exstatic-bot"}
    ]

    case Tesla.get(release_url(), headers: headers) do
      {:ok, %Tesla.Env{status: 200, body: release}} ->
        release
        |> :json.decode()
        |> find_asset_id(file_name)

      {:ok, %Tesla.Env{status: status, body: body}} ->
        {:error, "Failed to fetch releases: #{status} #{inspect(body)}"}

      {:error, reason} ->
        {:error, reason}
    end
  end

  defp asset_url(asset_id) do
    "https://api.github.com/repos/#{@config[:repo]}/releases/assets/#{asset_id}"
  end

  defp release_url, do: "https://api.github.com/repos/#{@config[:repo]}/releases/tags/#{@tag}"

  defp find_asset_id(release, file_name) do
    case Enum.find(release["assets"], fn asset -> asset["name"] == file_name end) do
      nil -> {:error, "Asset not found: #{file_name} in release #{@tag}"}
      asset -> {:ok, asset["id"]}
    end
  end

  defp github_personal_access_token! do
    case System.get_env("EXSTATIC_GITHUB_TOKEN") do
      nil -> raise "Missing EXSTATIC_GITHUB_TOKEN environment variable."
      token -> token
    end
  end
end
