class NoteCli < Formula
  desc "note-cli - terminal-based, cloud stored notebook system"
  homepage "https://note-cli.com/"
  url "https://note-cli.com/download-note-cli"
  sha256 "4bc7ffce6f0a33502c817284d99e2b0f78faa114888344b8f32c4805b20183d5"
  version "0.3.10" 

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
