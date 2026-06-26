class Hb < Formula
  desc "Command-line for Hummingbird server framework"
  homepage "https://hummingbird.codes"
  url "https://github.com/hummingbird-project/hb/archive/refs/tags/0.4.0.tar.gz"
  sha256 "ee8c38a310e0061df57a6f7fe1b78f2ad04f0d20b3deb1d9dbf19d3dbea999e4"
  license "Apache-2.0"

  bottle do
    root_url "https://github.com/hummingbird-project/homebrew-tap/releases/download/hb-0.3.1"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "c77b4270c8de70e4d2df0db526d75aae1eea76b0a4c5cebd407dc65467a95ac9"
    sha256 cellar: :any_skip_relocation, tahoe:        "cfe9d57a885a6a531d77954fd169daa0a9d6818bae694d2dd60133d8e65f6bd9"
    sha256 cellar: :any,                 x86_64_linux: "6957a3d05454fc71c7d158ed98ef31e41530e2cb023d7e876afe87e9ff181d67"
  end

  depends_on xcode: ["26.2", :build]
  uses_from_macos "swift" => :build

  on_macos do
    depends_on macos: :tahoe
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
