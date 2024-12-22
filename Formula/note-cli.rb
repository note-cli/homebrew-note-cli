class NoteCli < Formula
  desc "note-cli - terminal-based, cloud stored notebook system"
  homepage "https://note-cli.com/"
  version "0.3.20" 
  url = ""
  sha256 = ""
  base_url = "https://note-cli.com"
  
  if OS.mac?
    if Hardware::CPU.arm?
      url = "#{base_url}/download-macosarm-note-cli"
      sha256 = "53351e5dac7c49b3f003737e681699ae9b57fbbf488d3e29c8f5fac4a4cbd35a"
    else 
      odie "MacOS intel not supported yet"
    end
  elsif OS.linux?
    if Hardware::CPU.intel?
      url = "#{base_url}/download-linuxx86-note-cli"
      sha256 = "9e62bafdfc4a88553a3fd86ef4898d68e73ae292c88a15ebde671a18179055b0"
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
