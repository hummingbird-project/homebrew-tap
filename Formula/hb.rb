class Hb < Formula
  desc "Command-line for Hummingbird server framework"
  homepage "https://hummingbird.codes"
  url "https://github.com/hummingbird-project/hb/archive/refs/tags/0.4.0.tar.gz"
  sha256 "ee8c38a310e0061df57a6f7fe1b78f2ad04f0d20b3deb1d9dbf19d3dbea999e4"
  license "Apache-2.0"

  bottle do
    root_url "https://github.com/hummingbird-project/homebrew-tap/releases/download/hb-0.4.0"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "8200ee90af23ab17601f733bde0183bd8b2d2dd8f4bb863bf7fcab628ac2f880"
    sha256 cellar: :any_skip_relocation, tahoe:        "432078bf2eb9f0976b997c7e311eb763f20d9e51b3d51b95f1e5b87613e4e87a"
    sha256 cellar: :any,                 x86_64_linux: "6c0a8ce0e9696a1cf4a677be33b50819e599f12fbfce2056ff5db4e086112b6b"
  end

  depends_on xcode: ["26.2", :build]
  uses_from_macos "swift" => :build

  on_macos do
    depends_on macos: :sequoia
  end

  def install
    args = if OS.mac?
      ["--disable-sandbox"]
    else
      ["--static-swift-stdlib"]
    end
    system "swift", "build", *args, "-c", "release"
    bin.install ".build/release/hb"
  end

  test do
    system bin/"hb", "init", "--answer", "name=my-project", "my-project"
    assert_path_exists testpath/"my-project/Package.swift"
  end
end
