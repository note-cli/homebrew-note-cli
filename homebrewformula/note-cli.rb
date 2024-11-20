class NoteCli < Formula
  desc "note-cli - terminal-based, cloud stored notebook system"
  homepage "https://meta-origin-439004-d8.ue.r.appspot.com/"
  url "https://note-cli.com/download-note-cli"
  sha256 "d74d37a35850a7d3b32914b38630583c7f66d4f0a677ed1a60533cbad9c438ba"
  version "0.3.4" 

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
