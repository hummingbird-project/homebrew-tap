class Hb < Formula
  desc "Command-line for Hummingbird server framework"
  homepage "https://hummingbird.codes"
  url "https://github.com/hummingbird-project/hb/archive/refs/tags/0.3.0.tar.gz"
  sha256 "7ec0fb564c3b123da2790962aaef9a1734a8f77837b28892876d0feaf7fe2e87"
  license "Apache-2.0"

  bottle do
    root_url "https://github.com/hummingbird-project/homebrew-tap/releases/download/hb-0.2.2"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "904a05c7ce0c7f104e3c87fb252879be3d79eef9a46144e5c410a746f73414c8"
    sha256 cellar: :any_skip_relocation, tahoe:       "6fd8681048a67735a4dc447964a8573fd35ae285b9bd2311ccca339af8951d73"
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
