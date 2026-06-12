class Hb < Formula
  desc "Command-line for Hummingbird server framework"
  homepage "https://hummingbird.codes"
  url "https://github.com/hummingbird-project/hb/archive/refs/tags/0.2.2.tar.gz"
  sha256 "d94b2993dc7ae308cc7899f79b4756efe44f59f0a6da4adf1f79d343c2e8c4a9"
  license "Apache-2.0"

  bottle do
    root_url "https://github.com/hummingbird-project/homebrew-tap/releases/download/hb-0.1.2"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "2e2e7b9a37abbc658db834d4c16a55dea0be4eed2cb97008eae1ac25349b5f94"
    sha256 cellar: :any_skip_relocation, tahoe:       "b1ead328766437ae060780acd981dc8d19a68ba4f203a90bab5cd7b79c547550"
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
