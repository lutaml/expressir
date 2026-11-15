# frozen_string_literal: true

# The per-file RSS profiler: prints memory growth per spec file as the
# suite runs (the CI leak map — the suite's single-process memory
# growth is a leak to fix, not a size constraint). Load with:
#   rspec --require ./tools/rss_formatter --format RssFormatter
class RssFormatter
  RSpec::Core::Formatters.register self, :example_group_started, :example_group_finished, :close

  def initialize(_output)
    @file = nil
    @start = {}
    @order = []
    @baseline = rss_mb
  end

  def rss_mb
    `ps -o rss= -p #{Process.pid}`.to_i / 1024
  end

  def example_group_started(notification)
    file = notification.group.metadata[:file_path]
    return if file == @file

    if @file
      delta = rss_mb - @start[@file]
      puts format("RSS %-9s %+5d MB  %s", "#{rss_mb}MB", delta, @file)
    end
    @file = file
    @start[file] = rss_mb unless @start.key?(file)
  end

  def example_group_finished(_notification); end

  def close(_notification)
    if @file
      delta = rss_mb - @start[@file]
      puts format("RSS %-9s %+5d MB  %s", "#{rss_mb}MB", delta, @file)
    end
    puts format("RSS total growth: %d MB", rss_mb - @baseline)
  end

  def method_missing(*) end

  def respond_to_missing?(*)
    true
  end
end
