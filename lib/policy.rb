class Policy
  attr_reader :min_page_count

  def initialize(options)
    @min_page_count = options.fetch(:min_page_count)
  end
end
