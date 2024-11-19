class NoteCli < Formula
  desc "note-cli - terminal-based, cloud stored notebook system"
  homepage "https://meta-origin-439004-d8.ue.r.appspot.com/"
  url "https://note-cli.com/download-note-cli"
  sha256 "37b48cf8f0b6ed0c4c5f83d97698c18d5413eca93000af11da62a99cb382c7e0"
  version "0.3.3" 

  depends_on "jansson"
  depends_on "cjson"
  depends_on "curl"

  def install
    bin.install "note-cli"
  end

  def post_install
    config_url = "https://meta-origin-439004-d8.ue.r.appspot.com/download-note-cli-config" # URL to your config file
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
