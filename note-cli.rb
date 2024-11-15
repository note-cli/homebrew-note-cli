class Mytool < Formula
  desc "A simple tool"
  homepage "https://example.com/mytool"
  url "https://example.com/path/to/your/executable"
  sha256 "your-sha256-checksum"

  depends_on "jansson"
  depends_on "another-dependency"

  def install
    bin.install "executable"
  end

  def post_install
    config_url = "https://example.com/path/to/config/file" # URL to your config file
    home_dir = Dir.home
    target_file = File.join(home_dir, "config.yaml")

    # Download the configuration file
    system "curl", "-o", target_file, config_url
  end

  test do
    system "#{bin}/executable", "--version"
  end
end
