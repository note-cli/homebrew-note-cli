class Mytool < Formula
  desc "A simple tool"
  homepage "https://example.com/mytool"
  url "https://example.com/path/to/your/executable.tar.gz"
  sha256 "your-sha256-checksum"

  def install
    bin.install "mytool"
  end

  test do
    system "#{bin}/mytool", "--version"
  end
end
