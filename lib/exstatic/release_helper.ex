defmodule Exstatic.ReleaseHelper do
  @moduledoc """
  A helper module for fetching precompiled assets from a private GitHub release.

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
  Retrieves the GitHub asset download URL and authentication headers. This function first ensures that then Finch
  HTTP client is started. It then fetches the asset ID for the given file name from the GitHub API and constructs a download URL.

  ## Parameters
  - `file_name` (String.t()): The name of the asset file to download.

  ## Returns
  - `{"https://api.github.com/repos/.../assets/{asset_id}", headers}` (tuple): 
    A tuple containing the download URL and required HTTP headers.

  ## Raises
  - `RuntimeError`: If the EXSTATIC_GITHUB_TOKEN environment variable is missing or if the asset ID cannot be found.

  ## Example

      iex> Exstatic.ReleaseHelper.github_release_url!("libexstatic-v0.1.1-nif-2.16-aarch64-apple-darwin.so.tar.gz")
      {"https://api.github.com/repos/Intellection/exstatic/releases/assets/227243824",
      [{"Authorization", "token MY_TOKEN"}, {"Accept", "application/octet-stream"}, {"User-Agent", "exstatic-bot"}]}
  """
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
        find_asset_id(release, file_name)

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

  defp find_asset_id(release, file_name) do
    case Enum.find(release["assets"], fn asset -> asset["name"] == file_name end) do
      nil -> {:error, "Asset not found: #{file_name} in release #{@tag}"}
      asset -> {:ok, asset["id"]}
    end
  end

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
      {:ok, _pid} = Finch.start_link(name: Req.Finch)
    end
  end
end
