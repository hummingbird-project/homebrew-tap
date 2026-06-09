class SwiftMustacheCli < Formula
  desc "Command-line tool for rendering Mustache templates"
  homepage "https://github.com/hummingbird-project/swift-mustache-cli"
  url "https://github.com/hummingbird-project/swift-mustache-cli/archive/refs/tags/0.2.1.tar.gz"
  sha256 "8cb611df7ae297ed50c2f6e4d478bacbed83f593ae5d52d781d8ab67649a9b42"
  license "Apache-2.0"

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
