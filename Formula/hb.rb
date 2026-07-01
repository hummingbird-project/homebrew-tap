class Hb < Formula
  desc "Command-line for Hummingbird server framework"
  homepage "https://hummingbird.codes"
  url "https://github.com/hummingbird-project/hb/archive/refs/tags/0.5.0.tar.gz"
  sha256 "bb46a83796b93be59de09b6f9f44a5cdcff334c965371f10cd8f28cefe62ff0e"
  license "Apache-2.0"

  bottle do
    root_url "https://github.com/hummingbird-project/homebrew-tap/releases/download/hb-0.5.0"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "761ec946fcc1c666399fcfd75e0362099aae4276c650c163adae747349204c40"
    sha256 cellar: :any_skip_relocation, tahoe:        "1651f801fdcec4681604d0077b5604e8f5a90a27daa3817c36eabac1f82fad06"
    sha256 cellar: :any,                 x86_64_linux: "480d8245ff69aaf906f27bf24ba506ad4f67cfdee3800e1f60d29316d884d02a"
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
