class NoteCli < Formula
  desc "note-cli - terminal-based, cloud stored notebook system"
  homepage "https://note-cli.com/"
  # url "https://note-cli.com/download-note-cli"
  # sha256 "7a884e17c9079fd0c4bf75a8e8a08db09a1acfa15597fbc2f2eb6cfc8c689194"
  version "0.3.16" 
  url = ""
  sha256 = ""
  base_url = "https://note-cli.com"
  
  if OS.mac?
    if Hardware::CPU.arm?
      url = "#{base_url}/download-macosarm-note-cli"
      sha256 = "14f4239800ec69c20fa80c7ef3c2f48efd880cefd3287b52943f5c57cdb1f570"
    else 
      odie "MacOS intel not supported yet"
    end
  elsif OS.linux?
    if Hardware::CPU.intel?
      url = "#{base_url}/download-linuxx86-note-cli"
      sha256 = "f618b6f00b7294f99f692bf72eae37736f3dbacbe446aa08f0341903c2f445e2"
    else
      odie "Linux arm not supported yet"
    end
  
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
