class SwiftMustacheCli < Formula
  desc "Command-line tool for rendering Mustache templates"
  homepage "https://github.com/hummingbird-project/swift-mustache-cli"
  url "https://github.com/hummingbird-project/swift-mustache-cli/archive/refs/tags/0.2.1.tar.gz"
  sha256 "8cb611df7ae297ed50c2f6e4d478bacbed83f593ae5d52d781d8ab67649a9b42"
  license "Apache-2.0"

  bottle do
    root_url "https://github.com/hummingbird-project/homebrew-tap/releases/download/swift-mustache-cli-0.2.1"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "ff1b4b4591be961abc3b1bcea085753e7ff06ae33d83e8701621b132cd40e541"
    sha256 cellar: :any_skip_relocation, tahoe:        "2840ea0956edfd64d9bc2468b3121868774ea830bd003b47692cc2bc5f901968"
    sha256 cellar: :any,                 x86_64_linux: "6e11e8c3222b43efc439a703403f1381323178afed43441417b1c06949741b6c"
  end

  depends_on xcode: ["16.3", :build]
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
    system "swift", "build", *args, "-c", "release", "-Xswiftc", "-cross-module-optimization"
    bin.install ".build/release/mustache"
  end

  test do
    (testpath/"test.template").write "{{test}}"
    (testpath/"test.context").write '{"test":"this"}'
    system bin/"mustache", testpath/"test.context", testpath/"test.template"
  end
end
