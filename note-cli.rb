class note-cli < Formula
  desc "note-cli - terminal-based, cloud stored notebook system"
  homepage "https://meta-origin-439004-d8.ue.r.appspot.com/"
  url "https://meta-origin-439004-d8.ue.r.appspot.com/download-note-cli"
  sha256 "41b27737a54e5b7e1337f8f6ded35433415c6a82ef47e458386c2b6e0b4dca1a"
  version "0.3.7" 

  depends_on "jansson"
  depends_on "cjson"
  depends_on "curl"

  def install
    bin.install "note-cli"
  end

  def post_install
    config_url = "https://meta-origin-439004-d8.ue.r.appspot.com/download-note-cli-config" # URL to your config file
    home_dir = Dir.home
    target_file = File.join(home_dir, ".noteclirc")

    # Download the configuration file
    system "curl", "-o", target_file, config_url
  end

  test do
    system "#{bin}/note-cli", "--version"
  end
end
