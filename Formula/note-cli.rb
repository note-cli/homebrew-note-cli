class NoteCli < Formula
  desc "note-cli - terminal-based, cloud stored notebook system"
  homepage "https://note-cli.com/"
  version "0.3.19" 
  url = ""
  sha256 = ""
  base_url = "https://note-cli.com"
  
  if OS.mac?
    if Hardware::CPU.arm?
      url = "#{base_url}/download-macosarm-note-cli"
      sha256 = "b6ac5a2ed32d1db2ad049d38facc998a2639e620985842b20b48ccd20f1a52c7"
    else 
      odie "MacOS intel not supported yet"
    end
  elsif OS.linux?
    if Hardware::CPU.intel?
      url = "#{base_url}/download-linuxx86-note-cli"
      sha256 = "ac77d4490d57204a5447f01960f5e88ac4c95781aa82cf9916c4a1e6aa3ed432"
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
