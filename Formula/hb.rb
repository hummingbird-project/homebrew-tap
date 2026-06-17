class Hb < Formula
  desc "Command-line for Hummingbird server framework"
  homepage "https://hummingbird.codes"
  url "https://github.com/hummingbird-project/hb/archive/refs/tags/0.3.1.tar.gz"
  sha256 "637478d86b99c7e93f0d4dd2a2209f056616001e63c203ab82567ce79ad03ae6"
  license "Apache-2.0"

  bottle do
    root_url "https://github.com/hummingbird-project/homebrew-tap/releases/download/hb-0.3.0"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "ef9fed74fd56cafe1936db8ea6cbd19d2f9b0d93b9db5ea562ed723466232108"
    sha256 cellar: :any_skip_relocation, tahoe:        "7d286a95725477671fd0f43e135f43b19f9a1ea4104695bf1b8b1726074400e8"
    sha256 cellar: :any,                 x86_64_linux: "45625e6a8921168d8c6d0544faaf9f77f60f6c56096fc5d5a4ca9b2f12e126ed"
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
    system bin/"hb", "init", "--default", "my-project"
    assert_path_exists testpath/"my-project/Package.swift"
  end
end
