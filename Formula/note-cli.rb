class NoteCli < Formula
  desc "note-cli - terminal-based, cloud stored notebook system"
  homepage "https://note-cli.com/"
  version "0.5.0" 
  url = ""
  sha256 = ""
  base_url = "https://note-cli.com"
  
  if OS.mac?
    if Hardware::CPU.arm?
      url = "#{base_url}/download-macosarm-note-cli-0.5.0"
      sha256 = "8b5c76309ef97ffb44b99fcf5b8ae51cd03cfc41ff7ac278f99252a69d5f5f19"
    else 
      odie "MacOS intel not supported yet"
    end
  elsif OS.linux?
    if Hardware::CPU.intel?
      url = "#{base_url}/download-linuxx86-note-cli-0.5.0"
      sha256 = "b9653e46a3ea825f23a8c2246d932cd31f3452ebcada93ab5bd234e5ec0e4499"
    else
      odie "Linux arm not supported yet"
    end
  else
    odie "unsupported OS, please use MacOS or Linux."
  end

  url url, using: CurlDownloadStrategy
  sha256 sha256
  
  depends_on "curl"

  def install
    bin.install "note-cli"
  end

  def post_install
    config_url = "https://note-cli.com/download-note-cli-config" # URL to your config file
    config_dir = etc/"notecli"
    target_file = config_dir/".noteclirc"

    # Create the configuration directory if it doesn't exist
    config_dir.mkpath

    # Download the configuration file
    system "curl", "-o", target_file, config_url

    # Verify the file was downloaded
    unless target_file.exist?
      odie "Failed to download the configuration file"
    end

    # Post-install message
    ohai "Configuration file has been placed in #{target_file}"
    ohai "before running note-cli, move it to your home directory:"
    ohai "mv #{target_file} ~/.noteclirc"
  end

  test do
    system "#{bin}/note-cli", "--version"
  end
end
