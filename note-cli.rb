class Mytool < Formula
  desc "note-cli - terminal-based, cloud stored notebook system"
  homepage "https://example.com/"
  url "https://example.com/download-latest"
  sha256 "your-sha256-checksum"

  depends_on "jansson"
  depends_on "another-dependency"

  def install
    bin.install "note-cli"
  end

  def post_install
    config_url = "https://example.com/path/to/config/file" # URL to your config file
    home_dir = Dir.home
    target_file = File.join(home_dir, ".noteclirc")

    # Download the configuration file
    system "curl", "-o", target_file, config_url
  end

  test do
    system "#{bin}/note-cli", "--version"
  end
end
