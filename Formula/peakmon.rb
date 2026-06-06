class Peakmon < Formula
  desc "Native, lightweight macOS menu-bar system monitor"
  homepage "https://github.com/crafcat7/Peakmon"
  url "https://github.com/crafcat7/Peakmon/releases/download/20260606/Peakmon.app.zip"
  sha256 "794f4a6ec06119f9c99772ef09f7b6f475b6f860d94753c9b3563caeacf1c1ff"
  license "Apache-2.0"
  version "1.3.1"

  depends_on :macos => :sonoma

  def install
    # Homebrew's zip unpack strategy strips the single top-level
    # directory, so the working directory IS the unpacked
    # `Peakmon.app` bundle. Copy its contents into the Cellar
    # under a fresh `Peakmon.app` directory.
    (prefix/"Peakmon.app").install Dir["Contents"]
  end

  def caveats
    <<~EOS
      Peakmon.app has been installed to:
        #{opt_prefix}/Peakmon.app

      Because Peakmon needs to read system-level metrics (IOReport,
      HID sensors, libproc), it ships with App Sandbox intentionally
      disabled and is ad-hoc signed. On first launch you may need to
      right-click the app and choose "Open" to bypass Gatekeeper.

      To launch Peakmon from the command line:
        open #{opt_prefix}/Peakmon.app

      To add Peakmon to your /Applications folder:
        ln -sfn #{opt_prefix}/Peakmon.app /Applications/Peakmon.app
    EOS
  end

  test do
    assert_predicate prefix/"Peakmon.app", :exist?
    assert_predicate prefix/"Peakmon.app/Contents/MacOS/Peakmon", :executable?
  end
end
