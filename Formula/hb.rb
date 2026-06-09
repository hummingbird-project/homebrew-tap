class Hb < Formula
  desc "Command-line for Hummingbird server framework"
  homepage "https://hummingbird.codes"
  url "https://github.com/hummingbird-project/hb/archive/refs/tags/0.1.0.tar.gz"
  sha256 "147157b6fa47189028306b305497b548e17c6a80654d93c56df674c0ece4b6e5"
  license ""

  depends_on xcode: ["26.2", :build]
  uses_from_macos "swift" => :build

  on_macos do
    depends_on macos: :tahoe
  end

  on_linux do
    depends_on "curl"
  end

  def install
    args = if OS.mac?
      ["--disable-sandbox"]
    else
      ["--static-swift-stdlib"]
    end
    system "swift", "build", *args, "-c", "release", "-Xswiftc", "-cross-module-optimization"
    bin.install ".build/release/hb"
  end

  test do
    system bin/"hb", "init", "--default", "my-project"
    assert_path_exists testpath/"my-project/Package.swift"
  end
end
