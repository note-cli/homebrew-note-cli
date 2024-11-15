class NoteCli < Formula
  desc "note-cli - terminal-based, cloud stored notebook system"
  homepage "https://meta-origin-439004-d8.ue.r.appspot.com/"
  url "https://meta-origin-439004-d8.ue.r.appspot.com/download-note-cli"
  sha256 "837ff245e2ec3c4eb9912c4ed0bfbf9d66cda1e5726fd8e8dd35862e692a5a98"
  version "0.3.1" 

  depends_on "jansson"
  depends_on "cjson"
  depends_on "curl"

  def install
    bin.install "note-cli"
  end

  def post_install
    config_url = "https://meta-origin-439004-d8.ue.r.appspot.com/download-note-cli-config" # URL to your config file
    home_dir = Dir.home
    config_dir = File.join(home_dir, ".notecli")
    target_file = File.join(config_dir, ".noteclirc")

    # Create the configuration directory if it doesn't exist
    mkdir_p config_dir

    # Download the configuration file
    system "curl", "-o", target_file, config_url
  end

  test do
    system "#{bin}/note-cli", "--version"
  end
end
