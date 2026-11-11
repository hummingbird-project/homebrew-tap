class Hb < Formula
  desc "Command-line for Hummingbird server framework"
  homepage "https://hummingbird.codes"
  url "https://github.com/hummingbird-project/hb/archive/refs/tags/0.6.0.tar.gz"
  sha256 "a4dd2f1ac5a6d96595ab06bd202ee8f8a3588d0a44a2ff8a369c732c53b10384"
  license "Apache-2.0"

  bottle do
    root_url "https://github.com/hummingbird-project/homebrew-tap/releases/download/hb-0.6.0"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "842f8e64e9f09dd639336eb8a216593c34f962b1dbf7066b62796d5562817c59"
    sha256 cellar: :any_skip_relocation, tahoe:        "6490c43bd86ff4449cb630c0bd3ee01eddb3959af097a3b5e1a67ce58efc9016"
    sha256 cellar: :any,                 x86_64_linux: "d766d762cb5a07fddfe2224a9c391eb2297da7a2f8d604f34a093ccda3d45319"
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
