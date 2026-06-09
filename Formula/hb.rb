class Hb < Formula
  desc "Command-line for Hummingbird server framework"
  homepage "https://hummingbird.codes"
  url "https://github.com/hummingbird-project/hb/archive/refs/tags/0.1.2.tar.gz"
  sha256 "f97be5b7d7a1c08e54a4e09c492fe2bcda7421ead537493a7cbe00d0b6179cc3"
  license "Apache-2.0"

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
      ["--static-swift-stdlib", "-Xlinker", "-L/home/linuxbrew/.linuxbrew/lib"]
    end
    system "swift", "build", *args, "-c", "release", "-Xswiftc", "-cross-module-optimization"
    bin.install ".build/release/hb"
  end

  test do
    system bin/"hb", "init", "--default", "my-project"
    assert_path_exists testpath/"my-project/Package.swift"
  end
end
